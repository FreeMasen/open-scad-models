import { mkdir, readdir, stat } from "node:fs/promises";
import { join, dirname } from "node:path";
import { exec } from "node:child_process";
import { writeFile } from "node:fs";


const ROOT_PATH = "models";
const SITE_PATH = "site"
const RENDERS_PATH = join(SITE_PATH, "renders");
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

let render = async (src, dest) => {
    return await exec_async(
        `xvfb-run --auto-servernum --server-args "-screen 0 1024x768x24" openscad -o "${dest}" -P default "${src}"`
    );
};

let hbs = async (params) => {
    return await exec_async(`hbs --data "${params}" -o "${SITE_PATH}" -- "templates/index.hbs"`)
};


(async () => {
    let paths = await collect_all_paths(ROOT_PATH);
    let params = {
        stls: {},
    };
    try {
        await mkdir(RENDERS_PATH, {
            recursive: true,
        });
    } catch { }
    for (let path of paths) {
        let dest = path.replace(ROOT_PATH, RENDERS_PATH).replace(SCAD_RE, ".stl");
        let dir = dirname(dest);
        await mkdir(dir, {
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
        await render(path, dest);
    }
    await writeFile(PARAMS_PATH, JSON.stringify(params));
    await hbs(PARAMS_PATH);
    return "complete!";
})().then(console.log);
