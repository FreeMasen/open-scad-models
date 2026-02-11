use <fillets/fillets3D.scad>
bar_width = 5;
bar_height = 5;
side_length = 180;

module insert(x, z, y = bar_height) {
  difference() {
    cube([x, y, z]);
    color([1, 0, 0, 0.2])
      rotate([0, -5, 0])
        translate([x, -1, -2])
          cube([x, y + 2, z + 2]);
    union() {
      color([1, 0, 0, 0.2])
        rotate([0, 5, 0])
          translate([-x - 0.05, -1, -1])
            cube([x, y + 2, z + 2]);

      color([0, 1, 0, 0.2])
        rotate([5, 0, 0])
          translate([0, y, -1])
            cube([x, y + 2, z + 2]);

      color([0, 1, 1, 0.2])
        rotate([-5, 0, 0])
          translate([0, -y - 2, -1])
            cube([x, y + 2, z + 2]);
    }
  }
}

module body(x, z, y) {
  cube([x, y, z]);
}

  union() {
    topFillet(t=20, r=1
    
    
    
    , s=5)
    insert(15, 20, bar_height);
    bottomFillet(b=-15, r=5, s=5)
    translate([0, 5, -15])
      rotate([0, 0, -90])
        body(5, 15, 15);
  }
