
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


module plate(centering_targets) {
        
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
    side_hole_h_offset = 27.72;
    top_hole_v_offset = 1.2;
    mid_hole_v_offset = 37.21-4; // how far down from the top edge; bigger = lower
    bottom_hole_v_offset = 61.8-4;
    top_bottom_h_shift = .575; // shifts the four corners; bigger = inwards

    prism_screw_dia = 1.5; 
    prism_screw_coords = [
        [top_edge - top_hole_v_offset, 0], // top center
        [top_edge - top_hole_v_offset, side_hole_h_offset - top_bottom_h_shift], // top right
        [top_edge - top_hole_v_offset, -side_hole_h_offset  + top_bottom_h_shift], // top left

        [top_edge - mid_hole_v_offset, side_hole_h_offset], // middle right
        [top_edge - mid_hole_v_offset, -side_hole_h_offset], // middle left

        [top_edge - bottom_hole_v_offset, 0], // bottom middle
        [top_edge - bottom_hole_v_offset, side_hole_h_offset  - top_bottom_h_shift], // bottom right
        [top_edge - bottom_hole_v_offset, -side_hole_h_offset + top_bottom_h_shift], // bottom left

        ]; // screws for attaching the plate upwards to the prism

    // alignment holes
    align_v_offset = 1;
    align_h_offset = 17.5 / 2;
    align_hole_dia = 2;


    module prism_holes(dia) {
        for(i = [0: len(prism_screw_coords) - 1]) {
            p = prism_screw_coords[i];
            translate([p[0], p[1]]) {
                circle(d=dia);
            }
        } 
    }

    module align_holes(dia) {
        // alignment holes
        copy_mirror([0,1]) {
            translate([top_edge - align_v_offset, align_h_offset]) {
                circle(d=dia);
            }
        }
    }

    difference() {
        // outside
        square([outside_length, outside_width], center=true);
        // hole
        square([inside_length, inside_width], center=true);

        prism_holes(dia = prism_screw_dia);
        align_holes(dia = align_hole_dia);
    }

    // centering targets
    if(centering_targets) {
        echo("adding centering targets");
        target_point_dia = .2;
        prism_holes(dia = target_point_dia);
        align_holes(dia = target_point_dia); 

    }

}

// for printing to PDF
// Remember to make sure scaling on print setup is set to 100%
calib_sq();
plate(centering_targets = true);


// for direct manufacture:
plate(centering_targets = false);