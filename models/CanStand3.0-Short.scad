use <MCAD/boxes.scad>
radius=0.8;
leg_length=40;
$fn=100;
// $fn=25;
color([
    1, 0, 0,
    0.2,
])
translate(v = [
    0,
    37.5,
    0,
]) 
rotate(a = [
    0,
    90,
    0,
]) 
roundedBox(size = [
    5, 5, leg_length
], radius = radius, sidesonly = false);

color([
    0, 1, 0,
    0.2,
])
translate(v = [
    0,
    -37.5,
    0,
]) 
rotate(a = [
    0,
    90,
    0,
]) 
roundedBox(size = [
    5, 5, leg_length
], radius = radius, sidesonly = false);

module cross_beam() {
    difference() {
        union() {
            difference() {
                color([
                    0, 1, 1,
                    0.2,
                ])
                translate(v = [
                    0,
                    0,
                    0,
                ]) 
                rotate(a = [
                    0,
                    90,
                    90,
                ]) 
                roundedBox(size = [
                    5, 15, 75
                ], radius = radius, sidesonly = false);

                translate(v = [
                    -0.2,
                    -2.5,
                    -10,
                ]) 
                cube(size = [
                    17.6,
                    5.4,
                    15
                ]);
            }
            translate(v = [
                0,
                2.9,
                0,
            ]) 
            rotate(a = [
                0,
                90,
                0,
            ])
            color([0.1, 0.5, 0.3])
            roundedBox(size = [
                2,
                2,
                15,
            ], radius = radius, sidesonly = false);
        }
        translate(v = [
                0,
                0,
                2,
            ]) 
            rotate(a = [
                0,
                90,
                0,
            ])
            roundedBox(size = [
                2.2,
                2.2,
                35,
            ], radius = radius, sidesonly = false);
    }
}

cross_beam();
