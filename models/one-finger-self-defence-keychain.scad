use <fillets/fillets3D.scad>

inner_r = 25/2;
outer_r = inner_r + 5;
//$fn=30;


difference() {
    topBottomFillet(b =0, t = 10, r = 2, s = 30)
    union() {
        difference() {
            cylinder(10, outer_r, outer_r);
            
            
            cylinder(30, inner_r, inner_r, true);
            
            translate([-outer_r, outer_r-3, -1])
            cube([ outer_r * 2, 11, 20]);
        
        }
        
        
        translate([inner_r-2.8, inner_r+2, 0])
        resize([outer_r+2, 6, 0])
        rotate([0, 0, 135]) {
                
            difference() {
                cube([ outer_r * 2, outer_r * 2, 10]);
                
                translate([0,0,-1])
                rotate([0, 0, 45])
                cube([ outer_r * 3, outer_r * 3, 12]);
            }
            
        }
    }
    
    translate([0, -inner_r-2.5, -1])
    cylinder(12, 2, 2);

}

