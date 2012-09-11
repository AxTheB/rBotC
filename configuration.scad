// printer properties
layer_height = 0.3;
single_wall_width = layer_height * 2.2;

// bot part properties
bearing_radius = 11;
shaft_radius = 2.5;
descent_thickness = 2 * layer_height;
base_height = 4;

module base_with_holes(r=15) {
    difference() {
        cylinder(h=base_height, r2=15, r1=15 + base_height);
        for (angle = [0:17]) {
            rotate([0, 0, angle*20]) {
                translate([16, 0, -1]) rotate([0, 0, 180]) cylinder(r=1, h=base_height+2);
            }
        }
    }
}

// common funcions here
module bearing_base(holes=false) {
    if (holes) {
        base_with_holes();
    } else {
        cylinder(h=base_height, r=15);
    }
    cylinder(h=base_height + descent_thickness + 1, r=7);
    cylinder(h=base_height + descent_thickness + 4.5, r=(8 - single_wall_width) / 2);
}

module bearing_bed(dist=50, holes=false){
    difference() {
        union() {
            translate([-dist/2,0,0]) {
                bearing_base(holes=holes);
            }
            translate([dist/2,0,0]) {
                bearing_base(holes=holes);
            }
            translate([0, 0, base_height / 2]) cube([30, 20, base_height], center = true);
        }

        translate([-dist/2,0,-1]) cylinder(r=1.5, h=30);
        translate([dist/2,0,-1]) cylinder(r=1.5, h=30);
    }
}
