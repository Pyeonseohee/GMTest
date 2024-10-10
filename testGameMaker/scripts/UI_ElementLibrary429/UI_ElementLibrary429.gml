function UILIb_roundedLineEdge(_element, animation_rate = 4, animation_x = 0, animation_y = 0, frame_alpha = 0.4, __scale = 1) {
	_element.position_rate = animation_rate;
	_element.opacity_rate = animation_rate*2.5;
	_element.origin_x += animation_x;
	_element.origin_y += animation_y;
	_element.opacity = 0;
	_element.frame_alpha = frame_alpha;
	_element.frame_scale = __scale;
	SetElementDrawer(_element, DRAWER{
		//draw_frame_glow1(_x1,_y1,_x2,_y2,_alpha*frame_alpha*2.5,c_black, _xscale*1.3*frame_scale);
		//draw_frame_roundedLineEdge(_x1,_y1,_x2,_y2,_alpha*frame_alpha, _xscale*frame_scale);
		draw_frame_roundedShadow(_x1,_y1,_x2,_y2,_alpha*frame_alpha, _xscale*frame_scale);
	});
}


function UILIb_button_scaleAnimationWithHighLight(_element,_scale_rate = 2,_goalScale = 1, _frameScale = 1, _useHighRes = false) {
	_element.scale_rate = _scale_rate;
	_element.isHighlihgtElementExist = false;
	SetButtonSFX_default(_element);
	SetElementVariables(_element, {
		goalScale  : _goalScale,
		frameScale : _frameScale,
		useHighRes : _useHighRes
	});
	SetButtonLeaveCallback(_element, CALLBACK { goal_xscale = goalScale; goal_yscale = goalScale;
		if (isHighlihgtElementExist && IsMobileOS())
			_wipe.opacity = 0.3/2.5;
		});
	SetButtonClickCallback(_element, CALLBACK {  goal_xscale = 0.98*goalScale; goal_yscale = 0.98*goalScale;});
	SetButtonFocusCallback(_element, CALLBACK { 
		goal_xscale = 1.04*goalScale;
		goal_yscale = 1.04*goalScale;
		if (isHighlihgtElementExist)
			return;
		isHighlihgtElementExist = true;
		PushLayerTarget(element_layer);
		_wipe = AddElement(0,0,0,0,_e);
		PopLayerTarget();
		_wipe.image_index_ = 0;
		_wipe.opacity = 0;
		_wipe.goal_opacity = 0.25;
		_wipe.opacity_rate = 2;
		SetElementFit(_wipe, FIT_FULL);
		_wipe.temp_surface = surface_create(total_width, total_height);
		_wipe.final_surface = surface_create(total_width, total_height);
		_wipe.circle_size = 0;
		_wipe.circle_size_goal = point_distance(0,0,total_width,total_height)/160;
		SetElementVariables(_wipe, {
			frameScale : frameScale,
			useHighRes : useHighRes
		});
		SetElementDrawer(_wipe, DRAWER{
			
			circle_size += (circle_size_goal-circle_size)/(4+!element_parent.isFocused*2);
			if (!surface_exists(temp_surface))
				temp_surface = surface_create(element_parent.total_width, element_parent.total_height);
			
			surface_set_target(temp_surface);
			draw_set_alpha(1);
			
			var _mouse_x = device_mouse_x_to_gui(0), _mouse_y = device_mouse_y_to_gui(0)
			if (element_surface != -1) {
				_mouse_x -= element_surface.x;
				_mouse_y -= element_surface.y;
			}
			var  _size = circle_size*0.65;
			var _original_width = element_parent.total_width/element_parent.element_xscale;
			var _original_height = element_parent.total_height/element_parent.element_yscale;
			//draw_sprite_ext(sp_wipe, 4,0,0,(_x2-_x1)/256,(_y2-_y1)/256, 0,c_white,1);
			draw_set_color(c_white);
			if (useHighRes) {
				draw_frame_32rounded(0,0,_original_width, _original_height, 1, c_white,frameScale*2*(12/32));
			}
			else {
				draw_frame_12rounded(0,0,_original_width, _original_height, 1, c_white,frameScale);
			}
			gpu_set_blendmode(bm_subtract);
			var _point_x = (_x1+_x2)/2, _point_y = (_y1+_y2)/2;
			var _dir = point_direction(_point_x, _point_y, _mouse_x, _mouse_y);
			var _dis = point_distance(_point_x, _point_y, _mouse_x, _mouse_y);
			draw_sprite_ext(sp_baam, 0, (_mouse_x-_x1)/_xscale, (_mouse_y-_y1)/_yscale, _size*(1.6+sqr(_dis/1000)), _size*(1.6+sqr(_dis/120)), _dir, c_black, 1);
			gpu_set_blendmode(bm_normal);
			surface_reset_target();
			if (!surface_exists(final_surface))
				final_surface = surface_create(_original_width, _original_height);
			surface_set_target(final_surface);
			if (useHighRes) {
				draw_frame_32rounded(0,0,_original_width, _original_height, 1, c_white,frameScale*2*(12/32));
			}
			else {
				draw_frame_12rounded(0,0,_original_width, _original_height, 1, c_white,frameScale);
			}
			
			gpu_set_blendmode(bm_subtract);
			draw_surface_ext(temp_surface,0,0,1,1,0,c_black,1);
			gpu_set_blendmode(bm_normal);
			
			surface_reset_target();

			gpu_set_blendmode(bm_add);
			if (useHighRes) {
				draw_frame_32rounded(_x1, _y1, _x2, _y2, _alpha*0.05, COLOR_JS_ORANGE,_xscale*frameScale*2*(12/32));
			}
			else {
				draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha*0.05, COLOR_JS_ORANGE, _xscale*frameScale);
			}
			
			draw_surface_ext(final_surface, _x1, _y1, _xscale, _yscale,0, COLOR_JS_ORANGE, 2.5*_alpha);
			gpu_set_blendmode(bm_normal);
			
			if (! element_parent.isFocused) {
				if (IsMobileOS()) {
					opacity_rate = 1.1;
					circle_size = point_distance(0,0,total_width,total_height)/60;
				}
				goal_opacity = 0
				if (opacity < 0.0005) {
					element_parent.isHighlihgtElementExist = false;
					SetElementRemove(_e);
				}
			}
			else {
				goal_opacity = 0.2;
				opacity_rate = 8;
			}
			if (element_parent.isClicked) {
				goal_opacity = 1;
				opacity_rate = 2;
				circle_size_goal = point_distance(0,0,total_width,total_height)/210;
			}
			else {
				circle_size_goal = point_distance(0,0,total_width,total_height)/160;
				opacity_rate = 20;
			}
		});
		SetElementDeleteAction(_wipe, CALLBACK{
			if (surface_exists(final_surface))
				surface_free(final_surface);
			if (surface_exists(temp_surface))
				surface_free(temp_surface);
		});
	});
}
function UILIb_button_scaleAnimation(_element ,scale_diff = 0.15, _goal_opacity = 0.3) {
	_element.scale_rate = 2;
	_element.opacity_rate = 2;
	_element.scale_rateForAnimation = 2;
	_element.opacity_rateForAnimation = 2;
	_element.scaleDiffForAnimation = scale_diff;
	_element.goal_opacity_ForAnimation = _goal_opacity;
	SetButtonSFX_default(_element);
	SetButtonFocusCallback(_element, CALLBACK { goal_xscale = 1+scaleDiffForAnimation; goal_yscale = 1+scaleDiffForAnimation; goal_opacity = 1; scale_rate = scale_rateForAnimation; opacity_rate = opacity_rateForAnimation});
	SetButtonLeaveCallback(_element, CALLBACK { goal_xscale = 1; goal_yscale = 1; goal_opacity = 1;});
	SetButtonClickCallback(_element, CALLBACK { goal_xscale = 1-scaleDiffForAnimation; goal_yscale = 1-scaleDiffForAnimation; goal_opacity = goal_opacity_ForAnimation;});
}

function UILib_button_orangeRounded(_element, _text, _textSize = 1) {
	_element.overlay = 0;
	_element.overlay_goal = 0;
	_element.scale_rate = 1.5;
	_element.scaleDiffForAnimation = 0.04;
	SetButtonFocusCallback(_element, CALLBACK { goal_xscale = 1+scaleDiffForAnimation; goal_yscale = 1+scaleDiffForAnimation; overlay_goal = 0.5;});
	SetButtonLeaveCallback(_element, CALLBACK { goal_opacity = 1 goal_xscale = 1; goal_yscale = 1; overlay_goal = 0;});
	SetButtonClickCallback(_element, CALLBACK {
		goal_xscale = 1-scaleDiffForAnimation; goal_yscale = 1-scaleDiffForAnimation; overlay_goal = 1;
		//UILib_effect_linePop(self);
	});
	SetElementDeactiveAnimation(_element, CALLBACK {  opacity_rate = 4; goal_opacity = 0.6;});
	SetElementDrawer(_element, DRAWER{
		overlay += (overlay_goal-overlay)/4;
		draw_frame_glow1(_x1, _y1, _x2, _y2, _alpha*0.75, make_color_rgb(76, 32, 0), _xscale*1.5);
		draw_frame_roundedEdgeOrange(_x1, _y1, _x2, _y2, _alpha, _xscale);
		gpu_set_blendmode(bm_add);
		draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha*0.15*overlay, c_white, _xscale);
		gpu_set_blendmode(bm_normal);
	});

	_element.buttonLabel = AddLabel(0,0,0,0,_text, _element);
	SetElementFit(_element.buttonLabel, FIT_FULL);
	SetLabel(_element.buttonLabel, COLOR_JS_DKORANGE, 1.5*_textSize, 1.5*_textSize, 1, 10, AL_CENTER);
	SetButtonSFX_default2(_element);
}
function UILib_effect_linePop(_element, _color = COLOR_JS_ORANGE, _frameScale = 1, _repeat = 3) {
	with (_element) {
		if (!variable_instance_exists(self, "__buttonAnimationCount")) {
			__buttonAnimationCount = 0;
		}
		if (__buttonAnimationCount > 2) {
			return;
		}
		__buttonAnimationCount ++;
	}
	with (AddElement(0, 0, 0, 0, _element)) {
		goal_xscale = 1.25;
		goal_yscale = 1.25;
		scale_rate  = 16;
		goal_opacity= 0;
		opacity_rate= 12;
		SetElementFit(self, FIT_FULL);
		SetElementVariables(self, {
			__surf         : -1,
			__color        : _color,
			__frameScale   : _frameScale,
			__repeat       : _repeat,
		});
		SetElementDeleteAction(self, CALLBACK {
			if (surface_exists(__surf)) {
				surface_free(__surf);
			}
		});
		SetElementDrawer(self, DRAWER{
			if (opacity < 0.01) {
				element_parent.__buttonAnimationCount --;
				SetElementRemove(self);
			}
			
			var __edge = 180;
			var __W = element_parent.total_width + __edge*2;
			var __H = element_parent.total_height + __edge*2;
			var _original_width = element_parent.total_width/element_parent.element_xscale;
			var _original_height = element_parent.total_height/element_parent.element_yscale;
			var _fixedXscale = (_x2-_x1)/_original_width;
			var _fixedYscale = (_y2-_y1)/_original_height;
			var __x1 = __edge, __y1 = __edge, __x2 = __edge + _original_width, __y2 = __edge + _original_height;
			if (!surface_exists(__surf)) {
				__surf = surface_create(__W, __H);
				surface_set_target(__surf);
				draw_clear_alpha(c_black,0);
				repeat (__repeat*2) {
					draw_frame_glow1(__x1, __y1, __x2, __y2,_alpha, c_white,__frameScale*_fixedXscale*4);
				}
				//draw_frame_12rounded(__x1, __y1, __x2, __y2,_alpha*0.65, c_white,__frameScale*_fixedXscale);
				draw_frame_outlineRounded(__x1, __y1, __x2, __y2,_alpha, c_white,__frameScale*_fixedXscale, 4);
				surface_reset_target();
			}
			
			gpu_set_blendmode(bm_add);
			repeat (3) {
				draw_surface_ext(__surf, _x1-__edge*_fixedXscale, _y1-__edge*_fixedYscale, _fixedXscale, _fixedYscale,0, __color, _alpha);
			}
			gpu_set_blendmode(bm_normal);
		});
	}
}
function UILib_button_eraseAnimation(_button) {
	SetButtonFocusCallback(_button,CALLBACK{});
	SetButtonLeaveCallback(_button,CALLBACK{});
	SetButtonClickCallback(_button,CALLBACK{});
}
function UILib_button_rounded(_element, _text, buttonOpacity=1, _color = c_ltgray) {
	_element.overlay = 0;
	_element.overlay_goal = 0;
	_element.scale_rate = 1.5;
	_element.scaleDiffForAnimation = 0.04;
	_element.buttonOpacity = buttonOpacity;
	_element._color = _color;
	
	SetButtonFocusCallback(_element, CALLBACK { goal_xscale = 1+scaleDiffForAnimation; goal_yscale = 1+scaleDiffForAnimation; overlay_goal = 0.5;});
	SetButtonLeaveCallback(_element, CALLBACK { goal_xscale = 1; goal_yscale = 1; overlay_goal = 0; opacity_rate = 4; goal_opacity = 1;});
	SetButtonClickCallback(_element, CALLBACK { goal_xscale = 1-scaleDiffForAnimation; goal_yscale = 1-scaleDiffForAnimation; overlay_goal = 1;});
	SetElementDeactiveAnimation(_element, CALLBACK {  opacity_rate = 4; goal_opacity = 0.3;});
	SetElementDrawer(_element, DRAWER{
		overlay += (overlay_goal-overlay)/4;
		//draw_frame_glow1(_x1, _y1, _x2, _y2, _alpha*0.75*buttonOpacity, make_color_rgb(76, 32, 0), _xscale*1.5);
		draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha*0.25*buttonOpacity, _color, _xscale);
		gpu_set_blendmode(bm_add);
		draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha*0.15*overlay*buttonOpacity, c_white, _xscale);
		gpu_set_blendmode(bm_normal);
	});

	_element.buttonLabel = AddLabel(0,0,0,0,_text, _element);
	SetElementFit(_element.buttonLabel, FIT_FULL);
	SetLabel(_element.buttonLabel, c_white, 1.5, 1.5, 1, 2, AL_CENTER);
	SetButtonSFX_default(_element);
}
function UILib_button_roundedBlack(_element, _text, buttonOpacity=1) {
	_element.overlay = 0;
	_element.overlay_goal = 0;
	_element.scale_rate = 1.5;
	_element.scaleDiffForAnimation = 0.04;
	_element.buttonOpacity = buttonOpacity;
	SetButtonFocusCallback(_element, CALLBACK { goal_xscale = 1+scaleDiffForAnimation; goal_yscale = 1+scaleDiffForAnimation; overlay_goal = 0.25;});
	SetButtonLeaveCallback(_element, CALLBACK { goal_xscale = 1; goal_yscale = 1; overlay_goal = 0;});
	SetButtonClickCallback(_element, CALLBACK { goal_xscale = 1-scaleDiffForAnimation; goal_yscale = 1-scaleDiffForAnimation; overlay_goal = 1;});
	SetElementDrawer(_element, DRAWER{
		overlay += (overlay_goal-overlay)/4;
		//draw_frame_glow1(_x1, _y1, _x2, _y2, _alpha*0.35*buttonOpacity, c_dkgray, _xscale*1.5);
		draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha*0.25*buttonOpacity,c_black, _xscale);
		gpu_set_blendmode(bm_add);
		draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha*0.15*overlay*buttonOpacity, c_white, _xscale);
		gpu_set_blendmode(bm_normal);
	});

	_element.buttonLabel = AddLabel(0,0,0,0,_text, _element);
	SetElementFit(_element.buttonLabel, FIT_FULL);
	SetLabel(_element.buttonLabel, c_white, 1.5, 1.5, 1, 2, AL_CENTER);
	SetButtonSFX_default(_element);
}
function UILib_button_iconWithText(_element, _text, _icon, _iconSize = 1, index = 0, isJumping = false) {
	_element.scale_rate = 1.5;
	_element.scaleDiffForAnimation = 0.1;
	_element.__iconSize = _iconSize;
	SetButtonFocusCallback(_element, CALLBACK {
		goal_xscale = 1+scaleDiffForAnimation;
		goal_yscale = 1+scaleDiffForAnimation;
		overlay_goal = 0.25;
		
		buttonLabel.label_color = COLOR_JS_LTGOLD;
	});
	SetButtonLeaveCallback(_element, CALLBACK {
		goal_xscale = 1;
		goal_yscale = 1;
		overlay_goal = 0;
		goal_opacity = 1;
		opacity_rate = 1.5;
		
		buttonLabel.label_color = c_white;
	});
	SetButtonClickCallback(_element, CALLBACK {
		goal_xscale = 1-scaleDiffForAnimation;
		goal_yscale = 1-scaleDiffForAnimation; 
		overlay_goal = 1;
		goal_opacity = 0.5;
		opacity_rate = 1.5;
	});
	SetElementDrawer(_element, DRAWER{
		draw_sprite_ext(sp_baam, 0, (_x1+_x2)/2, (_y1+_y2)/2 + 20 * _yscale, _xscale*__iconSize*1.1, _yscale*__iconSize*1.2, 0, c_black, _alpha*0.5);
	});

	_element.buttonLabel = AddLabel(0,0,0,60,_text, _element);
	SetElementFit(_element.buttonLabel, FIT_HORIZONTAL);
	SetElementAlignment(_element.buttonLabel, AL_DOWNCENTER);
	SetLabel(_element.buttonLabel, c_white, 0.95, 0.95, 1, 10, AL_CENTER, global.FontDefault, true);
	
	_element.icon = AddElement(0,0,0,40, _element);
	_element.icon._iconSize = _iconSize*0.7;
	_element.icon._iconSprite = _icon;
	_element.icon._index = index;
	_element.icon.isJumping = isJumping;
	_element.icon._animationOffset = 0;
	_element.icon._animationCycle = 0;
	SetElementFit(_element.icon, FIT_FULL);
	SetElementDrawer(_element.icon, DRAWER{
		var yy = 0;
		if (isJumping) {
			var _cycle = 7.5;
			_animationCycle ++;
			if (_animationCycle > pi*2*_cycle) // 주기
				_animationCycle -= pi*2*_cycle;
			
			_animationOffset = SimpleLerp(_animationOffset, 0, 32);
			if (_animationOffset < 0.1) {
				_animationOffset = 40;
				_animationCycle = 0;
			}
			
			yy = abs(sin(_animationCycle/_cycle))*_animationOffset
		}
		
		var _x_a = (_x1+_x2)/2, _y_a = (_y1+_y2)/2 - yy*_yscale;
		draw_sprite_ext(_iconSprite, _index, _x_a, _y_a, _iconSize*_xscale, _iconSize*_yscale, 0, c_white,_alpha);
		if (isJumping)
			draw_sprite_ext(sp_circle, 0, _x_a + _xscale*30, _y_a - _yscale*30, _xscale*.3, _yscale*.3, 0, COLOR_JS_RED, _alpha);
	});
	SetButtonSFX_default(_element);
}

function UILib_button_roundedBlackWithIcon(_element, _text, _icon, _iconSize = 1, index = 0, _iconColor = c_white) {
	_element.overlay = 0;
	_element.overlay_goal = 0;
	_element.scale_rate = 1.5;
	_element.scaleDiffForAnimation = 0.04;
	SetButtonFocusCallback(_element, CALLBACK { goal_xscale = 1+scaleDiffForAnimation; goal_yscale = 1+scaleDiffForAnimation; overlay_goal = 0.25;});
	SetButtonLeaveCallback(_element, CALLBACK { goal_xscale = 1; goal_yscale = 1; overlay_goal = 0; goal_opacity = 1;});
	SetButtonClickCallback(_element, CALLBACK { goal_xscale = 1-scaleDiffForAnimation; goal_yscale = 1-scaleDiffForAnimation; overlay_goal = 1;});
	SetElementDrawer(_element, DRAWER{
		overlay += (overlay_goal-overlay)/4;
		//draw_frame_glow1(_x1, _y1, _x2, _y2, _alpha*0.35, c_dkgray, _xscale*1.5);
		//draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha*0.45,c_black, _xscale);
		draw_frame_roundedShadow(_x1, _y1, _x2, _y2, _alpha*0.25, _xscale);
		gpu_set_blendmode(bm_add);
		draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha*0.15*overlay, c_white, _xscale);
		gpu_set_blendmode(bm_normal);
	});
	SetElementDeactiveAnimation(_element, CALLBACK {  opacity_rate = 4; goal_opacity = 0.3;});

	_element.buttonLabel = AddLabel(0,0,0,60,_text, _element);
	SetElementFit(_element.buttonLabel, FIT_HORIZONTAL);
	SetElementAlignment(_element.buttonLabel, AL_DOWNCENTER);
	SetLabel(_element.buttonLabel, c_white, 0.95, 0.95, 1, 10, AL_CENTER);
	
	_element.icon = AddElement(0,0,0,40, _element);
	_element.icon._iconSize = _iconSize*0.7;
	_element.icon._iconSprite = _icon;
	_element.icon._index = index;
	SetElementFit(_element.icon, FIT_FULL);
	SetElementDrawer(_element.icon, DRAWER{
		draw_sprite_ext(_iconSprite, _index, (_x1+_x2)/2, (_y1+_y2)/2, _iconSize*_xscale, _iconSize*_yscale, 0, _iconColor,_alpha);
	}, {_iconColor : _iconColor});
	SetButtonSFX_default(_element);
}
function UILib_button_roundedWhiteWithIcon(_element, _text, _icon, _iconSize = 1, index = 0, _iconColor = c_white) {
	_element.overlay = 0;
	_element.overlay_goal = 0;
	_element.scale_rate = 1.5;
	_element.scaleDiffForAnimation = 0.04;
	_element.buttonOpacity = 1;
	SetButtonFocusCallback(_element, CALLBACK { goal_xscale = 1+scaleDiffForAnimation; goal_yscale = 1+scaleDiffForAnimation; overlay_goal = 0.5;});
	SetButtonLeaveCallback(_element, CALLBACK { goal_xscale = 1; goal_yscale = 1; overlay_goal = 0;});
	SetButtonClickCallback(_element, CALLBACK { goal_xscale = 1-scaleDiffForAnimation; goal_yscale = 1-scaleDiffForAnimation; overlay_goal = 1;});
	SetElementDrawer(_element, DRAWER{
		overlay += (overlay_goal-overlay)/4;
		//draw_frame_glow1(_x1, _y1, _x2, _y2, _alpha*0.75*buttonOpacity, make_color_rgb(76, 32, 0), _xscale*1.5);
		draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha*0.25*buttonOpacity,c_ltgray, _xscale);
		gpu_set_blendmode(bm_add);
		draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha*0.15*overlay*buttonOpacity, c_white, _xscale);
		gpu_set_blendmode(bm_normal);
	});

	_element.buttonLabel = AddLabel(0,0,0,60,_text, _element);
	SetElementFit(_element.buttonLabel, FIT_HORIZONTAL);
	SetElementAlignment(_element.buttonLabel, AL_DOWNCENTER);
	SetLabel(_element.buttonLabel, c_white, 0.95, 0.95, 1, 10, AL_CENTER);
	
	_element.icon = AddElement(0,0,0,40, _element);
	_element.icon._iconSize = _iconSize*0.7;
	_element.icon._iconSprite = _icon;
	_element.icon._index = index;
	_element.icon.iconColor = _iconColor;
	SetElementFit(_element.icon, FIT_FULL);
	SetElementDrawer(_element.icon, DRAWER{
		draw_sprite_ext(_iconSprite, _index, (_x1+_x2)/2, (_y1+_y2)/2, _iconSize*_xscale, _iconSize*_yscale, 0, iconColor,_alpha);
	});
	SetButtonSFX_default(_element);
}
function UILib_button_roundedWhiteOnlyIcon(_element, _icon, _iconSize = 1, index = 0, _iconColor = c_white) {
	_element.overlay = 0;
	_element.overlay_goal = 0;
	_element.scale_rate = 1.5;
	_element.scaleDiffForAnimation = 0.04;
	_element.buttonOpacity = 1;
	SetButtonFocusCallback(_element, CALLBACK { goal_xscale = 1+scaleDiffForAnimation; goal_yscale = 1+scaleDiffForAnimation; overlay_goal = 0.5;});
	SetButtonLeaveCallback(_element, CALLBACK { goal_xscale = 1; goal_yscale = 1; overlay_goal = 0;});
	SetButtonClickCallback(_element, CALLBACK { goal_xscale = 1-scaleDiffForAnimation; goal_yscale = 1-scaleDiffForAnimation; overlay_goal = 1;});
	SetElementDrawer(_element, DRAWER{
		overlay += (overlay_goal-overlay)/4;
		//draw_frame_glow1(_x1, _y1, _x2, _y2, _alpha*0.75*buttonOpacity, make_color_rgb(76, 32, 0), _xscale*1.5);
		draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha*0.25*buttonOpacity,c_ltgray, _xscale);
		gpu_set_blendmode(bm_add);
		draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha*0.15*overlay*buttonOpacity, c_white, _xscale);
		gpu_set_blendmode(bm_normal);
	});
	
	_element.icon = AddElement(0,0,0,0, _element);
	_element.icon._iconSize = _iconSize*0.7;
	_element.icon._iconSprite = _icon;
	_element.icon._index = index;
	_element.icon.iconColor = _iconColor;
	SetElementFit(_element.icon, FIT_FULL);
	SetElementDrawer(_element.icon, DRAWER{
		draw_sprite_ext(_iconSprite, _index, (_x1+_x2)/2, (_y1+_y2)/2, _iconSize*_xscale, _iconSize*_yscale, 0, iconColor,_alpha);
	});
	SetButtonSFX_default(_element);
}

function UILib_button_roundedWhiteWithNumber(_element, _text, _number, _stringSize = 1, _stringColor = c_white) {
	_element.overlay = 0;
	_element.overlay_goal = 0;
	_element.scale_rate = 1.5;
	_element.scaleDiffForAnimation = 0.04;
	_element.buttonOpacity = 1;
	SetButtonFocusCallback(_element, CALLBACK { goal_xscale = 1+scaleDiffForAnimation; goal_yscale = 1+scaleDiffForAnimation; overlay_goal = 0.5;});
	SetButtonLeaveCallback(_element, CALLBACK { goal_xscale = 1; goal_yscale = 1; overlay_goal = 0;});
	SetButtonClickCallback(_element, CALLBACK { goal_xscale = 1-scaleDiffForAnimation; goal_yscale = 1-scaleDiffForAnimation; overlay_goal = 1;});
	SetElementDrawer(_element, DRAWER{
		overlay += (overlay_goal-overlay)/4;
		//draw_frame_glow1(_x1, _y1, _x2, _y2, _alpha*0.75*buttonOpacity, make_color_rgb(76, 32, 0), _xscale*1.5);
		draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha*0.25*buttonOpacity,c_ltgray, _xscale);
		gpu_set_blendmode(bm_add);
		draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha*0.15*overlay*buttonOpacity, c_white, _xscale);
		gpu_set_blendmode(bm_normal);
	});

	_element.buttonLabel = AddLabel(0,0,0,60,_text, _element);
	SetElementFit(_element.buttonLabel, FIT_HORIZONTAL);
	SetElementAlignment(_element.buttonLabel, AL_DOWNCENTER);
	SetLabel(_element.buttonLabel, c_white, 0.95, 0.95, 1, 10, AL_CENTER);
	
	_element.numberLabel = AddLabel(0,0,0,40, _number,_element);
	SetElementFit(_element.numberLabel, FIT_FULL);
	SetLabel(_element.numberLabel, _stringColor, _stringSize*0.7, _stringSize*0.7, 1, 0, AL_CENTER, font_NotoSansKR_SemiBold64);
	SetButtonSFX_default(_element);
}

function UILib_button_leftBar(_element, _text) {
	_element.leftBarSize = 12;
	_element.clickOffset = 0;
	_element.clickOffset_goal = 0;
	_element.scale_rate = 2;

	draw_set_font(global.FontDefault);
	var _string_width = string_width(_text)*1.55+70;
	_element.element_width = _string_width;
	_element.goal_width = _string_width;

	SetButtonFocusCallback(_element, CALLBACK { clickOffset_goal = 1; goal_scale = 1;});
	SetButtonLeaveCallback(_element, CALLBACK { clickOffset_goal = 0; goal_scale = 1; goal_xscale = 1; goal_yscale = 1});
	SetButtonClickCallback(_element, CALLBACK { clickOffset_goal = 1; goal_xscale = 0.93; goal_yscale = 0.93;});
	SetElementDrawer(_element, DRAWER{
		var buttonColorNow = make_color_rgb(255,lerp(255, 210, clickOffset),lerp(255, 97, clickOffset));
		clickOffset += (clickOffset_goal - clickOffset)/2;
		draw_frame_12rounded(_x1, _y1, _x1+leftBarSize, _y2, _alpha, buttonColorNow, _xscale*0.1);
		draw_frame_12rounded(_x1+leftBarSize, _y1+(0.5-clickOffset*0.5)*(_y2-_y1), _x2, _y2, _alpha*0.15, c_white, _xscale*0.3);
		label.label_color = buttonColorNow;
	});
	_element.label = AddLabel(35,0,_string_width,0, _text, _element);
	SetElementFit(_element.label, FIT_VERTICAL);
	SetLabel(_element.label, c_white, 1.55, 1.55, 1, 5, AL_LEFTCENTER, global.FontDefault);
	SetButtonSFX_default2(_element)
}

function UILib_button_leftBarWithIcon(_element, _text, _iconImage) {
	_element.leftBarSize = 12;
	_element.clickOffset = 0;
	_element.clickOffset_goal = 0;
	_element.scale_rate = 2;

	draw_set_font(global.FontDefault);
	var _string_width = string_width(_text)*1.55+70+35;
	var _iconWidth = _element.total_height;
	_element.element_width = _string_width+_iconWidth;
	_element.goal_width = _string_width+_iconWidth;

	SetButtonFocusCallback(_element, CALLBACK { 
		clickOffset_goal = 1;
		label.label_color = COLOR_JS_LTGOLD;
		iconElement.iconColor = COLOR_JS_LTGOLD;
	});
	SetButtonLeaveCallback(_element, CALLBACK { 
		clickOffset_goal = 0;
		goal_xscale = 1;
		goal_yscale = 1;
		label.label_color = c_white;
		iconElement.iconColor = c_white;
	});
	SetButtonClickCallback(_element, CALLBACK {
		clickOffset_goal = 1;
		goal_xscale = 0.93;
		goal_yscale = 0.93;
		label.label_color = COLOR_JS_LTGOLD;
		iconElement.iconColor = COLOR_JS_LTGOLD;
	});
	SetElementDrawer(_element, DRAWER{
		var buttonColorNow = make_color_rgb(255,lerp(255, 210, clickOffset),lerp(255, 97, clickOffset));
		clickOffset += (clickOffset_goal - clickOffset)/2;
		draw_set_alpha(_alpha)
		draw_set_color(buttonColorNow)
		draw_rectangle(_x1, _y1, _x1+leftBarSize, _y2, 0);
		draw_set_alpha(_alpha*0.1*(1+clickOffset*0.35))
		draw_set_color(c_white)
		draw_rectangle(_x1+leftBarSize, _y1+(0.5-clickOffset*0.5)*(_y2-_y1), _x2, _y2, 0);
	});
	_element.label = AddLabel(70+_iconWidth,0,_string_width,0, _text, _element);
	SetElementFit(_element.label, FIT_VERTICAL);
	SetLabel(_element.label, c_white, 1.55, 1.55, 1, 5, AL_LEFTCENTER, global.FontDefault);
	
	_element.iconElement = AddElement(35,0,_iconWidth,0,_element);
	SetElementFit(_element.iconElement, FIT_VERTICAL);
	_element.iconElement.iconColor = c_white
	_element.iconElement.iconImage = _iconImage
	SetElementDrawer(_element.iconElement, DRAWER{
		var _iconSize = 0.6*total_height/sprite_get_height(iconImage);
		draw_sprite_ext(iconImage, 0, (_x1+_x2)/2, (_y1+_y2)/2, _iconSize*_xscale, _iconSize*_yscale, 0, iconColor,_alpha);
	});
	
	
	SetButtonFocusCallback(_element, CALLBACK { 
		clickOffset_goal = 1;
		label.label_color = make_color_rgb(255,210,97);
		iconElement.iconColor = make_color_rgb(255,210,97);
	});
	SetButtonLeaveCallback(_element, CALLBACK { 
		clickOffset_goal = 0;
		goal_xscale = 1;
		goal_yscale = 1;
		label.label_color = c_white;
		iconElement.iconColor = c_white;
	});
	SetButtonClickCallback(_element, CALLBACK {
		clickOffset_goal = 1;
		goal_xscale = 0.93;
		goal_yscale = 0.93;
		label.label_color = make_color_rgb(255,210,97);
		iconElement.iconColor = make_color_rgb(255,210,97);
	});
	SetButtonSFX_default2(_element);
}
/*
function UILib_button_ItemButton(_element, _selectable = true) {
	_element.selectable = _selectable;
	_element.outLineWidth = 0;
	_element.outLineWidthOffset = _element.outLineWidth;
	SetElementDrawer(_element, DRAWER{
		draw_frame_roundedShadow(_x1,_y1,_x2,_y2, _alpha*0.3, _xscale);
		if (selectable) {
			outLineWidthOffset = SimpleLerp(outLineWidthOffset, outLineWidth, 8);
			if (outLineWidthOffset > 1.7)
				draw_frame_outlineRounded(_x1,_y1,_x2,_y2, _alpha, COLOR_JS_LTGOLD, _xscale*1.3, outLineWidthOffset);
		}
	});
	UILIb_button_scaleAnimationWithHighLight(_element,2);
	
	var topMargin = 70, bottomMargin = 100;
				
	_element.title = AddLabel(0,0,0,topMargin,"78087",_element);
	SetElementFit(_element.title,FIT_HORIZONTAL);
	SetLabel(_element.title, c_white, 1, 1, 1, 0, AL_CENTER);
			
	_element.innerRect = AddElement(0,topMargin,0,topMargin+bottomMargin, _element);
	SetElementFit(_element.innerRect,FIT_FULL);
	SetElementDrawer(_element.innerRect, DRAWER{
		draw_set_alpha(0.15*_alpha);
		draw_set_color(c_black);
		draw_rectangle(_x1,_y1,_x2,_y2,0);
	});
	_element.contentRect = AddElement(0,0,0,0);
	SetElementFit(_element.contentRect,FIT_FULL);
}
*/


function UILib_button_BackButtonWithCircle(_element) {
	_element.scale_rate = 4;
	_element.opacity_rate = 12;
	_element.element_xscale = 0.5;
	_element.element_yscale = 0.5;
	_element.opacity = 0;
	SetElementDrawer(_element, DRAWER{
		draw_sprite_ext(sp_circle_256_256, 0, (_x2+_x1)/2, (_y2+_y1)/2, 0.418*2*_xscale
																	  , 0.418*2*_yscale, 0, c_black, _alpha*0.05);
		gpu_set_blendmode(bm_add);
		draw_sprite_ext(sp_circle_gradationLine_512_512, 0, (_x2+_x1)/2, (_y2+_y1)/2, 0.418*_xscale
																				    , 0.418*_yscale, 0, c_white, _alpha*0.6);
		gpu_set_blendmode(bm_normal);
		draw_sprite_ext(sp_dial_icon, 0, (_x2+_x1)/2, (_y2+_y1)/2, 1*_xscale, 1*_yscale, 0, c_white, _alpha);
	});
	UILIb_button_scaleAnimationWithHighLight(_element, 2, 1, 13, true);
	SetButtonSFX_default2(_element);
}

function UILib_button_BackButton(_element, _iconSize = 1) {
	_element.scale_rate = 4;
	_element.opacity_rate = 12;
	_element.element_xscale = 0.5;
	_element.element_yscale = 0.5;
	_element.opacity = 0;
	_element.clickOffset = 0;
	_element.clickOffsetGoal = 0;
	_element.iconSize = _iconSize;
	SetElementDrawer(_element, DRAWER{
		clickOffset += (clickOffsetGoal - clickOffset)/1.75;
		var _clickWeight =  1 + clickOffset*0.25;
		_xscale *= _clickWeight;
		_yscale *= _clickWeight;
		_alpha *= _clickWeight;
		var _anchorX = (_x1+_x2)/2, _anchorY = (_y1+_y2)/2;
		draw_sprite_ext(sp_circle_gradation_512_512, 0, _anchorX, _anchorY, 0.25*_xscale*iconSize
																				, 0.25*_yscale*iconSize, 0, c_white, abs(clickOffset)*0.5*_alpha);
	
		var _sizeOfIcon = 20*iconSize, _width = 4*_xscale;
		draw_line_sprite(_anchorX+_sizeOfIcon*_xscale, _anchorY+_sizeOfIcon*_yscale, _anchorX-_sizeOfIcon*_xscale, _anchorY-_sizeOfIcon*_yscale, c_white, _alpha, _width);
		draw_line_sprite(_anchorX+_sizeOfIcon*_xscale, _anchorY-_sizeOfIcon*_yscale, _anchorX-_sizeOfIcon*_xscale, _anchorY+_sizeOfIcon*_yscale, c_white, _alpha, _width);
	});
	SetButtonFocusCallback(_element, CALLBACK { clickOffsetGoal = 0.5;});
	SetButtonLeaveCallback(_element, CALLBACK { clickOffsetGoal = 0;});
	SetButtonClickCallback(_element, CALLBACK { clickOffsetGoal = -0.5;});
	SetButtonSFX_default2(_element);
}


function UILib_playerDetailName(_element, _name, _playStyle, _height, _position, rank, _totalStat , _awakeningLevel ,_condition) {
	_element.playerNameLabel = AddLabel(40,30,40+200,100,_name,_element);
	SetElementFit(_element.playerNameLabel,FIT_HORIZONTAL);
	SetLabel(_element.playerNameLabel, c_white, 2,2,1,0,AL_LEFTCENTER);
	_element.playerNameLabel.opacity_rate = 8;
	_element.playerNameLabel.opacity = 0;
	_element.playerNameLabel.position_rate = 4;
	_element.playerNameLabel.origin_x += 50;
	SetElementAlignment(_element.playerNameLabel, AL_LEFTTOP);
	
	draw_set_font(global.FontDefault);
	var _name_width = string_width(_name)*2;
	if (_name_width+60 <= _element.playerNameLabel.total_width) {
		_element.posName = AddLabel(54 + string_width(_name)*2,40,80,60,_position,_element);
		SetLabel(_element.posName, c_ltgray, 1,1,1,0,AL_LEFTCENTER, global.FontDefault, true);
		_element.posName.opacity_rate = 8;
		_element.posName.opacity = 0;
		_element.posName.position_rate = 4;
		_element.posName.origin_x += 50;
		SetElementAlignment(_element.posName, AL_LEFTTOP);
	}
	
	_element.playerHeightLabel = AddLabel(46,120,120,60,string(_height)+ " cm",_element);
	SetLabel(_element.playerHeightLabel, c_white, 1,1,1,0,AL_LEFTCENTER);
	_element.playerHeightLabel.opacity_rate = 8;
	_element.playerHeightLabel.opacity = 0;
	_element.playerHeightLabel.position_rate = 6;
	_element.playerHeightLabel.origin_x += 50;
	SetElementAlignment(_element.playerHeightLabel, AL_LEFTTOP);
	
	if (_awakeningLevel != 0) {
		_element.line1 = AddElement(175,135,2,30,_element);
		_element.line1.opacity_rate = 8;
		_element.line1.opacity = 0;
		_element.line1.position_rate = 6;
		_element.line1.origin_x += 50;
		SetElementDrawer(_element.line1, DRAWER{
			draw_set_color(c_white);
			draw_set_alpha(_alpha*0.15);
			draw_rectangle(_x1,_y1,_x2,_y2,0);
		});
	
		_element.awakeningLevelLabel = AddLabel(200,120,120,60,"+"+string(_awakeningLevel),_element);
		SetLabel(_element.awakeningLevelLabel , COLOR_JS_LTGOLD, 1,1,1,0,AL_LEFTCENTER, global.FontDefault, true);
		_element.awakeningLevelLabel .opacity_rate = 8;
		_element.awakeningLevelLabel .opacity = 0;
		_element.awakeningLevelLabel .position_rate = 6;
		_element.awakeningLevelLabel .origin_x += 50;
		SetElementAlignment(_element.awakeningLevelLabel , AL_LEFTTOP);
	}
	
	if (_position == "Se" || _playStyle == ONEPOINT_STYLE) {
		_element.playStyleLabel = AddLabel(46,170,46+220,60,GetPlayStyleName(_playStyle),_element);
		SetElementFit(_element.playStyleLabel,FIT_HORIZONTAL);
		SetLabel(_element.playStyleLabel, c_ltgray, 1,1,1,0,AL_LEFTCENTER);
		_element.playStyleLabel.opacity_rate = 16;
		_element.playStyleLabel.opacity = 0;
		_element.playStyleLabel.position_rate = 8;
		_element.playStyleLabel.origin_x += 50;
		SetElementAlignment(_element.playStyleLabel, AL_LEFTTOP);
	}
	
	_element.rankElement = AddElement(-30,50,160,160,_element);
	_element.rankElement.opacity_rate = 16;
	_element.rankElement.opacity = 0;
	_element.rankElement.scale_rate = 6;
	_element.rankElement.element_xscale = 0.5;
	_element.rankElement.element_yscale = 0.5;
	_element.rankElement.rank = rank;
	_element.rankElement.totalStat = _totalStat;
	_element.rankElement.maxStat = getMaxStatsFromRank(getRankString(rank));
	_element.rankElement.percentage = 0;
	SetElementAlignment(_element.rankElement, AL_RIGHTTOP);
	SetElementDrawer(_element.rankElement, DRAWER{
		//DrawRank(rank, (_x1+_x2)/2, (_y1+_y2)/2, _xscale*1.25, _yscale*1.25, _alpha);
		var _rankString = getRankString(rank);
		var _color = getRankColor(_rankString);
		var _xpos = (_x1+_x2)/2, _ypos = (_y1+_y2)/2;
		percentage = SimpleLerp(percentage, totalStat/maxStat, 8);
		draw_sprite_ext(sp_circle_256_256,0,_xpos, _ypos, _xscale*0.7, _yscale*0.7, 0, _color, _alpha*0.1);
		draw_sprite_ext(sp_circle_256_256,0,_xpos, _ypos, _xscale*0.75, _yscale*0.75, 0, c_black, _alpha*0.06);
		draw_sprite_pie_reverse(sp_circle_gradationLine_512_512, 2,  _xpos, _ypos, -50, 230, c_ltgrey, _alpha*0.2, _xscale*0.3, _yscale*0.3);
		draw_sprite_pie_reverse(sp_circle_gradationLine_512_512, 2,  _xpos, _ypos, -50, -50 + 280*percentage, _color, _alpha, _xscale*0.3, _yscale*0.3);
		draw_set_font(font_NotoSansKR_SemiBold64);
		draw_set_halign(fa_middle);
		draw_set_valign(fa_center);
		draw_set_color(_color);
		draw_set_alpha(_alpha);
		draw_text_transformed(_xpos, _ypos,_rankString,_xscale*0.6, _yscale*0.6,0);
		if (totalStat == maxStat) {
			draw_set_color(_color);
			draw_text_transformed(_xpos, _ypos + 63*_yscale,"MAX",_xscale*0.34, _yscale*0.35,0);
		}
		else {
			draw_set_font(global.FontDefault);
			draw_set_color(c_white);
			draw_text_transformed(_xpos, _ypos + 63*_yscale,string(totalStat)+"/"+string(maxStat),_xscale*0.7, _yscale*0.7,0);
		}
	});
}

function UILib_orangeFrameIcon(_element, _sprite, _spriteSize = 0.9, _iconColor = c_dkgray, _frameColor = COLOR_JS_LTGOLD, _frameAlpha = 1) {
	_element.iconSprite = _sprite;
	_element.spriteSize = _spriteSize;
	SetElementDrawer(_element, DRAWER{
		draw_frame_12rounded(_x1,_y1,_x2,_y2,_alpha*frameAlpha,frameColor,_xscale*0.5);
		draw_sprite_ext(iconSprite, 0,  (_x1+_x2)/2, (_y1+_y2)/2, spriteSize*_xscale, spriteSize*_yscale, 0,iconColor,_alpha);
	}, {iconColor:_iconColor, frameColor : _frameColor, frameAlpha : _frameAlpha});
}


function UILib_labelGradation(_element, _xscale, _yscale, _bgColor = c_black, _frameAlpha = 1) { // seungmin
	_element.bgColor = _bgColor;
	_element.xscale = _xscale;
	_element.yscale = _yscale;
	SetElementDrawer(_element, DRAWER{
		draw_sprite_ext(sp_popupGradation, 1,(_x1+_x2)/2, (_y1+_y2)/2, xscale*_xscale, yscale*_yscale, 0,bgColor,_alpha);
	});
}


function AddCurrencyStruct(_struct1 = {}, _struct2 = {}) {
	var _currency = GetCurrencyNameArray();
	var _res_struct = {};
	
	for (var i = 0; i < array_length(_currency); i ++) {
		var _key = _currency[i];
		if (variable_struct_exists(_struct1, _key)) {
			if (variable_struct_exists(_res_struct, _key)) {
				_res_struct[$ _key] += _struct1[$ _key];
			}
			else {
				_res_struct[$ _key] = _struct1[$ _key];
			}
		}
		if (variable_struct_exists(_struct2, _key)) {
			if (variable_struct_exists(_res_struct, _key)) {
				_res_struct[$ _key] += _struct2[$ _key];
			}
			else {
				_res_struct[$ _key] = _struct2[$ _key];
			}
		}
	}
	return _res_struct;
}

function MultiplyCurrencyStruct(_struct = {}, _time = 1) {
	var _res_struct = {};
	var _mstruct = variableStruct_copy(_struct);
	
	for (var i = 0; i < _time; i ++) {
		_res_struct = AddCurrencyStruct(_res_struct, _mstruct);
	}
	return _res_struct;
}

function UILib_priceTag(_element, _struct = {}, color = c_white, scale = 1) {
	var _length = [];
	var _currency =  GetCurrencyNameArray();
	for (var i = 0; i < array_length(_currency); i ++) {
		array_push(_length, 0);
	}
	var _iconSize = 80*scale;
	var _textSize = 0.55*scale; 
	var show_struct = {};
	for (var i = 0; i < array_length(_currency); i ++) {
		struct_set(show_struct, _currency[i], INF);
	}
	
	draw_set_font(font_NotoSansKR_SemiBold64);
	for (var i = 0; i < array_length(_currency); i ++) {
		if (!variable_struct_exists(_struct, _currency[i]))
			show_struct[$_currency[i]] = INF;
		else
			show_struct[$_currency[i]] = insert_comma(_struct[$_currency[i]]);
			
		if (show_struct[$_currency[i]] != INF)
			_length[i] = string_width(string(show_struct[$_currency[i]]))+_iconSize/_textSize;
	}
	
	_element.show_struct = show_struct;
	_element._length = _length;
	_element.color = color;
	_element.scale = scale;
	SetElementDrawer(_element, DRAWER{
		var _totalLength = 0;
		var _currency =  GetCurrencyNameArray();
		var _maxLength = 0;
		for (var i = 0; i < array_length(_currency); i ++) {
			_maxLength += _length[i];
		}
		draw_set_font(font_NotoSansKR_SemiBold64);
		draw_set_color(color);
		draw_set_alpha(_alpha);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		
		var _iconSize = 80*scale;
		var _textSize = 0.55*scale;
		for (var i = 0; i < array_length(_currency); i ++) {
			if (show_struct[$ _currency[i]] == INF) continue;
			draw_sprite_ext(GetCurrencySpriteByName( _currency[i]), 0, (_x1+_x2)/2 + ((_totalLength-_maxLength/2)* _textSize + _iconSize/2)*_xscale,(_y1+_y2)/2
							,_xscale*0.5*scale,_yscale*0.5*scale,0,c_white,_alpha);
			draw_text_transformed((_x1+_x2)/2 + ((_totalLength -_maxLength/2)* _textSize + _iconSize)*_xscale, (_y1+_y2)/2
							, show_struct[$ _currency[i]], _xscale*_textSize, _yscale*_textSize,0);
			_totalLength += _length[i];
		}
	});
}
function UILib_priceTagVertical(_element, _struct = {}, color = c_white, _scale = 1, _interval = 50) {
	var _length = 0;
	var _currency = GetCurrencyNameArray();
	var _iconSize = 80;
	var _textSize = 0.55;
	var _totalCurrencyHeight = 0;
	var show_struct = {};
	for (var i = 0; i < array_length(_currency); i ++) {
		struct_set(show_struct, _currency[i], INF);
	}
	draw_set_font(font_NotoSansKR_SemiBold64);
	for (var i = 0; i < array_length(_currency); i ++) {
		if (!variable_struct_exists(_struct, _currency[i]))
			show_struct[$ _currency[i]] = INF;
		else
			show_struct[$ _currency[i]] = insert_comma(_struct[$_currency[i]]);
			
		if (show_struct[$ _currency[i]] != INF) {
			var _len = string_width(string(show_struct[$_currency[i]]));
			if (_len > _length)
			_length = string_width(string(show_struct[$_currency[i]]));
			
			_totalCurrencyHeight += _interval
		}
	}
	
	_element.show_struct = show_struct;
	_element._length = _length;
	_element.color = color;
	_element._scale = _scale;
	_element._interval = _interval;
	_element._totalCurrencyHeight = _totalCurrencyHeight;
	SetElementDrawer(_element, DRAWER{
		_xscale *= _scale;
		_yscale *= _scale;
		draw_set_font(font_NotoSansKR_SemiBold64);
		draw_set_color(color);
		draw_set_alpha(_alpha);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		
		var _currency = GetCurrencyNameArray();
		var _iconSize = 50;
		var _textSize = 0.55;
		var hh = 0;
		var _an_x = (_x1+_x2)/2 - (_length*_textSize + _iconSize - 25)*_xscale/2;
		var _an_y = (_y1+_y2)/2 - (_totalCurrencyHeight-_interval)*_yscale/2
		for (var i = 0; i < array_length(_currency); i ++) {
			if (show_struct[$ _currency[i]] == INF) continue;
			
			draw_sprite_ext(GetCurrencySpriteByName( _currency[i]), 0, _an_x,_an_y + hh
							,_xscale*0.5,_yscale*0.5,0,c_white,_alpha);
			draw_text_transformed(_an_x + _xscale*_iconSize, _an_y + hh
							, show_struct[$ _currency[i]], _xscale*_textSize, _yscale*_textSize,0);
			hh += _interval *_yscale;
		}
	});
}

function UILIb_button_help(_button, idx) {
	with (_button) {
		SetElementDrawer(self, DRAWER{
			draw_sprite_ext(sp_icon_info_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha*0.7);
		});
		UILIb_button_scaleAnimation(self);
		SetButtonCallback(self, CALLBACK {
			ShowPopupHelps(idx);
		}, {idx:idx});
	}
}

function UILIb_effect_rotatingOutline(_element, _lineWidth = 8, _color = COLOR_JS_ORANGE, _frameScale = 1, _outlineAlpha = 1) {
	with (AddElement(0, 0, 0, 0, _element)) {
		SetElementFit(self, FIT_FULL);
		SetElementVariables(self, {
			__surf         : -1,
			__surf2        : -1,
			__lineWidth    : _lineWidth,
			__dir          : 0,
			__color        : _color,
			__frameScale   : _frameScale,
			__outlineAlpha : _outlineAlpha,
		});
		SetElementDeleteAction(self, CALLBACK {
			if (surface_exists(__surf)) {
				surface_free(__surf);
			}
			if (surface_exists(__surf2)) {
				surface_free(__surf2);
			}
		});
		SetElementDrawer(self, DRAWER{
			__dir -= 1;
			if (__dir < 0) {
				__dir += 360;
			}
			var _original_width = element_parent.total_width/element_parent.element_xscale;
			var _original_height = element_parent.total_height/element_parent.element_yscale;
			var __W = _original_width + __lineWidth*2;
			var __H = _original_height + __lineWidth*2;
			if (!surface_exists(__surf)) {
				__surf = surface_create(__W, __H);
			}
			else {
				if (surface_get_width(__surf) != __W || surface_get_height(__surf) != __H) {
					surface_free(__surf);
					__surf = surface_create(__W, __H);
				}
			}
			if (!surface_exists(__surf2)) {
				__surf2 = surface_create(100, 100);
				surface_set_target(__surf2);
				draw_clear_alpha(c_black, 0);
				draw_sprite_ext(sp_dial_talker_gradiant, 0, -50, 0, 100/2, 2*100/256, -90, c_white, 1);
				draw_sprite_ext(sp_dial_talker_gradiant, 0, 100-50 + 100, 100, 100/2, 2*100/256, 90, c_white, 1);
				surface_reset_target();
			}
			var __x1 = __lineWidth, __y1 = __lineWidth, __x2 = __lineWidth + _original_width, __y2 = __lineWidth + _original_height;
			var __rad = sqrt(sqr(__W) + sqr(__H));
			var __a_x = (__x1+__x2)/2 + lengthdir_x(-__rad/2 ,__dir) + lengthdir_x(-__rad/2 ,__dir- 90), __a_y = (__y1+__y2)/2 + lengthdir_y(-__rad/2 ,__dir) + lengthdir_y(-__rad/2 ,__dir- 90);
			
			surface_set_target(__surf);
			draw_clear_alpha(c_black,0);
			draw_frame_outlineRounded(__x1, __y1, __x2, __y2,_alpha, c_white,_xscale*__frameScale, __lineWidth);
			gpu_set_blendmode(bm_subtract);
			draw_surface_ext(__surf2, __a_x, __a_y, __rad/100, __rad/100, __dir, c_white, 1);
			gpu_set_blendmode(bm_normal);
			surface_reset_target();
			gpu_set_blendmode(bm_add);
			repeat (7) {
				draw_surface_ext(__surf, _x1-__lineWidth*_xscale, _y1-__lineWidth*_yscale, _xscale, _yscale,0, __color, _alpha*__outlineAlpha);
			}
			gpu_set_blendmode(bm_normal);
		});
	}
}

function UILIb_simpleOutline(_element, _lineWidth = 8, _color = COLOR_JS_ORANGE, _frameScale = 1, _outlineAlpha = 1) {
	with (AddElement(0, 0, 0, 0, _element)) {
		SetElementFit(self, FIT_FULL);
		SetElementVariables(self, {
			__lineWidth    : _lineWidth,
			__color        : _color,
			__frameScale   : _frameScale,
			__outlineAlpha : _outlineAlpha,
			animationNow   : 0,
		});
		SetElementDeleteAction(self, CALLBACK {});
		SetElementDrawer(self, DRAWER{
			animationNow += 1;
			var _cycle = 30
			if (animationNow > pi*2*_cycle) // 주기
				animationNow -= pi*2*_cycle;
			var _frameAlpha = 0.45+abs(sin(animationNow/_cycle))*0.55
			draw_frame_outlineRounded(_x1,_y1,_x2,_y2,_alpha*_frameAlpha * __outlineAlpha, __color,_xscale*__frameScale, __lineWidth);
		});
	}
}