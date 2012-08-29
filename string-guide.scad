// String guide / idler
// GNU GPL v3
// Václav 'ax' Hůla <axtheb@gmail.com>
// Based on Greg Frosts bearing guide and Josef Prusas printable bearing.

include <configuration.scad>

descent_thickness = 3 * layer_height;
guide_height = 7 + descent_thickness;

// thickness of the ring in thinnest part
wall_min_thickness = single_wall_width * 3;
// outer (max) thickness of the ring
wall_max_thickness = wall_min_thickness + 3;
wall_descent = 1;

module string_guide(offset=0.5)
{
    difference()
    {
        union(){
            cylinder(r1 = bearing_radius + wall_max_thickness, r2 = bearing_radius + wall_min_thickness, h = guide_height * offset);
            translate([0, 0, guide_height * offset])
                cylinder(r2 = bearing_radius + wall_max_thickness, r1 = bearing_radius + wall_min_thickness, h = guide_height * (1 - offset));
        }
        translate([0, 0, -1])
            cylinder(r = bearing_radius, h = guide_height + 2);  // putting low $fn may be good idea to assure nice press-fit
    }

    difference()  // flat part inside
    {
        cylinder(r = bearing_radius, h = descent_thickness);
        translate([0, 0, -1])
            cylinder(r = bearing_radius - wall_descent, h = descent_thickness + 2);
    }

}

guide_spacing = 3 + 2 * (bearing_radius + wall_max_thickness);

// there are two idlers with guide in middle, for far inner corners
for(i = [0:1]) {
    translate ([i * guide_spacing, 0, 0]) string_guide();
}
// three idlers with high guide for left side
for(i = [0:2]) {
    translate([i * guide_spacing, guide_spacing, 0]) string_guide(0.35);
}
// three idlers with low guide for right side
for(i = [0:2]) {
    translate([i * guide_spacing, -guide_spacing, 0]) string_guide(0.65);
}
