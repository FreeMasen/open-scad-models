

$fn=80;



difference() {
    resize([
        0, 0, 1.5
    ])
    sphere(2.5);
    
    translate([-3, -3, -1.5])
    cube([
        6,
        6, 1.5
    ]);
}

difference() {
    
    translate([
        3.0, 0, 0
    ])
    cylinder(0.3, 0.8, 0.8);

    translate([
        3.0, 0, -0.5
    ])
    cylinder(2, 0.5, 0.5);    
    
}