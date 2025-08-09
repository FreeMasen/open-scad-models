import { mkdir, readdir, stat, writeFile, readFile } from "node:fs/promises";
import { join, dirname } from "node:path";
import { exec } from "node:child_process";


const ROOT_PATH = "models";
const SITE_PATH = "site"
const RENDERS_PATH = join(SITE_PATH, "renders");
const IMGS_PATH = join(SITE_PATH, "img");
const PARAMS_PATH = join(SITE_PATH, "parameters.json");
const SCAD_RE = /\.scad$/;

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
    return await new Promise((r, j) => {
        exec(args,
            (e, out, err) => {
                if (out) {
                    console.log(out);
                }
                if (err) {
                    console.error(err)
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
 * @param {string} params path to parameters
 * @returns 
 */
let hbs = async params => {
    console.log("running hbs");
    try {
        await exec_async(`hbs --data "${params}" -o "${SITE_PATH}" -- "templates/index.hbs"`);
    } catch (e) {
        let p = await readFile(params, "utf-8");
        console.log("params:", p);
    }
};


(async () => {
    console.log("collecting paths");
    let paths = await collect_all_paths(ROOT_PATH);
    let params = {
        stls: {},
        pngs: {},
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
        params.stls[name] = dest;
        params.pngs[name] = img_dest;
        await render_stl(path, dest);
        await render_png(path, img_dest);
    }
    await writeFile(PARAMS_PATH, JSON.stringify(params));
    await hbs(PARAMS_PATH);
    return "complete!";
})().then(console.log);
