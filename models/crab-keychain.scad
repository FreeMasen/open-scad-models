
module crab() {
translate([-128.5, -130, 0])
import("/Users/robertmasen/3d/openscad-models/crabbie.stl");
}

module ring(circle_r, torus_r) {
rotate([90, 90, 0])
rotate_extrude(convexity = 10, $fn = 100)
    translate([torus_r, 0, 0])
        circle(r = circle_r, $fn=50);
}

translate([0, 0, 24.5])
ring(1, 2);
crab();
