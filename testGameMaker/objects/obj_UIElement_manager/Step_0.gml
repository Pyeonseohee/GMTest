if (IsUIDebugging())
{
	if (keyboard_check_released(ord("O")) && ui_scale > 0.1)
		ui_scale -= 0.1;
	if (keyboard_check_released(ord("P")))
		ui_scale += 0.1;
}

if (window_width_temp != window_get_width()
	|| window_height_temp != window_get_height() 
	|| ui_scale_temp != ui_scale
	|| view_width_temp != camera_get_view_width(view_camera[0])
	|| view_height_temp != camera_get_view_height(view_camera[0]) ) {
		
	view_width_temp = camera_get_view_width(view_camera[0]);
	view_height_temp = camera_get_view_height(view_camera[0]);
	window_width_temp = window_get_width();
	window_height_temp = window_get_height();
	ui_scale_temp = ui_scale;
	
	ResizeUI();
	UpdateElements();
}


if (IsAnalogPointingAvailable()) {
	if (keyboard_check_released(vk_tab)) {
		if (nowFocusingButtonIdx != -1) {
			nowFocusingButtonIdx = -1;
		}
		else {
			CheckButtons();
			if (array_length(activeButtons) == 0) {
				nowFocusingButtonIdx = -1;
			}
			else {
				nowFocusingButtonIdx = 0;
			}
		}
	}
	if (keyboard_check_released(vk_enter)) {
		if (ValidateButton()) {
			var _button = element_list[activeLayerNow][activeButtons[nowFocusingButtonIdx]];
			with (_button) {
				isClicked = false;
				isFocused = false;
				if (sfx_release != undefined)
					PlaySFX(sfx_release,0,0);
				if (is_method(leaveCallback))
					leaveCallback(id);
				if (is_method(callback)) {
					callback(id);
					if (isOneOff) {
						callback = undefined;
					}
				}
			}
		}
	}
	if (keyboard_check_released(vk_up) || keyboard_check_released(ord("W"))) {
		FindNearButtonExt(90);
	}
	if (keyboard_check_released(vk_down) || keyboard_check_released(ord("S"))) {
		FindNearButtonExt(270);
	}
	if (keyboard_check_released(vk_left) || keyboard_check_released(ord("A"))) {
		FindNearButtonExt(180);
	}
	if (keyboard_check_released(vk_right) || keyboard_check_released(ord("D"))) {
		FindNearButtonExt(0);
	}
}