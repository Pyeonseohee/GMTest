

if (IsUIDebugging()) {
	var _scale = 1;
	draw_set_color(c_black);
	draw_set_alpha(0.45);
	draw_rectangle(0,0,500,300, 0);
	
	draw_set_font(global.FontDefault);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_text_transformed(0,32,"fps_real : " + string(fps_real),1,1,0);
	
	var _len = array_length(element_list);
	for (var i = 0; i < _len; i ++)  {
		var _debugText = "\nSize of \"element_list["+string(i)+"]\" : " + string(array_length(element_list[i]));
		if (activeLayerNow == i) {
			draw_set_color(c_fuchsia);
		}
		else {
			draw_set_color(c_lime);
		}
		draw_set_alpha(1);
		draw_text_transformed(0,i * 32 + 32,_debugText,1,1,0);
	}
}


//엘리먼트가 삭제되었을 때 순서가 바뀐 Id부터 depth를 다시 설정합니다.
var _len = array_length(element_list);
for (var j = 0; j < _len; j ++)  {
	if (lastDeletedOldestElementIdx[j] != 9999) { // 엘리먼트 삭제 감지
		var __len = array_length(element_list[j]);
		for (var i = lastDeletedOldestElementIdx[j]; i < __len; i++) { // 리스트의 순서가 바뀐 ID부터 depth 갱신
			if (instance_exists(element_list[j][i]))
				if (element_list[j][i].isfixedDepth ==	false)
					element_list[j][i].depth = layerDepthOrigin[j]-i;
		}
		lastDeletedOldestElementIdx[j] = 9999;
	}
}

if (IsAnalogPointingAvailable()) {
	if (UIElementResponseExternalCondition())
	if (ValidateButton()) {
		if (nowFocusingButtonIdx != -1) {
			var _elm = element_list[activeLayerNow][activeButtons[nowFocusingButtonIdx]];
			gpu_set_blendmode(bm_add);
			draw_frame_outlineRounded(_elm.x, _elm.y, _elm.x + _elm.total_width, _elm.y + _elm.total_height, 1, COLOR_JS_ORANGE, 0.75, 8);
			gpu_set_blendmode(bm_normal);
		}
	}
}