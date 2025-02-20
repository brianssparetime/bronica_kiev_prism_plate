
module copy_mirror(vec){
    children();
    mirror(vec) { children(); }
}

module calib_sq(){
    translate([55, 0, 0]) 
        square([2,10], center=true);
    translate([60,0,0])
    rotate(270)
        text("1cm", size=5, halign="center");
    

}


module plate(centering_targets = cent_targ) {
        
    $fn=48;
    eps = .01;

    // in mm
    plate_thickness = .8;


    // original kiev plate dimensions
    kiev_outside_length = 68; // front to back
    kiev_outside_width  = 65;// side to side across the camera
    // bronica plate dimensions
    outside_length = 61.5; // front to back
    outside_width  = 63.7;// side to side across the camera

    inside_length = 52; // hole in the center to look through
    inside_width = 52; 

    shift_down = 1.5;
    top_edge = outside_length / 2 - shift_down;
    side_hole_h_offset = 28;
    top_hole_v_offset = 1;
    mid_hole_v_offset = 36.7-4;
    bottom_hole_v_offset = 61.5-4;

    prism_screw_coords = [
        [top_edge - top_hole_v_offset, 0], // top center
        [top_edge - top_hole_v_offset, side_hole_h_offset], // top right
        [top_edge - top_hole_v_offset, -side_hole_h_offset], // top left

        [top_edge - mid_hole_v_offset, side_hole_h_offset], // middle right
        [top_edge - mid_hole_v_offset, -side_hole_h_offset], // middle left

        [top_edge - bottom_hole_v_offset, side_hole_h_offset], // bottom right
        [top_edge - bottom_hole_v_offset, 0], // bottom middle
        [top_edge - bottom_hole_v_offset, -side_hole_h_offset], // bottom left

        ]; // screws for attaching the plate upwards to the prism
    prism_screw_dia = 1.5; 

    // alignment holes
    align_v_offset = 1;
    align_h_offset = 17.5 / 2;
    align_hole_dia = 2;

    difference() {
        // outside
        square([outside_length, outside_width], center=true);
        // hole
        square([inside_length, inside_width], center=true);

        // prism screw holes
        for(i = [0: len(prism_screw_coords) - 1]) {
            p = prism_screw_coords[i];
            translate([p[0], p[1]]) {
                circle(d=prism_screw_dia);
            }
        }

        // alignment holes
        copy_mirror([0,1]) {
            translate([top_edge - align_v_offset, align_h_offset]) {
                circle(d=align_hole_dia);
            }
        }

        // centering targets
        // if(cent_targ) {

        // }


    }





    }

    calib_sq();
    plate();