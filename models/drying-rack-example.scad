use <drying-rack-parts/drying-rack-down2.scad>
use <drying-rack-parts/drying-rack-across.scad>
use <drying-rack-parts/drying-rack-across2.scad>
// use <drying-rack-parts/drying-rack-foot.scad>
use <drying-rack-parts/drying-rack-foot2.scad>


rotate([0, 0, 180])
translate([-90, 0, 0]) 
color([1, 0, 0])
{
translate([0, 0, 70]) 
{
    for (i = [0:10]) {
        translate(v = [0, 2.5, i*40])
        cross_member();
        rotate([-1, 180, 0])
        translate(v = [-5, 7, 5 - (i*40)])
        shelf();
        rotate([-1, 180, 180])
        translate(v = [180, 0, -i*40])
        shelf2();
    }

}

translate([0, 3, 0]) 
foot2();
translate([190, 3, 0]) 
foot2();
}
