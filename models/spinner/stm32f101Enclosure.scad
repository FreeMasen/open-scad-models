use <MCAD/boxes.scad>

res=25;

length=53.6;
width=18.6;
height=25;

module stm32f101_footprint() {
    translate(v = [
        0,
        0,
        (height/2)
    ]) 
    // color(c = [
    //     1,1,0.3,0.5,
    // ])
    cube(size = [
        length, width, height,
    ], center=true);
}

module stm32f101_container() {
    // color(c = [
    //     0, 1, 1, 0.5
    // ])
    roundedBox(size=[
            length+5, width+5, height/2,
        ], sidesonly=false, radius=0.8, $fn=res);
}
module stm32101_enclosure() {
    difference() {
        stm32f101_container();
        translate(v = [
            0,
            0,
            -3
        ]) 
        stm32f101_footprint();
        // color(c = [
        //     0.5,
        //     0.5,
        //     1,
        //     0.5
        // ])
        translate(v = [
            -25,
            0,
            5.01
        ]) 
        cube(size = [
            25,
            width - (4.5 * 2),
            16
        ], center=true);
    }
}
