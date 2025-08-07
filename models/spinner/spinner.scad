use <MCAD/boxes.scad>
use <stm32f101Enclosure.scad>
use <postSupport.scad>

res=40;

bodyWidth=23.3;
bodyHeight=18.8;
bodyDepth=12.3;
flangeDepth=2.6;
flangeLength=(32-23.1)/2;
flangePos=16.2;
baseHolesStart=-13;

module servo_box_inner() {
    rotate(a = [0,-90,0]) 
    difference() {
        translate(v = [0,0,(bodyHeight/2)]) 
        roundedBox(size = [
            bodyWidth + 12,
            bodyDepth + 2,
            flangePos+2,
        ], sidesonly=false, radius=0.8, $fn=res);
        translate(v = [1,0,(bodyHeight/2)+2]) 
        roundedBox(size=[
            bodyWidth,
            bodyDepth,
            bodyHeight,
        ], sidesonly=false, radius=0.8, $fn=res);
        translate(v = [
            13,
            0,
            4,
        ])
        roundedBox(size = [
            10,
            12.3,
            4,
        ], radius = 0.8, sidesonly = false,$fn=res);
    }
}

module servo_box() {
    difference() {
        servo_box_inner();
        translate(v = [
            -17.5,
            0,
            1 
        ])
        cube(size = [
            15,
            2.4,
            31
        ], center=true);
    }
}

module base_base() {
    translate(v = [
        45,
        0,
        -19,
    ])
    roundedBox(size = [
        135,
        65,
        5,
    ], radius = 0.8, sidesonly = false, $fn=res);
}
module base() {
    base_base();
}

module post(height) {
    union() {
        roundedBox(size = [
            5,
            15,
            height,
        ], radius = 0.8, sidesonly = false, $fn=res);
    }
}

module posts() {
    translate(v = [
        -17,
        22.5,
        -18,
    ])
    postSupport(height = 40);
    translate(v = [
        103,
        23,
        10,
    ])
    post(55);
    translate(v = [
        -17,
        -24,
        -18,
    ])
    postSupport(height = 40);

    translate(v = [
        103,
        -23,
        10,
    ])
    post(55);
    translate(v = [
        -18,
        -24,
        10,
    ]) 
    post(55);
    rotate(a = [
        0,0,180
    ])
    translate(v = [
        -103,
        22,
        -18,
    ]) 
    postSupport(height = 40);
    translate(v = [
        -18,
        23,
        10,
    ]) 
    post(55);
    rotate(a = [
        0,
        0,
        180,
    ]) 
    translate(v = [
        -103,
        -24,
        -18,
    ])
    postSupport(height = 40);
}

translate(v = [
    4.5,
    0,
    -1,
]) 
servo_box();

difference()  {
    posts();

    translate(v = [
        -21,
        23,
        30,
    ])
    rotate(a = [
        0,
        90,
        0,
    ])
    cylinder(h = 130, r = 3);

    translate(v = [
        -21,
        -23,
        30,
    ])
    rotate(a = [
        0,
        90,
        0,
    ])
    cylinder(h = 130, r = 3);
}
difference() {
    union() {
        base();
        translate(v = [
            40,
            0,
            -12,
        ]) 
        rotate(a = [
            0,
            0,
            90,
        ]) 
        stm32101_enclosure();
    }
    for ( i = [0:1:22] ) {
        if(i != 8
        && i != 9 
        && i != 12
        && i != 13)
        let (x = (i * 5) + baseHolesStart) {
            translate(v = [
                x,
                0,
                -17.1
            ])
            roundedBox(size = [
                2,
                55,
                10,
            ], radius = 0.5, sidesonly = false);
        }
    }
}
