use <MCAD/boxes.scad>

$fn = 100;

module peg() {
    difference() {
        cylinder(h = 8.5, r = 2.4);
        translate(v = [
            0, 0, -1
        ]) 
        cylinder(h = 10, r = 1.5);
    }
}


module cone(
    head_d, head_h
) {
    // the head :
    // a cone
    head_r = head_d / 2;
    // prepare a triangle
    tri_base = head_r;
    tri_height = head_h;
    tri_points = [[0     , 0],
                [tri_base, 0],
                [0       , tri_height]];
    // rotation around X-axis and then 360° around Z-axis
    // put it on top of the rocket's body
    rotate_extrude(angle = 360)
        polygon(tri_points);
}

peg_offset = 12.5;

union() {
    for (x = [peg_offset, -peg_offset]) {
        for (z = [peg_offset, -peg_offset]) {
            echo(x, z)
            translate(v = [
                0, x, z
            ])
            rotate(a = [
                90, 0, 90
            ])
            peg();
        }
    }


    difference() {
        color([0, 1, 0, 0.5])
            roundedBox(size = [
                5, 35, 35
            ], radius = 0.8, sidesonly = false);

        for (x = [peg_offset, -peg_offset]) {
            for (z = [peg_offset, -peg_offset]) {
                echo(x, z)
                translate(v = [
                    -4, x, z
                ])
                rotate(a = [
                    90, 0, 90
                ])
                cylinder(h = 10, r = 1.5);
            }
            
        }

        rotate(a = [
            0, -90, 0  
        ])
        translate(v = [
            0, 0, -5
        ])
        cone(14, 11.7);
    }
}
