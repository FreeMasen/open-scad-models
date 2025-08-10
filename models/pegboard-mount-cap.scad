use <MCAD/boxes.scad>

$fn = 12;

module peg() {
    translate(v = [
        0,0,-2
    ]) 
    cylinder(h = 8, r = 2.5);
}
difference() {
// color([0, 1, 0])
roundedBox(size = [
    2, 35, 35
], radius = 0.8, sidesonly = false);

translate(v = [
    0, 12.5, 12.5
])
rotate(a = [
    90, 0, 90
])
// color([1, 0, 1])
peg();

translate(v = [
    0, -12.5, -12.5
])
rotate(a = [
    90, 0, 90
])
// color([1, 1, 0])
peg();

translate(v = [
    0, 12.5, -12.5
])
rotate(a = [
    90, 0, 90
])
// color([1, 0, 0])
peg();

translate(v = [
    0, -12.5, 12.5
])
rotate(a = [
    90, 0, 90
])
// color([0, 0, 1])
peg();

}
