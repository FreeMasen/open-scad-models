
res=125;

module half_hard_oval() {
    union() {
        square(size = [
            5,5
        ], center=true);
        translate(v = [
            2.5,
            0,
            0
        ]) 
        circle(r = 2.5, $fn=res);
    }
}

difference() {
    union() {
        translate(v = [0,0,2.5]) 
        rotate_extrude($fn=res)
        translate([13, 0, 0])
        half_hard_oval();
        translate(v = [
            0,
            0,
            108,
        ])
        cylinder(h = 15, r = 2.5, $fn=res);
        translate(v = [
            0,
            0,
            100,
        ]) 
        cylinder(h = 13, r = 5, $fn=res);
        cylinder(h = 110, r = 12, $fn=res);
        
    }
    translate(v = [
        0,
        0,
        -0.2
    ]) 
    cylinder(h = 150, r = 1.9/2, $fn=res);
    translate(v = [
        -0.5,-5,120
    ]) 
    cube(size = [
        1,
        20,
        10
    ]);
}
