res=12;
res=125;

leg_width=14.6;

module to_subtract() {
    len=100;
    translate([
        -leg_width/2,
        -len/2
    ]) 
    union() {
        cube([
            leg_width,
            len,
            3,
        ], $f=res);
        rotate([0, 0, 90])
        translate([
            ((len/2)-(leg_width/2)),
            -((len/2)+(leg_width/2)),
            0,
        ]) 
        cube([
            leg_width,
            len,
            3,
        ]);
    }
}

height=75;
module base() {
    len=90;
    leg_width=leg_width+4;
    translate([
        -leg_width/2,
        -len/2
    ]) 
    union() {
        cube([
            leg_width,
            len,
            height,
        ], $f=res);
        rotate([0, 0, 90])
        translate([
            ((len/2)-(leg_width/2)),
            -((len/2)+(leg_width/2)),
            0,
        ]) 
        cube([
            leg_width,
            len,
            height,
        ], $f=res);
        
    }
}

difference() {
    // color([0,1,0, 0.5])
    union() {
        base();
        linear_extrude(height = 5, $fn=res) 
        circle(d = 95);
    }
    // color([0,0,1, 0.5])
    translate([
        0,
        0,
        height-2.8,
    ]) 
    to_subtract();
}
