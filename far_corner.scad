include <configuration.scad>

for(i = [0:3]) {
    translate([0, 35 * i, 0]) {
        bearing_bed(holes=( i % 2 == 0) );
    }
}
