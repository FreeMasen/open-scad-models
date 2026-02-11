use <fillets/fillets2d.scad>

$fn=30;

hO=30;

dO=43;
rO=dO/2;

dM=40;
rM=dM/2;

height=35;
bottom_height=12;

union() {
    
    difference() {
        color([0,1,0])
        cylinder(height, rO, rO);
        
        color([1,0,1])
        translate([0, 0, 8])
        cylinder(height, rM, rM);
        
        translate([
            -6.5,
            15,
            1
        ])
        cube([
            15,
            12,
            6.5
        ]);
        
        color([0.2, 0.1, 0.3])
        translate([0,6,1])
        linear_extrude(25.1)
        rounding2d(1)
        fillet2d(4)
        square([19, 22], center = true);
        
        translate([0,-12,3])
        cylinder(20, 5, 5);
        
        translate([0,-12,-3])
        cylinder(20, 2, 2);
        
    }
    translate([0, 0, 8])
    difference() {
        
        cylinder(height-8-5, rO-1, rO-1);
        translate([0, 0, -2])
        cylinder(height, rO-2.5, rO-2.5);
    }
}