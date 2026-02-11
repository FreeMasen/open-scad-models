use <MCAD/boxes.scad>
use <MCAD/triangles.scad>
use <fillets/fillets2D.scad>
use <fillets/fillets3D.scad>

translate([0, 0.2, 100])
rotate([-25, -5, 0])
linear_extrude(2.5)
rounding2d(8)
square([23.5, 30]);

translate([0, 45-22.3, 50])
rotate([25, 5, 0])
linear_extrude(2.5)
rounding2d(8)
square([23.5, 30]);


translate([-4, 43, 28])
rotate([90, 90, 0])
linear_extrude(5)
rounding2d(0.2)
polygon([[0, 25], [25, 0], [25, 25]]);

translate([-4, 33, 28])
rotate([90, 90, 0])
linear_extrude(5)
rounding2d(0.2)
polygon([[0, 25], [25, 0], [25, 25]]);

translate([-4, 20, 28])
rotate([90, 90, 0])
linear_extrude(5)
rounding2d(0.2)
polygon([[0, 25], [25, 0], [25, 25]]);

translate([-4, 10, 28])
rotate([90, 90, 0])
linear_extrude(5)
rounding2d(0.2)
polygon([[0, 25], [25, 0], [25, 25]]);

translate([-2, 1, 4])
rotate([0, -44.5, 0])
linear_extrude(2.5)
rounding2d(8)
square([37, 48]);

module vert_hollow() {
    color([0, 1, 0, 0.1])
    translate([1.25, 1.25, 2])
        roundedCube([
        22.5, 47.5, 125
        ], 8, false);
    
}

module tower() {
    difference() {
        
        roundedCube([
        25, 50, 125
        ], 8, false);
    
    translate([-2, -2, 117])
        cube([30, 60, 10]);
    }
    
}

//translate([10, 0, 0])
color([0, 1, 0, 0.5])
difference() {
    union() {

        tower();
difference() {
    translate([-100, 0, 35])
        rotate([0, 90, 0])
        roundedCube([
        35, 50, 125
        ], 8, false);
    
    translate([-100, 0, 22.2])    
        cube([125, 50, 10]);
}
    }
    vert_hollow();
    translate([-99, 1.25, 47.5])
rotate([0, 90, 0])
roundedCube([
    40, 47.5, 120
    ], 7, false);
}





