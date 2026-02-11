use <MCAD/boxes.scad>
// use <fillets/fillets3D.scad>

$fn=50;
module long_side() {
    union() {
        translate([0, -18, 1.37])
        roundedCube([
                10, 20, 3.63
                ], 1, false);
        translate([0, -18, 1.37])
        roundedCube([
                10, 20, 3.63
                ], 1, false);
        difference() {
            roundedCube([
                10, 10, 5
                ], 1, false);
            translate([.8, -1.5, 0])
            cube([8.5,10.5, 1.5]);
        }
    }
}

union() {
    long_side();

    translate([10, 0, 11])
    rotate([0, 180, 0])
    long_side();
    
    translate([0, -20, 1.37])
    roundedCube([
        10, 5, 8.26
        ], 1, false);
}