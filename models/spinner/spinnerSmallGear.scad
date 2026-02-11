
include <BOSL2/std.scad>
include <BOSL2/gears.scad>

use <spinnerWheel.scad>

$fn=25;

spur_gear(4, 12, 5);


translate([23, 23, 0])
spur_gear(5, 30, 5);

translate([0, 0, -2])
color([1, 0, 0, 0.8])
difference() {
    union() {
        spinnerWheel(radius = 8, $fn=res);
        translate(v = [
            0,
            0,
            5
        ]) 
        cylinder(h = 3, r = 2, $fn=res);
    }
    cylinder(h = 11, r = 1.9/2, $fn=res);
}

color([0, 1, 0, 0.8])
translate([23, 23, 0])
difference() {
    spinnerWheel(radius = 25, holeDiameter=2.9, $fn=res);
    translate(v = [
        0,
        0,
        1.5
    ]) 
    cylinder(h = 5, r = 4, $fn=res);
}