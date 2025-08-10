use <MCAD/boxes.scad>

radius=1;
$fn=50;


translate(v = [
    0,0,25
]) 
union() {
    difference() {
        
        roundedBox(size = [
            25, 25, 50
        ], radius = radius, sidesonly = false);

        translate(v = [
            0,0,5
        ])
        rotate(a = [
         0,13, 0   
        ]) 
        roundedBox(size = [
            80, 15, 50
        ], radius = radius, sidesonly = false);
    }
    translate(v = [
        0, 17, 23
    ]) 
    roundedBox(size = [
        25, 22, 5
    ], radius = radius, sidesonly = false);
    translate(v = [
        0, 27, 16
    ]) 
    roundedBox(size = [
        25, 2, 15
    ], radius = radius, sidesonly = false);
    // color([1,0,0])
    translate(v = [
        0, -9, 0
    ]) 
    roundedBox(size = [
        25, 5, 50
    ], radius = radius, sidesonly = false);
    // color([0,1,0])
    translate(v = [
        0, 8.5, 0
    ]) 
    roundedBox(size = [
        25, 5, 50
    ], radius = radius, sidesonly = false);
}
