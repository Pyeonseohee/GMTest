function draw_frame_roundedLineEdge(x1, y1, x2, y2, alpha, scale = 1) {
	draw_frame(x1, y1, x2, y2, sp_frame_1, alpha, scale, 3, 15, 12, c_white);
}

function draw_frame_roundedShadow(x1, y1, x2, y2, alpha, scale = 1) {
	draw_frame(x1, y1, x2, y2, sp_frame_3, alpha, scale, 26, 36, 12, c_white);
}

function draw_frame_roundedEdgeOrange(x1, y1, x2, y2, alpha, scale = 1) {
	draw_frame(x1, y1, x2, y2, sp_frame_2, alpha, scale, 0, 15, 42, c_white);
}

function draw_frame_12rounded(x1, y1, x2, y2, alpha, color, scale = 1) {
	draw_frame(x1, y1, x2, y2, sp_frame_12rounded, alpha, scale, 0, 12, 12, color);
}

function draw_frame_gradation(x1, y1, x2, y2, alpha, color, scale = 1, subimg = 0) {
	draw_frame(x1, y1, x2, y2, sp_frame_gradation, alpha, scale, 0, 24, 24, color, subimg);
}

function draw_frame_32rounded(x1, y1, x2, y2, alpha, color, scale = 1) {
	draw_frame(x1, y1, x2, y2, sp_frame_32rounded, alpha, scale*(3/8), 0, 32, 32, color);
}

function draw_frame_glow1(x1, y1, x2, y2, alpha, color, scale = 1) {
	draw_frame(x1, y1, x2, y2, sp_frame_glow1, alpha*0.6, scale*2, 36, 48, 12, color);
}

/// @description _width는 최대 6
function draw_frame_outlineRounded(x1, y1, x2, y2, alpha, color, scale = 1, _width = 3) {
	if (_width == 0)
		return;
	_width = median(0,_width-1,5);
	draw_frame(x1, y1, x2, y2, sp_frame_roundedLine, alpha, scale, 8, 30, 24, color, _width);
}

function draw_frame_roundedGlow(x1, y1, x2, y2, alpha, intensity = 1, scale = 1) {
	intensity = min(1, intensity);
	draw_frame_12rounded(x1, y1, x2, y2, alpha, make_color_rgb(255,221,97), scale);
	gpu_set_blendmode(bm_add);
	draw_frame(x1, y1, x2, y2, sp_frame_glow1, alpha*0.6*intensity, scale*2*(0.7+intensity*0.3), 36*(0.7+intensity*0.3), 48, 12, make_color_rgb(255,155,54));
	gpu_set_blendmode(bm_normal);
}

function draw_textFrame(text, x1, y1, x2, y2, color = c_white, xscale = 1, yscale = 1, alpha = 1,  overflow = 0, margin = 0, align = 8, _font = global.FontDefault, isBold = false, isLabel = false) {
	draw_set_font(_font);
	
	if (x1 > x2) { var _temp = x1; x1 = x2; x2 = _temp; }
	if (y1 > y2) { var _temp = y1; y1 = y2; y2 = _temp; }
	
	if (margin*2 > x2 - x1 || margin*2 > y2 - y1) {return;}
	
	var point_x, point_y;
	if (margin != 0) {
		x1 += margin;
		y1 += margin;
		x2 -= margin;
		y2 -= margin;
	}
	
	switch (align) {
		case AL_LEFTTOP :
			draw_set_valign(fa_top);
			draw_set_halign(fa_left);
			point_x = x1
			point_y = y1
			break;
		case AL_RIGHTTOP :
			draw_set_valign(fa_top);
			draw_set_halign(fa_right);
			point_x = x2
			point_y = y1
			break
		case AL_LEFTDOWN :
			draw_set_valign(fa_bottom);
			draw_set_halign(fa_left);
			point_x = x1
			point_y = y2
			break
		case AL_RIGHTDOWN :
			draw_set_valign(fa_bottom);
			draw_set_halign(fa_right);
			point_x = x2
			point_y = y2
			break
		case AL_LEFTCENTER :
			draw_set_valign(fa_middle);
			draw_set_halign(fa_left);
			point_x = x1
			point_y = (y1+y2) /2;
			break
		case AL_RIGHTCENTER :
			draw_set_valign(fa_middle);
			draw_set_halign(fa_right);
			point_x = x2
			point_y = (y1+y2) /2;
			break
		case AL_TOPCENTER :
			draw_set_valign(fa_top);
			draw_set_halign(fa_center);
			point_x = (x1+x2) /2;
			point_y = y1
			break
		case AL_DOWNCENTER :
			draw_set_valign(fa_bottom);
			draw_set_halign(fa_center);
			point_x = (x1+x2) /2;
			point_y = y2
			break
		default :
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			point_x = (x1+x2) /2;
			point_y = (y1+y2) /2;
			break
	}
	
	var _w_text, _h_text;
	if (isLabel) {
		_w_text = text_width*xscale;
		_h_text = text_height*yscale;
	}
	else if (IsUIElement(id)) {
		if (array_length(textFrameStock) <= textFrameIndex) {
			array_push(textFramePrevText, text);
			array_push(textFrameStock, [string_width(text)*xscale, string_height(text)*yscale]);
		}
		else {
			if (textFramePrevText[textFrameIndex] != text) {
				textFrameStock[textFrameIndex] = [string_width(text)*xscale, string_height(text)*yscale];
			}
		}
		_w_text = textFrameStock[textFrameIndex][0];
		_h_text = textFrameStock[textFrameIndex][1];
		textFrameIndex ++;
	}
	else {
		_w_text = string_width(text) *xscale;
		_h_text = string_height(text)*yscale;
	}
	
		
	draw_set_color(color);
	if (overflow == OVERFLOW_FIT) {
		var _w = 1, _h = 1;
		if (_w_text > x2 - x1)
			_w = (x2 - x1)/_w_text;
		if (_h_text > y2 - y1)
			_h = (y2 - y1)/_h_text;
		if (isBold) {
			var _dis = isBold;
			draw_set_alpha(alpha*0.8);
			draw_text_transformed(point_x, point_y, text, _w*xscale, _h*yscale, 0);
			draw_text_transformed(point_x+_dis, point_y, text, _w*xscale, _h*yscale, 0);
			draw_text_transformed(point_x-_dis, point_y, text, _w*xscale, _h*yscale, 0);
			draw_text_transformed(point_x, point_y+_dis, text, _w*xscale, _h*yscale, 0);
			draw_text_transformed(point_x, point_y-_dis, text, _w*xscale, _h*yscale, 0);
		}
		else {
			draw_set_alpha(alpha);
			draw_text_transformed(point_x, point_y, text, _w*xscale, _h*yscale, 0);
			//draw_set_alpha(sqr(alpha)*0.85);
			//draw_text_transformed(point_x, point_y, text, _w*xscale, _h*yscale, 0);
		}
	} 
	else if (overflow == OVERFLOW_STATIC) {
		var _w = 1;
		if (_w_text > x2 - x1)
			_w = (x2 - x1)/_w_text;
		if (isBold) {
			var _dis = isBold;
			draw_set_alpha(alpha*0.8);
			draw_text_transformed(point_x, point_y, text, _w*xscale, _w*yscale, 0);
			draw_text_transformed(point_x+_dis, point_y, text, _w*xscale, _w*yscale, 0);
			draw_text_transformed(point_x-_dis, point_y, text, _w*xscale, _w*yscale, 0);
			draw_text_transformed(point_x, point_y+_dis, text, _w*xscale, _w*yscale, 0);
			draw_text_transformed(point_x, point_y-_dis, text, _w*xscale, _w*yscale, 0);
		}
		else {
			draw_set_alpha(alpha);
			draw_text_transformed(point_x, point_y, text, _w*xscale, _w*yscale, 0);
			//draw_set_alpha(sqr(alpha)*0.85);
			//draw_text_transformed(point_x, point_y, text, _w*xscale, _h*yscale, 0);
		}
	}
	else if (overflow == OVERFLOW_WRAP) {
		/*if (isBold) {
			var _dis = 1.35;
			draw_set_alpha(alpha*0.8);
			draw_text_ext_transformed(point_x, point_y, text, -1, (x2 - x1)/xscale, xscale, yscale, 0);
			draw_text_ext_transformed(point_x+_dis, point_y, text, -1, (x2 - x1)/xscale, xscale, yscale, 0);
			draw_text_ext_transformed(point_x-_dis, point_y, text, -1, (x2 - x1)/xscale, xscale, yscale, 0);
			draw_text_ext_transformed(point_x, point_y+_dis, text, -1, (x2 - x1)/xscale, xscale, yscale, 0);
			draw_text_ext_transformed(point_x, point_y-_dis, text, -1, (x2 - x1)/xscale, xscale, yscale, 0);
		}
		else {
			draw_set_alpha(alpha);
			draw_text_ext_transformed(point_x, point_y, text, -1, (x2 - x1)/xscale, xscale, yscale, 0);
			//draw_set_alpha(sqr(alpha)*0.85);
			//draw_text_ext_transformed(point_x, point_y, text, -1, (x2 - x1)*xscale, xscale, yscale, 0);
		}*/
		draw_set_alpha(alpha);
		var _str;
		if (isLabel)
			_str = text_wrap;
		else
			_str = StringCut(text, (x2 - x1)/xscale);
		draw_text_transformed(point_x, point_y, _str, xscale, yscale, 0);
	}
}
/*
function draw_frame_class(x, y, _values) constructor {
	// values : { x1: double, y1: double .... }
	position = {
		x: _x,
		y: _y,
	}
	values = _values;
}
global.DrawFrameStruct = {};
draw_frame(draw_frame_class, x, y, {x1: .., y1: ...})

{
	if (!variable_struct_exists(global.DrawFrameStruct,"identify")) {
		global.DrawFrameStruct[$ "identify"] = {
			values: new draw_frame_class,
			asfsaf: fsafasf
			dfdsf: fdsff
			previousChecksum: 0
		}
	}
	
	var v = global.DrawFrameStruct[$ "identify"];
	
	var checksum = v.c + v.z;
	if (checksum != v.previousChecksum) {
		// 재연산 
	}
	
	
}*/

function draw_frame(x1, y1, x2, y2, sprite, alpha, scale, outer, edge, center, color, _index = 0) {
	if (alpha <= 0)
		return;
	/*if (keyboard_check(ord("K"))) {
		draw_set_color(color);
		draw_set_alpha(alpha);
		draw_rectangle(x1, y1, x2, y2,0);
		return
	}*/
	
	//if (IsUIElement(id))
		//show_message_async(1)
		
	////////////
	if (x1 > x2) { var _temp = x1; x1 = x2; x2 = _temp; }
	if (y1 > y2) { var _temp = y1; y1 = y2; y2 = _temp; }
	//edge += outer;
	x1 -= outer*scale;
	y1 -= outer*scale;
	x2 += outer*scale;
	y2 += outer*scale;
	var p_width = x2 - x1, p_height = y2 - y1;
	
	var isSmall_w = false, isSmall_h = false;
	var w_min_scale = scale, h_min_scale = scale;
	if ( (p_width-2*edge*scale) < 0  ) { //한계 이상으로 작아 질 시
		w_min_scale = p_width/(edge*2);
		isSmall_w = true;
	}
	if ( (p_height-2*edge*scale) < 0  ) { //한계 이상으로 작아 질 시
		h_min_scale = p_height/(edge*2);
		isSmall_h = true;
	}
	if ( isSmall_w || isSmall_h )
		if (w_min_scale > h_min_scale) {
			scale = h_min_scale;
			isSmall_w = false;
		}
		else {
			scale = w_min_scale;
			isSmall_h = false;
		}
	
	
	scale = min(w_min_scale, h_min_scale);
	
	draw_sprite_part_ext(sprite, _index, 0 ,0, edge, edge, x1, y1, scale, scale, color, alpha);
	draw_sprite_part_ext(sprite, _index, 0 ,edge + center, edge, edge, x1, y2-edge*scale, scale, scale, color, alpha);
	draw_sprite_part_ext(sprite, _index, edge + center ,edge + center, edge, edge, x2-edge*scale, y2-edge*scale, scale, scale, color, alpha);
	draw_sprite_part_ext(sprite, _index, edge + center ,0 , edge, edge, x2-edge*scale, y1, scale, scale, color, alpha);
	
	if ( ! isSmall_w ) {
		draw_sprite_part_ext(sprite, _index, edge , 0, center, edge, x1+edge*scale, y1, (p_width-2*edge*scale)/center, scale, color, alpha);
		draw_sprite_part_ext(sprite, _index, edge , edge+center, center, edge, x1+edge*scale, y2-edge*scale, (p_width-2*edge*scale)/center, scale, color, alpha);
	}
	if ( ! isSmall_h ) {
		draw_sprite_part_ext(sprite, _index, 0 , edge, edge, center, x1, y1+edge*scale, scale, (p_height-2*edge*scale)/center, color, alpha);
		draw_sprite_part_ext(sprite, _index, edge+center, edge, edge, center, x2-edge*scale, y1+edge*scale, scale, (p_height-2*edge*scale)/center, color, alpha);
	}
	
	if not ( isSmall_w || isSmall_h )
		draw_sprite_part_ext(sprite, _index, edge,edge, center, center, x1+edge*scale, y1+edge*scale, (p_width-2*edge*scale)/center, (p_height-2*edge*scale)/center, color, alpha);
}

function compute_draw_frame(x1, y1, x2, y2, sprite, alpha, scale, outer, edge, center, color, _index) {
	
	// POS (x1, y1, x2, y2)
	// 
	//edge*scale, isSmall_h, isSmall_w, scale
}