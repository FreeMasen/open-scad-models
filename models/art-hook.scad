use <MCAD/boxes.scad>

radius = 1;
red = [1, 0, 0];
blue = [0, 0, 1];
green = [0, 1, 1];
yellow = [1, 1, 0];
orange = [1, 0.65, 0];
cyan = [0, 0.75, 0.9];

module art_hook(
  width,
  support_angle,
  trim_front,
) {

  difference() {
    translate(
      v=[
        0,
        0,
        25,
      ]
    )
      union() {
        difference() {
          color(orange)
            roundedBox(
              size=[
                width,
                25,
                50,
              ], radius=radius, sidesonly=false
            );

          translate(
            v=[
              0,
              0,
              5,
            ]
          )
            rotate(
              a=[
                0,
                support_angle,
                0,
              ]
            )
              roundedBox(
                size=[
                  80,
                  15,
                  50,
                ], radius=radius, sidesonly=false
              );
        }
        color(yellow)
          translate(
            v=[
              0,
              17,
              23,
            ]
          )
            roundedBox(
              size=[
                width,
                22,
                4,
              ], radius=radius, sidesonly=false
            );
        color(cyan)
          translate(
            v=[
              0,
              27,
              16,
            ]
          )
            roundedBox(
              size=[
                width,
                2,
                15,
              ], radius=radius, sidesonly=false
            );
        color(red)
          translate(
            v=[
              0,
              -9,
              0,
            ]
          )
            roundedBox(
              size=[
                width,
                5,
                50,
              ], radius=radius, sidesonly=false
            );
        color(green)
          translate(
            v=[
              0,
              8.5,
              0,
            ]
          )
            roundedBox(
              size=[
                width,
                5,
                50,
              ], radius=radius, sidesonly=false
            );
      }
    if (trim_front) {
      translate([0, 28.6, 50.6])
        rotate([45, 0, 0])
          color(blue)
            roundedBox(size=[width + 10, 5, 15], radius=radius, sidesonly=false);
    }
  }
}
