// v2.3.0에 대한 스크립트 어셋 변경됨 자세한 정보는
function draw_sprite_pie_reverse(sprite, subimage, _x, _y, startangle, endangle, color, alpha, xsize = pointer_null, ysize = pointer_null)
{
	if (xsize == pointer_null)
		var width = sprite_get_width(sprite);
	else
		var width = sprite_get_width(sprite) * xsize;
	if (ysize == pointer_null)
		var height = sprite_get_height(sprite);
	else
		var height = sprite_get_height(sprite) * ysize;
	
	var texel_x = 0.5 / width;
	var texel_y = 0.5 / height;
	draw_primitive_begin_texture(pr_trianglefan, sprite_get_texture(sprite, subimage));
	draw_vertex_texture_color(_x, _y, 0.5, 0.5, color, alpha);
	while (1) {
	 var angle = degtorad(startangle);
	 var dx = -min(abs(tan(angle + pi / 2)), 1) * sign(cos(angle));
	 var dy = min(abs(tan(angle)), 1) * sign(-sin(angle));
	 draw_vertex_texture_color(_x + width * 0.5 * dx, _y + height * 0.5 * dy, dx / 2 + 0.5 + texel_x, dy / 2 + 0.5 + texel_y, color, alpha);
	 if (startangle = endangle)
	  break;
	 var next = floor(startangle / 45 + 1) * 45;
	 if (next >= endangle)
	  startangle = endangle;
	 else
	  startangle = next;
	}
	draw_primitive_end();
}