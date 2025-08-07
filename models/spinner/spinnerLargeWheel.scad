use <spinnerWheel.scad>
res=125;
difference() {
    spinnerWheel(radius = 25, holeDiameter=2.9, $fn=res);
    translate(v = [
        0,
        0,
        1.5
    ]) 
    cylinder(h = 5, r = 4, $fn=res);
}
