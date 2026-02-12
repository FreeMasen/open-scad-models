import { mkdir, readdir, stat, writeFile, readFile } from "node:fs/promises";
import { join, dirname } from "node:path";
import { exec } from "node:child_process";
import { fileURLToPath } from 'node:url';
import { stdout } from "node:process";

const repo_root = (() => {
    console.log(process.argv.length, process.argv);
    if (process.argv[2]) {
        return process.argv[2];
    }
    return join(dirname(fileURLToPath(import.meta.url)), "..");
})();

const ROOT_PATH = join(repo_root, "models");
const SITE_PATH = join(repo_root, "site")
const RENDERS_PATH = join(SITE_PATH, "renders");
const IMGS_PATH = join(SITE_PATH, "img");
const TEMPLATES_PATH = join(repo_root, "templates");
const PARAMS_PATH = join(SITE_PATH, "params.json");
const SCAD_RE = /\.scad$/;
const TOP_LEVEL_ERROR_MESSAGE = "Current top level object is empty";

/**
 * collect all file paths
 * @param {string} root root path
 * @returns {string[]}scad file paths found
 */
let collect_all_paths = async root => {
    let files = await readdir(root);
    let ret = [];
    for (let f of files) {
        let p = join(root, f);
        let s = await stat(p);
        if (s.isDirectory()) {
            ret.push(...(await collect_all_paths(p)));
        } else if (f.endsWith(".scad")) {
            ret.push(p);
        }
    }
    return ret;
};

let exec_async = async args => {
    console.log("execing", args);
    return await new Promise((r, j) => {
        exec(args,
            (e, out, err) => {
                if (out) {
                    console.log("stdout:");
                    console.log(out);
                    console.error("----------");
                }
                
                if (err) {
                    console.error("stderr:")
                    console.error(err)
                    console.error("----------");
                }
                if (out.includes(TOP_LEVEL_ERROR_MESSAGE) 
                    || (e && e.message.includes(TOP_LEVEL_ERROR_MESSAGE))
                    || err.includes(TOP_LEVEL_ERROR_MESSAGE)) {
                    return r();
                }
                if (e) {
                    return j(e);
                }
                return r();
            });
    });
}

let render_stl = async (src, dest) => {
    let cmd_parts = [
        "xvfb-run",
        "--auto-servernum",
        "--server-args",
        '"-screen 0 1024x768x24"',
        "openscad",
        "-o", dest,
        "-P", "default",
        "-D__RENDER_MODULE=true",
        src
    ]
    
    if (process.platform == "darwin") {
        let part;
        while (part != "openscad") {
            part = cmd_parts.shift()
        }
        cmd_parts.unshift("/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD")
    }
    console.log("rendering", src);
    return await exec_async(
        cmd_parts.join(" ")
    );
};

/**
 * 
 * @param {string} src The scad source
 * @param {string} dest The path to write to
 * @returns 
 */
let render_png = async (src, dest) => {
    let cmd_parts = [
        "xvfb-run",
        "--auto-servernum",
        "--server-args",
        '"-screen 0 1024x768x24"',
        "openscad",
        "-o", dest,
        " --imgsize=512,512",
        "-P", "default",
        "-D__RENDER_MODULE=true",
        src
    ]
    console.log("rendering png", src);
    return await exec_async(
        cmd_parts.join(" ")
    );
};

/**
 * 
 * @param {string} params path to parameters
 * @returns 
 */
let hbs = async params => {
    console.log("running hbs");
    let template = join(TEMPLATES_PATH, "index.hbs");
    try {
        await exec_async(`hbs --data '${params}' -o '${SITE_PATH}' -- '${template}'`);
    } catch (e) {
    }
    let p = await readFile(params, "utf-8");
    console.log("params:", p);
};


(async () => {
    console.log("collecting paths");
    let paths = await collect_all_paths(ROOT_PATH);
    let params = {
        models: {},
    };
    await mkdir(SITE_PATH, {
        recursive: true,
    });
    await mkdir(IMGS_PATH, {
        recursive: true,
    });
    for (let path of paths) {
        let dest = path.replace(ROOT_PATH, RENDERS_PATH).replace(SCAD_RE, ".stl");
        let img_dest = path.replace(ROOT_PATH, IMGS_PATH).replace(SCAD_RE, ".png");
        let dir = dirname(dest);
        let img_dir = dirname(img_dest);
        console.log("ensuring", dir);
        await mkdir(dir, {
            recursive: true,
        });
        console.log("ensuring", img_dir);
        await mkdir(img_dir, {
            recursive: true,
        });
        let name = path
            // remove extension
            .replace(SCAD_RE, "")
            // remove root path
            .replace(ROOT_PATH, "")
            // remove leading forward slash
            .replace("/", "")
            // replace remaining forward slashes with underscores
            .replaceAll("/", "_");
        params.models[name] = {
            stl: dest.replace([SITE_PATH, "/"].join(""), ""),
            img: img_dest.replace([SITE_PATH, "/"].join(""), ""),
        };
        await render_stl(path, dest);
        await render_png(path, img_dest);
    }
    await writeFile(PARAMS_PATH, JSON.stringify(params));
    await hbs(PARAMS_PATH);
    return "complete!";
})().then(console.log);
