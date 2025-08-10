use <MCAD/boxes.scad>
$qi=6.35;
$fn_value=2;
// $fn_value=100;
module square_pair(x, y) {
    translate([
        x, y, 0
    ])
    // color(c = "green") 
    union() {
        roundedBox(size=[
            $qi,$qi,16
        ], sidesonly=false, radius=0.8, $fn=$fn_value);
        translate([
            $qi/2,
            11,
            0,
        ]) 
        roundedBox(size=[
            $qi*2,$qi*2,16
        ], sidesonly=false, radius=0.8, $fn=$fn_value);
    }
}
$xoff = 15;
$yoff = 22;
module square_quad(x, y) {
    union() {
        square_pair(x = x+0, y = y+0);
        square_pair(x = x+$xoff, y = y+0);
        square_pair(x = x+$xoff, y = y-$yoff);
        square_pair(x = x+0, y = y-$yoff);
    }
}
module square_oct(x, y) {
    $xoff2 = $xoff * 2;
    $yoff2 = $yoff * 2;
    union() {
        square_quad(x = x+0, y = y+0);
        square_quad(x = x+$xoff2, y = y+0);
        square_quad(x = x-$xoff2, y = y+0);
        square_quad(x = x+0, y = y+$yoff2);
        square_quad(x = x+$xoff2, y = y+$yoff2);
        square_quad(x = x-$xoff2, y = y+$yoff2);
        square_quad(x = x-$xoff2, y = y+$yoff2);
    }
}

module cutout() {
    union() {
        square_oct(x = 0, y = 0);
        // square_oct(x = $xoff * 4, y = 0);
        // square_oct(x = 0, y = $yoff * 4);
        // square_oct(x = $xoff * 4, y = $yoff * 4);
    }
}

module main_plate() {
    translate(v = [
        10, 18, 0
    ]) 
    roundedBox(size = [
        94, 90, 3
    ], radius = 0.8, sidesonly = false, $fn=$fn_value);
}

difference() {
    main_plate();
    cutout();
}
