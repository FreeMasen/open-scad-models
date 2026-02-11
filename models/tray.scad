use <fillets/fillets3d.scad>
use <MCAD/boxes.scad>


$fn=125;

module half_rounded_cube(
    size_x,
    size_y,
    size_z,
    radius,
) {
    difference() {
        translate([0, 0, 0])
        roundedCube([
            size_x,
            size_y,
            size_z + 10
        ], radius, false);
        translate([-0.5, -0.5, size_z])
        cube([size_x+1, size_y+1, 20]);
    }
    
}

module base_tray(
size_x,
size_y,
size_z,
) {
    cutout_floor=max(2.5, size_z*0.3);
    difference() {
        difference() {
            half_rounded_cube(size_x, size_y, size_z, 8);
            translate([2.5, 2.5, 2.5])
            half_rounded_cube(size_x-5, size_y-5, size_z, 7);
            translate([
                0,
                0, cutout_floor+0.01
            ])
            cube([size_x+3, 8, size_z-cutout_floor]);
        }
        opp=size_z-cutout_floor;
        adj=size_y-7.5;
        hyp=sqrt(pow(adj, 2) + pow(opp, 2));
        soh=opp/hyp;
        echo("opp", opp, "adj", adj, "hyp", hyp, "soh", soh, "angle", -asin(soh));
        translate([-0.1, 5, cutout_floor])
        rotate([90, -asin(soh), 90])
        cube([hyp, size_z, 5]);
        
        translate([size_x-4.9, 5, cutout_floor])
        rotate([90, -asin(soh), 90])
        cube([hyp, size_z, 5]);
    }
}

base_tray(200, 200, 15);
