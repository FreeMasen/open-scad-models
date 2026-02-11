use <MCAD/boxes.scad>
radius = 1;
red = [1, 0, 0];
blue = [0, 0, 1];
green = [0, 1, 1];
yellow = [1, 1, 0];
orange = [1, 0.65, 0];
cyan = [0, 0.75, 0.9];
// $fn = 99;
$fn = 25;
module price_tag_hook(
  width,
  support_angle,
  trim_front,
) {
  difference() {
    translate(v=[0, 0, 25])
      union() {
        translate([0, 15.5, -36])
          color(orange)
            roundedBox(size=[width, 15, 3], radius=radius, sidesonly=false);
        translate([0, 17.53, -28])
          color(blue)
            roundedBox(size=[width, 11.1, 3], radius=radius, sidesonly=false);
        translate([0, 21.5, -32])
          rotate([90, 0, 0])
            color(red)
              roundedBox(size=[width, 10, 3], radius=radius, sidesonly=false);
        color(yellow)
          translate(v=[0, 28, 36])
            roundedBox(size=[width, 40, 3], radius=radius, sidesonly=false);
        color(cyan) translate(v=[0, 47, 30])
            roundedBox(size=[width, 2, 15], radius=radius, sidesonly=false);
        color(green)
          translate(v=[0, 8.5, 0])
            roundedBox(size=[width, 3, 75], radius=radius, sidesonly=false);
      }
    if (trim_front) {
      translate([0, 28.6, 50.6])
        rotate([45, 0, 0])
          color(blue)
            roundedBox(size=[width + 10, 5, 15], radius=radius, sidesonly=false);
    }
  }
}
price_tag_hook(10, 0, false);
