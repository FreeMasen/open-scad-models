use <fillets/fillets3D.scad>
use <MCAD/boxes.scad>

bar_width = 5;
bar_height = 5;
side_length = 180;

module foot() {

  module toe() {
    translate([-5.5, 0, 0]) 
    rotate([90, 0, 90])
    topBottomFillet(
      b=0,
      t=10,
      r=1,
      s=15
    )
      union() {
        difference() {
          cube([80, 30, 10]);

          translate([-40, 46, -1])
          rotate([0, 0, -20])
          cube([160, 32, 12]);

          translate([-40, 9, 1])
          rotate([0, 0, -20])
          cube([160, 32, 8]);

        }
      }
  }

  module insert(x, y, z) {
    topFillet(t=z, r=1, s=5)
      resize([x, y / 4, 0])
        cylinder(h=z, r1=y / 2, r2=x / 2);
  }

  module body(x, y, z) {
    topBottomFillet(b=0, t=z, r=1, s=5)
      color([0, 1, 0, 0.2])
        resize([x, y / 2, 0])
          cylinder(h=z, r1=x / 2, r2=y / 2);
  }
  union() {
    translate([0, 0, 29.9])
      insert(15, 20, 20);
    body(20, 20, 30);
    toe();
  }
}
