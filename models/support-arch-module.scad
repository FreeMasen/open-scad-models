

module supportArch() {
    difference() {
        rotate([0, 90, 90])
            translate([-30, 2, -2.5])
            cube([30, 23, 4]);
        
        rotate([0,90,90])
            translate([-0.5, 4.8, -4])
            resize([0, 40, 0])
            cylinder(8, 30, 30);
    }
}

supportArch();