use <fillets/fillets3D.scad>
use <MCAD/boxes.scad>

bar_width = 5;
bar_height = 5;
side_length = 180;

module insert(x, y, z) {
  topFillet(t=z,r=1,s=5)
  resize([x, y/4, 0])
  cylinder(h = z, r1 = y/2, r2=x/2);
}

module body(x, y, z) {
  topBottomFillet(b=0, t=z,r=1,s=5)
  difference() {
    color([0, 1, 0, 0.2])
    resize([x, y/2, 0])
    cylinder(h = z, r1 = x/2, r2=y/2);
    translate(v = [0, 0, -0.5]) 
    color([1, 0, 0, 0.2])
    insert(15.5, 20.5, 20.5);
  }
}

module connector(x, y, z) {
    difference() {
      translate([-5, 0, 0]) 
      roundedCube(size = [x, y, z], r = 1, sidesonly = false, center = false);
      translate(v = [-7.5, 2.5, 0]) 
      insert(15.5, 20.5, 20.5);
      translate(v = [side_length+2.5, 2.5, 0]) 
      insert(15.5, 20.5, 20.5);
    }
}

module hook() {

module arch_support() {
  topBottomFillet(
    b=0,
    t=bar_width,
    r=1,
    s=15
  )
    difference() {
      cube([
        10, 10, bar_width
      ]);

      translate([0, 0, -1]) 
      cylinder(h = bar_height+2, r = 8);
    }
  }
  
  translate(v = [0, bar_width+(bar_width/2), 8]) 
  roundedCube(size = [bar_width, bar_width, 8], r = 1, sidesonly = false, center = false);
  translate([0, 12.5, 0]) 
    rotate([90, -90, 90])
    arch_support();
}

module cross_member() {
  union() {
    insert(15, 20, 20);
    
    translate([0, 0, -39.9]) 
    body(20, 20, 40);
    
    translate(v = [7.5, -bar_width/2, -40]) 
    connector(x = side_length+10, y = bar_width*1.5, z = 30);

    translate([side_length+10, 0, 0]) 
    union() {
      insert(15, 20, 20);
      translate([0, 0, -39.9]) 
      body(20, 20, 40);
    }
    translate(v = [side_length/4, 2.5, -20]) 
    hook();
    translate(v = [side_length-(side_length/4), 2.5, -20]) 
    hook();
  }
}
