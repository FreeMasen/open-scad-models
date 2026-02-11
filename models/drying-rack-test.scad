use <drying-rack-down2.scad>
use <drying-rack-across.scad>


translate(v = [0, 2.5, 0]) 
cross_member();
rotate([0, 180, 0])
translate(v = [-5, 7, 5]) 
shelf();
