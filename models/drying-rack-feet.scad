use <fillets/fillets3D.scad>
use <MCAD/boxes.scad>

bar_width = 5;
bar_height = 5;
side_length = 180;

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

module connector(x, y, z) {
  difference() {
    translate([-5, 0, 0])
      roundedCube(size=[x, y, z], r=1, sidesonly=false, center=false);
    translate(v=[-7.5, 2.5, 0])
      insert(15.5, 20.5, 20.5);
    translate(v=[side_length + 2.5, 2.5, 0])
      insert(15.5, 20.5, 20.5);
  }
}

module hook() {
  translate(v=[0, 0, -20])
    roundedCube(size=[bar_width, (bar_width * 2) + bar_width / 2, 30], r=1, sidesonly=false, center=false);
  translate(v=[0, bar_width + (bar_width / 2), 0])
    roundedCube(size=[bar_width, bar_width, 15], r=1, sidesonly=false, center=false);
}

module cross_member() {
  union() {
    insert(15, 20, 20);

    translate([0, 0, -39.9])
      body(20, 20, 40);

    translate(v=[7.5, -bar_width / 2, -40])
      connector(x=side_length + 10, y=bar_width * 1.5, z=15);

    translate([side_length + 10, 0, 0])
      union() {
        insert(15, 20, 20);
        translate([0, 0, -39.9])
          body(20, 20, 40);
      }
  }
}

module leg() {
  difference() {
    topBottomFillet(
      b=0,
      t=15,
      r=1,
      s=15
    )
      difference() {

        color([1, 0, 0])
          cube(
            [
              70,
              30,
              15,
            ]
          );

        rotate([0, 0, 20])
          translate([-50, 0, -1])
            color([1, 1, 0, 0.2])
              cube(
                [
                  180,
                  30,
                  17,
                ]
              );
      }

    topBottomFillet(
      b=0,
      t=15,
      r=1,
      s=15
    )
      translate(
        [
          -1,
          -1,
          1,
        ]
      )
        difference() {

          color([1, 0, 0])
            cube(
              [
                80,
                30,
                13,
              ]
            );

          rotate([0, 0, 20])
            translate([-50, 0, -1])
              color([1, 1, 0, 0.2])
                cube(
                  [
                    180,
                    30,
                    17,
                  ]
                );
        }
  }
}


union() {
  cross_member();

  rotate([
    90, 0, 90
  ])
  translate([
    -67,
    -39.9, 
    -8
  ]) 
  leg();
  
  rotate([
    90, 0, 90
  ])
  translate([
    -67,
    -39.9, 
    183
  ]) 
  leg();
}
