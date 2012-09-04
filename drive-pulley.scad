// Drive pulley
// GNU GPL v3
// Václav 'ax' Hůla <axtheb@gmail.com>
// this is really just string guide with few touches. 
// TODO: refactor

include <configuration.scad>

guide_height = 7;

offset=0.47;

// thickness of the ring in thinnest part
wall_min_thickness = 14 - shaft_radius;
// outer (max) thickness of the ring
wall_max_thickness = wall_min_thickness + offset * guide_height;

module drive_pulley()
{
    difference()
    {
        union(){
            cylinder(r = shaft_radius + wall_min_thickness, h = guide_height);
            cylinder(r1 = shaft_radius + wall_max_thickness, r2 = shaft_radius + wall_min_thickness, h = guide_height * offset);
            translate([0, 0, guide_height * (1 - offset)])
                cylinder(r2 = shaft_radius + wall_max_thickness, r1 = shaft_radius + wall_min_thickness, h = guide_height * offset);
        }
        translate([0, 0, -1])
            cylinder(r = shaft_radius, h = guide_height + 2);  // putting low $fn may be good idea to assure nice press-fit
    }
}

pulley_spacing = 3 + 2 * (shaft_radius + wall_max_thickness);

for(i = [0:1]) {
    translate ([i * pulley_spacing, 0, 0]) drive_pulley();
}
