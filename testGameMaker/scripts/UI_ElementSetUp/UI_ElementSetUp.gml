// v2.3.0에 대한 스크립트 어셋 변경됨 자세한 정보는
// https://help.yoyogames.com/hc/en-us/articles/360005277377 참조
function UIElementSetVariables(type){
	if (type == ELEMENT_NORMAL || type == ELEMENT_BUTTON) {
		textFrameIndex = 0;
		textFrameStock = [] // [w, h]
		textFramePrevText = []
	}
	
	switch (type) {
		case ELEMENT_LABEL :
			text = ""
			text_wrap = undefined;
			text_width = -1;
			text_height = -1;
			label_color = c_white;
			label_alpha = 1;
			margin = 0;
			align = AL_CENTER;
			isBold = false;

			text_xscale = 1;
			text_yscale = 1;
			font_ = global.FontDefault;
			
			labelOverflow = OVERFLOW_STATIC;
			
			labelSurface = pointer_null;
			return;
		case ELEMENT_BUTTON :
			isFocused = false;
			isClicked = false;
			isActivated = true;
			isOneOff = false;
			callback = undefined;
			focusCallback = undefined;
			leaveCallback = undefined;
			clickCallback = undefined;
			releaseCallback = undefined;
			deactiveAnimation = undefined;
			//scrollParent = undefined;
			
			
			sfx_hover = undefined;
			sfx_click = undefined;
			sfx_release = undefined;
			return;
		case ELEMENT_SCROLL :
			scrollNow = 0;
			scrollTemp = 0;
			scrollAcceleration = 0;
			scrollMax = 0; // 최대사이즈 = scrollMax + width/height
			scrollElasticity = 1;
			isScrollHorizontal = false;
			isScrollFocused = false;
			isScrollMoving = false;
			scrollMousePosPressedTemp = 0;
			scrollMousePosTemp = 0;
			declineRate = 0.95;
			
			sfx_scrollChecker = 0;
			return;
	}
}


function UIElementDraw(_x1, _y1 ,_x2, _y2){
	if (elementType == ELEMENT_LABEL) {
		
		draw_textFrame( text,_x1,_y1, _x2, _y2
						, label_color, total_xscale*text_xscale*element_xscale, total_yscale*text_yscale*element_yscale
						, total_opacity*label_alpha, labelOverflow, margin, align, font_, isBold, true);
	}
	else {
		textFrameIndex = 0;
		var ext = {
			_x_center: (_x2 + _x1) / 2,
			_y_center: (_y2 + _y1) / 2,
		}; // 필요 시 더 추가 가능 
		drawer(_x1,_y1, _x2, _y2, id, total_xscale*element_xscale, total_yscale*element_yscale, total_opacity, ext);
	}
	
	if (IsUIDebugging()) {
		draw_set_alpha(0.5);
		if (!isAdjusted)
			draw_set_color(c_red);
		else
			draw_set_color(c_green);
		draw_rectangle(_x1, _y1 ,_x2, _y2,1);
	}
	if (elementType != ELEMENT_SCROLL)
		isAdjusted = true;
}

function UIElementAdjust(type) {
	var  _isScaleEdited = (element_xscale != goal_xscale
	 || element_yscale != goal_xscale
	 || element_width != goal_width
	 || element_height != goal_height);
	 
	if (_isScaleEdited // 애니메이션이 아직 재생중인가
	 || origin_x != goal_x
	 || origin_y != goal_y
	 || opacity != goal_opacity) {
		isAdjusted = false;
	 }
	
	if (isAdjusted) { // 이미 Adjust 되어있는 경우
		return false;
	}
	else { // 안 되어 있으면 자식들도 Adjust
		var _len = array_length(child);
		for (var i = 0; i < _len; i++) {
			with (child[i])
				isAdjusted = false;
		}
	}
	
	// SCALE
	if (scale_rate > 0) {
		element_xscale = SimpleLerp(element_xscale, goal_xscale, scale_rate);
		element_yscale = SimpleLerp(element_yscale, goal_yscale, scale_rate);
		element_width = SimpleLerp(element_width, goal_width, scale_rate);
		element_height = SimpleLerp(element_height, goal_height, scale_rate);
	}
	else {
		goal_xscale = element_xscale;
		goal_yscale = element_yscale;
		goal_width = element_width;
		goal_height = element_height;
	}
	
	// POSITION
	if (position_rate > 0) {
		origin_x = SimpleLerp(origin_x, goal_x, position_rate);
		origin_y = SimpleLerp(origin_y, goal_y, position_rate);
	}
	else {
		goal_x = origin_x;
		goal_y = origin_y;
	}
	
	// OPACITY
	if (opacity_rate > 0) {
		opacity = SimpleLerp(opacity, goal_opacity, opacity_rate);
	}
	else {
		goal_opacity = opacity;
	}
	
	var p_x1, p_x2, p_y1, p_y2;
	total_xscale = 1;
	total_yscale = 1;
	total_opacity = opacity;
	
	// 부모 위치 가져오기
	if (element_parent != null) { // 부모가 존재하는 오브젝트인 경우
		if (element_parent.elementType == ELEMENT_SCROLL) { // 부모가 스크롤인 경우
			p_x1 = element_parent.x - element_parent.isScrollHorizontal*element_parent.scrollNow;
			p_y1 = element_parent.y - (!element_parent.isScrollHorizontal)*element_parent.scrollNow;
			p_x2 = element_parent.x + max(element_parent.total_width , element_parent.isScrollHorizontal*(element_parent.scrollMax - element_parent.scrollNow));
			p_y2 = element_parent.y + max(element_parent.total_height , (!element_parent.isScrollHorizontal)*(element_parent.scrollMax - element_parent.scrollNow));

		}
		else {
			p_x1 = element_parent.x;
			p_y1 = element_parent.y;
			p_x2 = element_parent.x + element_parent.total_width;
			p_y2 = element_parent.y + element_parent.total_height;
		}
		total_xscale *= element_parent.total_xscale*element_parent.element_xscale;
		total_yscale *= element_parent.total_yscale*element_parent.element_yscale;
		total_opacity *= element_parent.total_opacity;
	}
	else {
		p_x1 = 0;
		p_y1 = 0;
		p_x2 = global.DisplayDefaultWidth;
		p_y2 = global.DisplayDefaultHeight;
	}
	
	total_width = element_width*total_xscale;
	total_height = element_height*total_yscale;
	
	// 너비를 FIT할 때 비율
	if (fit_width != 0) {
		total_width = fit_width*(p_x2 - p_x1) - total_width;
	}
	if (fit_height != 0) {
		total_height = fit_height*(p_y2 - p_y1) - total_height;
	}
	
	var _origin_x = origin_x, _origin_y = origin_y;
	if (isPositionRatio) { // 위치 좌표 단위가 부모 오브젝트 너비의 비율인 경우
		_origin_x *= (p_x2 - p_x1)/total_xscale;
		_origin_y *= (p_y2 - p_y1)/total_yscale;
	}

	switch (alignment) {
		default : // AL_LEFTTOP & 0
			x = _origin_x*total_xscale + p_x1;
			y = _origin_y*total_yscale + p_y1;
			break;
		case AL_RIGHTTOP :
			x = _origin_x*total_xscale + p_x2 - total_width;
			y = _origin_y*total_yscale + p_y1;
			break;
		case AL_LEFTDOWN :
			x = _origin_x*total_xscale + p_x1;
			y = _origin_y*total_yscale + p_y2 - total_height;
			break;
		case AL_RIGHTDOWN :
			x = _origin_x*total_xscale + p_x2 - total_width;
			y = _origin_y*total_yscale + p_y2 - total_height;
			break;
		case AL_LEFTCENTER :
			x = _origin_x*total_xscale + p_x1;
			y = _origin_y*total_yscale + (p_y1 + p_y2)/2 - total_height/2;
			break;
		case AL_RIGHTCENTER :
			x = _origin_x*total_xscale + p_x2 - total_width;
			y = _origin_y*total_yscale + (p_y1 + p_y2)/2 - total_height/2;
			break;
		case AL_TOPCENTER :
			x = _origin_x*total_xscale + (p_x1 + p_x2)/2 - total_width/2;
			y = _origin_y*total_yscale + p_y1;
			break;
		case AL_DOWNCENTER :
			x = _origin_x*total_xscale + (p_x1 + p_x2)/2 - total_width/2;
			y = _origin_y*total_yscale + p_y2 - total_height;
			break;
		case AL_CENTER :
			x = _origin_x*total_xscale + (p_x1 + p_x2)/2 - total_width/2;
			y = _origin_y*total_yscale + (p_y1 + p_y2)/2 - total_height/2;
			break;
	}
	
	fixed_x = x;
	fixed_y = y;
	x = x + total_width*(1-element_xscale)/2;
	y = y + total_height*(1-element_yscale)/2;
	total_width *= element_xscale;
	total_height *= element_yscale;
	
	var _x1 = x, _y1 = y, _x2 = x+total_width, _y2 = y+total_height;
	if (isOutOfScreen(_x1,_y1,_x2,_y2)) // 최종적으로 정해진 위치가 스크린 밖에 있다면 드로우 꺼버림
		visible = false;
	else
		visible = true;
	
	return _isScaleEdited;
}

function UIElementResponseExternalCondition() { // 추후 UI 시스템이 동작하지 않는 케이스를 추가할 수 있습니다.
	return true;
}

function UIElementResponseCondition() {
	if (!UIElementResponseExternalCondition()) {
		return false;
	}
	return obj_UIElement_manager.activeLayerNow == element_layer;
}

function UIElementButtonCheck() {
	var isMouseOnArea = false
	
	if (UIElementResponseCondition())
		if (fixed_x < device_mouse_x_to_gui(0) and device_mouse_x_to_gui(0) < fixed_x + total_width/element_xscale
		and fixed_y < device_mouse_y_to_gui(0) and device_mouse_y_to_gui(0) < fixed_y + total_height/element_yscale) {
			if (scrollParent != undefined) { // 부모가 스크롤인 경우
				if (scrollParent.isScrollMoving)
					isMouseOnArea = false;
				else if (not (scrollParent.x < device_mouse_x_to_gui(0) and device_mouse_x_to_gui(0) < scrollParent.x + scrollParent.total_width
				and scrollParent.y < device_mouse_y_to_gui(0) and device_mouse_y_to_gui(0) < scrollParent.y + scrollParent.total_height)) {
					isMouseOnArea = false;
				}
				else
					isMouseOnArea = true;
			}
			else
				isMouseOnArea = true;
		}
	
	if (isActivated) {
		if (IsMobileOS()) { // 커서가 없는 환경
			if (isMouseOnArea) {
				if (mouse_check_button_pressed(mb_left)) {
					isFocused = true;
					isClicked = true;
					if (sfx_click != undefined)
						PlaySFX(sfx_click,0,0);
					if (is_method(focusCallback))
						focusCallback(id);
					if (is_method(clickCallback))
						clickCallback(id);
				}
				if (mouse_check_button_released(mb_left) && isClicked) {
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
			else {
				if (isFocused) {
					isClicked = false;
					isFocused = false;
					if (is_method(leaveCallback))
						leaveCallback(id);
				}
			}
		}
		else { // 커서가 존재하는 환경
			if (isMouseOnArea) {
				if (!isFocused) {
					isFocused = true;
					if (sfx_hover != undefined)
						PlaySFX(sfx_hover,0,0);
					if (is_method(focusCallback))
						focusCallback(id);
				}
				if (mouse_check_button_pressed(mb_left)) {
					isClicked = true;
					if (sfx_click != undefined)
						PlaySFX(sfx_click,0,0);
					if (is_method(clickCallback))
						clickCallback(id);
				}
				if (mouse_check_button_released(mb_left) && isClicked) {
					isClicked = false;
					if (sfx_release != undefined)
						PlaySFX(sfx_release,0,0);
					if (is_method(leaveCallback))
						leaveCallback(id);
					if (is_method(focusCallback))
						focusCallback(id);
					if (is_method(callback)) {
						callback(id);
						if (isOneOff) {
							callback = undefined;
						}
					}
				}
			}
			else {
				if (isFocused) {
					isClicked = false;
					isFocused = false;
					if (is_method(leaveCallback))
						leaveCallback(id);
				}
			}
		}
	} else {
		isClicked = false;
		isFocused = false;
	}
}

function UIElementScrollCheck() {
	var _maxTotalScroll = (scrollMax - (!isScrollHorizontal? total_height : total_width))*element_xscale;
	var _isMobileOS = IsMobileOS();
	if (_maxTotalScroll > 0) {
		var _mar = _isMobileOS ? 24 : 2.5;
		var _mouseOffset = !isScrollHorizontal? device_mouse_y_to_gui(0) : device_mouse_x_to_gui(0);
		var _sfxCheckUnit = 300;
		
		
		if (abs(scrollAcceleration) > 4) { // 일정 수치 이내로 가속이 줄어들면 가속도를 0으로
			scrollAcceleration *= declineRate;
		}
		else
			scrollAcceleration = 0;
		
		if (scrollNow >= 0 && scrollNow <= _maxTotalScroll) { // 스크롤이 정상 범위 내에 있음
			if (isScrollMoving)
				scrollNow = scrollNow+scrollAcceleration;
			
			if (!isScrollFocused && scrollAcceleration == 0)
				isScrollMoving = false;
			
			if (sfx_scrollChecker != scrollNow div _sfxCheckUnit) {
				PlaySFX(s_button_hover_03,0,0, 0.7, 1.75);
				sfx_scrollChecker = scrollNow div _sfxCheckUnit;
			}
		}
		else { // 초과
			if (scrollAcceleration != 0 && !isScrollFocused) {
				scrollAcceleration = 0;
				PlaySFX(s_button_hover_03,0,0, 1.4, 1.35);
			}
				
			if (scrollNow < 0) {
				scrollNow = scrollNow - min(scrollNow*0.25, -12);
			}
			else {
				scrollNow = scrollNow + min((_maxTotalScroll - scrollNow)*0.25, -12);
			}
		}
		
		
		if (!UIElementResponseCondition()) // 활성화 중인 레이어가 아닌 경우 스크롤 조작 불가
			return;
		
		if (isScrollFocused) { // 스크롤 조작이 가능한 상태 (마우스)
			if (mouse_check_button_released(mb_left)) {
				isScrollFocused = false;
				declineRate = 0.95;
				
				if (!_isMobileOS) {
					scrollAcceleration = scrollMousePosTemp - _mouseOffset;
				}
				else {
					var newAcc = scrollMousePosTemp - _mouseOffset;
					var _val = ((scrollAcceleration*1.6+newAcc*0.4)/2)
					scrollAcceleration = _val*abs(_val) / 170;
				}
			}
			else {
				scrollAcceleration = scrollMousePosTemp - _mouseOffset;
			}
			
			scrollMousePosTemp = _mouseOffset;
			if (isScrollMoving)
				scrollNow = scrollTemp + (scrollMousePosPressedTemp - _mouseOffset)	
			if (scrollNow < 0) {
				//var _max = -scrollNow*2;
				//scrollNow = (-scrollNow < _max/2) ? scrollNow + sqr(scrollNow)/_max : -_max/2 + sqr(_max/2)/_max;
				//scrollNow = -sqrt(-scrollNow*0.0007)*400;
				scrollNow = scrollNow + (-scrollNow)/2;
			}
			if (scrollNow > _maxTotalScroll) {
				scrollNow = _maxTotalScroll + (scrollNow-_maxTotalScroll)/2;
				//scrollNow = _maxTotalScroll+sqrt((scrollNow-_maxTotalScroll)*0.0007)*400;
			}
					
			if (abs(scrollMousePosPressedTemp - _mouseOffset) > _mar) {
				isScrollMoving = true;
			}
		}
		else {
			if (x < device_mouse_x_to_gui(0) and device_mouse_x_to_gui(0) < x + total_width
			and y < device_mouse_y_to_gui(0) and device_mouse_y_to_gui(0) < y + total_height) {
				if (!_isMobileOS) {
					if (scrollNow >= 0 && scrollNow <= _maxTotalScroll) { // 스크롤이 정상 범위 내에 있음
						if (mouse_wheel_up()) {
							scrollNow -= 20;
							scrollAcceleration -= 50;
							isScrollMoving = true;
							declineRate = 0.75;
						}
						else if (mouse_wheel_down()) {
							scrollNow += 20;
							scrollAcceleration += 50;
							isScrollMoving = true;
							declineRate = 0.75;
						}
					}
				}
			
				if (mouse_check_button_pressed(mb_left)) {
					isScrollFocused = true;
					scrollAcceleration = 0;
					scrollMousePosPressedTemp = _mouseOffset;
					scrollTemp = scrollNow;
				}
			}
		}
		if (isScrollMoving)
			isAdjusted = false;
	}
	else
		scrollNow = 0;
}

function UIElementDestroy() {
	if (is_method(deleteAction))
		deleteAction();
	
	if (isSurfaceField)
		if (!surface_exists(element_surface))
			surface_free(element_surface);
	
	var _idx = array_get_index(obj_UIElement_manager.element_list[element_layer], id);
	array_delete(obj_UIElement_manager.element_list[element_layer] , _idx, 1);
	//ds_list_destroy(child);
	if (obj_UIElement_manager.lastDeletedOldestElementIdx[element_layer] > _idx)
		obj_UIElement_manager.lastDeletedOldestElementIdx[element_layer] = _idx;
}