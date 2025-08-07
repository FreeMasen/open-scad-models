use <MCAD/2Dshapes.scad>
res=25;

module spinnerWheel(radius, holeDiameter = 1.9) {
    difference() {
        cylinder(h = 5, r = radius);
        translate(v = [
            0,
            0,
            2.5
        ]) 
        rotate_extrude() 
        translate(v = [
            radius+1,
            0,
            0
        ])
        circle(r = 2.4);
        cylinder(h = 11, r = holeDiameter/2);
        
    }
}
