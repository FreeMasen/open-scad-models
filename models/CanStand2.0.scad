use <MCAD/boxes.scad>

module supportArch() {
    difference() {
        rotate([0, 90, 90])
            translate([-16.5, 14.5, -0.5])
            roundedCube(size=[28, 25, 4], sidesonly=false, radius=0.8, center=true);
        $fn=150;
        rotate([0,90,90])
            translate([-0.5, 1, -4])
            resize([0, 40, 0])
            cylinder(8, 30, 30);
    }
}

$fn=50;
// color([1,0,0])
translate([0, (74/2), (55/2)])
roundedBox(size=[5,5,55], sidesonly=false, radius=0.8);

// color([0,1,0])
translate([0, -(74/2), (55/2)])
roundedBox(size=[5,5,55], sidesonly=false, radius=0.8);

// color([0,0,1])
translate([(74/2), 0, (55/2)])
roundedBox(size=[5,5,55], sidesonly=false, radius=0.8);

// color([1,1,0])
translate([ -(74/2), 0, (55/2)])
roundedBox(size=[5,5,55], sidesonly=false, radius=0.8);

translate([0, 0, 30])
roundedBox(size=[5, 73, 5], sidesonly=false, radius=0.8);

// color([1,0,0])
translate([0, 0, 30])
rotate([0,0,90])
roundedBox(size=[5, 73, 5], sidesonly=false, radius=0.8);

difference() {
    union() {
        // color([0,1,0])
        rotate([0, 90, 90])
        translate([-14.5, 1, 0])
        roundedBox(size=[29, 75, 4], sidesonly=false, radius=0.8);

        // color([0.25,0.5,1])
        rotate([0, 90, 0])
        translate([-14.5, 1, 0])
        roundedBox(size=[29, 75, 2], sidesonly=false, radius=0.8);
    }
    translate(v = [
        0,
        0,
        2,
    ]) 
    resize(newsize = [
        65,65,0
    ]) 
    sphere(r = 28, $fn=150);
}
