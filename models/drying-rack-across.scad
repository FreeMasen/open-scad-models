use <fillets/fillets3D.scad>
use <MCAD/boxes.scad>

bar_width = 5;
bar_height = 5;
side_length = 180;
hyp = sqrt(
  (side_length * side_length) + (side_length * side_length)
);
supp_len = side_length * 0.75;
supp_height = 50;
supp_hyp = sqrt(
  (supp_len * supp_len) + (supp_height * supp_height)
);
supp_width = bar_width * 0.5;
hyp_square = supp_len * 2;

module x_segment() {
  module angle() {
    cube([bar_width * 2, bar_width, bar_height]);
    cube([bar_width, bar_width * 2, bar_height]);
  }
  difference() {
    roundedCube(
      size=[
        bar_width,
        hyp,
        bar_height,
      ], r=1, sidesonly=false, center=false
    );
    translate([bar_width * .5, -bar_width, 0])
      rotate([0, 0, 45])
        angle();
    translate([bar_width * .5, hyp + bar_width, 0])
      rotate([0, 0, 45 - 180])
        angle();
  }
}

module side(
  x = bar_width,
  y = side_length,
  z = bar_height,
) {
  difference() {
    topBottomFillet(b=0, t=bar_height, r=1, s=30)
      cube([x, y, z]);
  }
}

module drying_rack_across() {
  union() {
    union() {
      color([0, 1, 0, 0.5])
        side();
      color([0, 0, 1, 0.5])
        rotate([0, 0, 90])
        translate([0, -2, 0]) 
          side();
      color([1, 0, 1, 0.5])
        rotate([0, 0, 90])
          translate([side_length - bar_width, -3, 0])
            side();
      color([1, 0, 0, 0.5])
        translate([-side_length, 0, 0])
          side();
    }
    union() {
      color([1, 0.3, 0.1, 0.5])
        translate([0, 0, -0.2])
        rotate([0, 0, 45.7])
          x_segment();
      translate([-side_length - 1.5, 2, -0.2])
        rotate([0, 0, -45.7])
          x_segment();
    }
  }
}

module support() {
  rotate([0, -90, 0])
    topBottomFillet(b=0, t=supp_width, r=1, s=30)
      difference() {
        cube([supp_height, supp_len, supp_width]);
        rotate([0, 0, 12.5])
          translate(
            [
              supp_height * .6,
              -( (hyp_square - supp_len) / 2),
              0,
            ]
          )
            cube([supp_height, hyp_square, supp_width]);
      }
}
module shelf() {
  union() {
    translate([bar_width - (bar_width - supp_width) / 2, 0, bar_width - 3])
      rotate([1, 0, 0]) 
      support();
    translate([-side_length + (bar_width - ( (bar_width - supp_width) / 2)), 0, bar_width - 3])
      rotate([1, 0, 0])
      support();
    drying_rack_across();
  }
}

shelf();
