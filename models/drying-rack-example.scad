use <drying-rack-parts/drying-rack-down2.scad>
use <drying-rack-parts/drying-rack-across.scad>
use <drying-rack-parts/drying-rack-feet.scad>

for (i = [0:5]) {
    translate(v = [0, 2.5, i*40])
    color([1, 0, 0])
    cross_member();
    rotate([-1, 180, 0])
    translate(v = [-5, 7, 5 - (i*40)])
    color([1, 0, 0])
    shelf();
}
rotate([0, 0, 180])
translate([-190, -2.5, -40]) 
color([1, 0, 0])
feet();
