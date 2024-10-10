if (isSurfaceField) {
	// 자신이 서피스 필드 인 경우
	if (!surface_exists(element_surface)) {
		element_surface = surface_create(total_width, total_height);
	}
	else {
		if (surface_get_width(element_surface) != total_width
		|| surface_get_height(element_surface) != total_height)
		   surface_resize(element_surface, abs(total_width), abs(total_height));
	}
	
	surface_set_target(element_surface);
	draw_clear_alpha(c_black, 0);
	surface_reset_target();
}
else {
	if (element_surface == -1)
		exit;
	if (!surface_exists(element_surface.element_surface))
		exit;
	
	// 서피스 타겟이 있을 때 :
	surface_set_target(element_surface.element_surface);
	var _p_x = 0, _p_y = 0;     
	_p_x = element_surface.x;
	_p_y = element_surface.y;
	gpu_push_state();
	gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_inv_src_alpha);
	UIElementDraw(x-_p_x,y-_p_y,x+total_width-_p_x,y+total_height-_p_y);
	gpu_pop_state();
	surface_reset_target();
}