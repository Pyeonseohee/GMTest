if (isSurfaceField) {
	if (surface_exists(element_surface)) {
		gpu_push_state();
		gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
		draw_surface_ext(element_surface,x,y,1,1,0,c_white,total_opacity);
		gpu_pop_state();
	}
	
	if (IsUIDebugging()) {
		draw_set_alpha(0.5);
		draw_set_color(c_orange);
		draw_rectangle(x,y,x+total_width,y+total_height,1);
	}
	exit;
}
else 
	if (element_surface != -1)
		exit;
UIElementDraw(x,y,x+total_width,y+total_height);