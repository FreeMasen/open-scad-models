use <spinnerWheel.scad>
res=125;

difference() {
    union() {
        spinnerWheel(radius = 8, $fn=res);
        translate(v = [
            0,
            0,
            5
        ]) 
        cylinder(h = 3, r = 2, $fn=res);
    }
    cylinder(h = 11, r = 1.9/2, $fn=res);
}
