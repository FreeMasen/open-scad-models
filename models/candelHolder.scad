
width=36;
height=30;

res=150;
difference() {
    resize(newsize=[50,50,30])
        sphere(r=35, $fn=res);
        
        // right
            // color([0,1,0], alpha=0.5)
            translate(v = [width,0, 0]) 
        cube([35,35,35], center=true);
    
        //back
            // color([0.3,1,0], alpha=0.5)
            translate(v = [0,width, 0]) 
        cube([35,35,35], center=true);

    // front
        // color([1,1,0], alpha=0.5)
        translate(v = [0,-width, 0]) 
    cube([35,35,35], center=true);

    //left
        // color([1,1,1], alpha=0.5)
        translate(v = [-width,0, 0]) 
    cube([35,35,35], center=true);

    // top
        // color([0,1,1], alpha=0.5)
        translate(v = [0,0,height]) 
    cube([35,35,35], center=true);
    // bottom
        // color([0,0,0], alpha=0.5)
        translate(v = [0,0,-height+2]) 
    cube([35,35,35], center=true);


        translate(v =[0,0,5]) 
    cylinder(h=17.90, r1=8.5, r2=11, center=true, $fn=res);
}
