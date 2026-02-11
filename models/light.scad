use <fillets/fillets3d.scad>

$fn=12;

hO=30;
hM=3.37;

dO=39;
rO=dO/2;
dM=38;
rM=dM/2;
//dI=23;
dI=37.5;
rI=dI/2;



difference() {
    topFillet(t = hO, r = 7, s = 25)
    color([1,0,0,0.5])
    cylinder(hO, rO, rO);
    
    translate([0, 0, -0.2])
    color([0,0,1,0.5])
    cylinder(hM, rM, rM);
    topFillet(t = hO, r = 7, s = 125)
    color([0,1,0,0.5])
    translate([0, 0, -1.5])
    cylinder(hO, rI, rI);    
}
