// Side holder
// GNU GPL v3
// Václav 'ax' Hůla <axtheb@gmail.com>

include <configuration.scad>

use <string-guide.scad>
use <drive-pulley.scad>

base_height = 4;

module bearing_base() {
    cylinder(h=base_height, r=15);
    cylinder(h=base_height + descent_thickness + layer_height, r=7);
    cylinder(h=base_height + descent_thickness + layer_height + 4, r=(8 - single_wall_width) / 2);
}
%translate ([70, -1, base_height + 0.2])
{
drive_pulley();
// inner wire shadow (that goes to inner far pulley)
translate([0, -14, 4]) rotate([0, 90, 0]) cylinder(r = 0.2, h = 1000, center = true);
// outer wire shadow (which goes around string guide placed in this part and to the carriage
translate([0, 14, 3]) rotate([0, 90, 0]) cylinder(r = 0.2, h = 100, center = true);
}


%translate ([25, 0, base_height + 0.2]) {
string_guide(0.35);
// wire to the carriage
translate([-13, 14 - 50, 4]) rotate([0, 90, 90]) cylinder(r = 0.2, h = 100, center = true);
}

%mirror([1,0,0]) translate ([25, 0, base_height + 0.2]) {
string_guide(0.35);
// wire to the carriage
translate([-13, 14 - 50, 4]) rotate([0, 90, 90]) cylinder(r = 0.2, h = 100, center = true);
}

// distance rod
%translate([0, -518, base_height + 4.2]) rotate([90, 0, 0]) cylinder(r=4, h=1000, center = true);


// *-*-*-*-*-*-*-*-*-*- real part starts here -*-*-*-*-*-*-*-*-*-*

difference() {
    union() {

        // base
        translate([0,-5,base_height / 2]) cube([50, 30, base_height], center = true);
        translate([-25,0,0]) {
            bearing_base();
        }
        translate([25,0,0]) {
            bearing_base();
        }

        // face to carriage
        translate([0,-20,5 + base_height / 2]) cube([50, 4 * single_wall_width, 10 + base_height], center = true);

        // this holds distance rod
        translate([0,-22.5,5 + base_height / 2]) cube([12, 20, 10 + base_height], center = true);
        translate([0,-10,4 + base_height / 2]) cube([10, 40, 8 + base_height], center = true);
    }


    union() {
        // passthru wire 
        translate([0, -15, base_height + 4.2]) rotate([0, 90, 0]) cylinder(r = 2, h = 100, center = true);
        // wires to carriage
        translate([12, 0, base_height + 4.2]) rotate([0, 90, 90]) scale([1.5, 1, 1]) cylinder(r = 2, h = 100, center = true);
        translate([-12, 0, base_height + 4.2]) rotate([0, 90, 90]) scale([1.5, 1, 1]) cylinder(r = 2, h = 100, center = true);
        // distance rod
        translate([0, -28, base_height + 4.2]) rotate([90, 0, 0]) cylinder(r=4, h=20, center = true);
    }

    translate([-25,0,-1]) cylinder(r=1.5, h=30);
    translate([25,0,-1]) cylinder(r=1.5, h=30);
}

translate([0,35,0]) {
    difference() {
        union() {
            translate([-25,0,0]) {
                bearing_base();
            }
            translate([25,0,0]) {
                bearing_base();
            }
            translate([0, 0, base_height / 2]) cube([30, 20, base_height], center = true);
        }

        translate([-25,0,-1]) cylinder(r=1.5, h=30);
        translate([25,0,-1]) cylinder(r=1.5, h=30);
    }
}

