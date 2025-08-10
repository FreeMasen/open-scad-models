
depth=10;

module postSupport(height) {

    difference() {
        // color(c = [
        //     0.2, 0.5, 0,
        // ])
        cube(size = [
            depth,
            2.5,
            height,
        ]);
        translate(v = [
            depth*1.5,
            -1,
            -height/2,
        ]) 
        rotate(a = [
            0,
            -11,
            0
        ]) 
        // color(c = [
        //     0, 0.2, 0.5,
        // ])
        cube(size = [
            depth+2,
            5,
            height*2,
        ]);
    }
}
__RENDER_MODULE = false;
if (__RENDER_MODULE) {
    postSupport(height = 25);
}
