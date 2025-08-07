
res = 25;

difference() {
    union() {
        cylinder(h = 8, r = 2.5, $fn=res);
        cylinder(h = 2, r = 5, $fn=res);
    }
    cylinder(h = 10, r = 1.2, $fn=res);
}
