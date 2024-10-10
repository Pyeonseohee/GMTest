// v2.3.0에 대한 스크립트 어셋 변경됨 자세한 정보는
// https://help.yoyogames.com/hc/en-us/articles/360005277377 참조
function UILib_SimplePlayerViewer(_element, _mergedPlayerData = 0, _isTransparent = true){
	// 280 * 280 정사각형 사이즈를 권장합니다.
	if (_mergedPlayerData == 0) {
		_mergedPlayerData = { name : "NO DATA"
							, height : 300
							, rank : 14
							, hair : irandom(10)
							, uniform : irandom(10)
							, shoes : irandom(10)
							, playStyle : TYPE_NISHIKAWA
							, position : "?"
		};
	}
	
	_element.mergedPlayerData = _mergedPlayerData;
	//_element.i = CO_LOCAL.i;
	//_element.clickOffset = 0;
	//_element.clickOffsetGoal = 0;
	_element.isPlayerButtonFocused = false;
	_element.isPlayerButtonFocusedOffset = false;
	_element.playerButtonOutlineColor = c_white;
	_element.playerModelSurf = pointer_null;
	_element._isTransparent = _isTransparent;
	SetElementDrawer(_element, DRAWER{ // 선수 버튼 드로우 하는 부분.
		//clickOffset = SimpleLerp(clickOffset , clickOffsetGoal, 8);
		isPlayerButtonFocusedOffset = SimpleLerp(isPlayerButtonFocusedOffset , isPlayerButtonFocused, 3);
		
		if (!instance_exists(obj_ui_playerModelDrawer)) {
			instance_create_depth(0,0,0,obj_ui_playerModelDrawer);
			return;
		}
		//draw_frame_glow1(_x1,_y1,_x2,_y2,_alpha*0.65,c_black,_xscale*1.5);
		//draw_frame_roundedLineEdge(_x1,_y1,_x2,_y2,_alpha*0.35,_xscale);
		//draw_frame_roundedShadow(_x1,_y1,_x2,_y2,_alpha*0.35,_xscale*1.2);
		//draw_sprite_ext(playerModelImage,0,_x1 , _y1,_xscale, _yscale,0,c_white,_alpha*0.85);
		if (playerModelSurf == pointer_null || !surface_exists(playerModelSurf))
			playerModelSurf = obj_ui_playerModelDrawer.CreatePlayerModelByMergedPlayerData(mergedPlayerData, _isTransparent);
		draw_surface_ext(playerModelSurf,_x1 , _y1,_xscale, _yscale,0,c_white,_alpha);
		
		if (isPlayerButtonFocusedOffset > 0.1) { // 테두리 
			var _margin = -isPlayerButtonFocusedOffset*1;
			draw_frame_outlineRounded(_x1-_margin,_y1-_margin,_x2+_margin,_y2+_margin
									,_alpha*isPlayerButtonFocusedOffset
									, playerButtonOutlineColor, 1.3*_xscale*(element_width+_margin*2)/element_width, isPlayerButtonFocusedOffset*6+.4);
		}
		/*if (clickOffset > 0.01) {// 오버레이
			gpu_set_blendmode(bm_add);
			draw_frame_12rounded(_x1,_y1,_x2,_y2,_alpha*0.4*clickOffset,COLOR_JS_ORANGE,_xscale);
			gpu_set_blendmode(bm_normal);
		}*/
	});		
	SetElementDeleteAction(_element , CALLBACK{ if (playerModelSurf != pointer_null && !surface_exists(playerModelSurf)) surface_free(playerModelSurf);});
	//SetButtonFocusCallback(_element, CALLBACK { goal_xscale = 1+0.02; goal_yscale = 1+0.02; clickOffsetGoal = 0.5;});
	//SetButtonLeaveCallback(_element, CALLBACK { goal_xscale = 1; goal_yscale = 1; clickOffsetGoal = 0;});
	//SetButtonClickCallback(_element, CALLBACK { goal_xscale = 1-0.02; goal_yscale = 1-0.02; clickOffsetGoal = 1;});
	SetButtonSFX_default2(_element);
}

function UILib_SimplePlayerViewer_seungmin(_element, _mergedPlayerData = 0, _isTransparent = true){
	// 280 * 280 정사각형 사이즈를 권장합니다.
	if (_mergedPlayerData == 0) {
		_mergedPlayerData = { name : "NO DATA"
							, height : 300
							, rank : 14
							, hair : irandom(10)
							, uniform : irandom(10)
							, shoes : irandom(10)
							, playStyle : TYPE_NISHIKAWA
							, position : "?"
		};
	}
	
	_element.mergedPlayerData = _mergedPlayerData;
	//_element.i = CO_LOCAL.i;
	//_element.clickOffset = 0;
	//_element.clickOffsetGoal = 0;
	_element.isPlayerButtonFocused = false;
	_element.isPlayerButtonFocusedOffset = false;
	_element.playerButtonOutlineColor = c_white;
	_element.playerModelSurf = pointer_null;
	_element._isTransparent = _isTransparent;
	SetElementDrawer(_element, DRAWER{ // 선수 버튼 드로우 하는 부분.
		//clickOffset = SimpleLerp(clickOffset , clickOffsetGoal, 8);
		isPlayerButtonFocusedOffset = SimpleLerp(isPlayerButtonFocusedOffset , isPlayerButtonFocused, 3);
		
		if (!instance_exists(obj_ui_playerModelDrawer)) {
			instance_create_depth(0,0,0,obj_ui_playerModelDrawer);
			return;
		}
		//draw_frame_glow1(_x1,_y1,_x2,_y2,_alpha*0.65,c_black,_xscale*1.5);
		//draw_frame_roundedLineEdge(_x1,_y1,_x2,_y2,_alpha*0.35,_xscale);
		//draw_frame_roundedShadow(_x1,_y1,_x2,_y2,_alpha*0.35,_xscale*1.2);
		//draw_sprite_ext(playerModelImage,0,_x1 , _y1,_xscale, _yscale,0,c_white,_alpha*0.85);
		if (playerModelSurf == pointer_null || !surface_exists(playerModelSurf))
			playerModelSurf = obj_ui_playerModelDrawer.CreatePlayerModelByMergedPlayerData(mergedPlayerData, !_isTransparent);
		var centerX = (_x1 + _x2) / 2 - 140;
		var centerY = (_y1 + _y2) / 2 - 140;

		draw_surface_ext(playerModelSurf, centerX, centerY, _xscale, _yscale, 0, c_white, _alpha);
	
		if (isPlayerButtonFocusedOffset > 0.1) { // 테두리 
			var _margin = -isPlayerButtonFocusedOffset*1;
			draw_frame_outlineRounded(_x1-_margin,_y1-_margin,_x2+_margin,_y2+_margin
									,_alpha*isPlayerButtonFocusedOffset
									, playerButtonOutlineColor, 1.3*_xscale*(element_width+_margin*2)/element_width, isPlayerButtonFocusedOffset*6+.4);
		}
		/*if (clickOffset > 0.01) {// 오버레이
			gpu_set_blendmode(bm_add);
			draw_frame_12rounded(_x1,_y1,_x2,_y2,_alpha*0.4*clickOffset,COLOR_JS_ORANGE,_xscale);
			gpu_set_blendmode(bm_normal);
		}*/
	});		
	SetElementDeleteAction(_element , CALLBACK{ if (playerModelSurf != pointer_null && !surface_exists(playerModelSurf)) surface_free(playerModelSurf);});
	//SetButtonFocusCallback(_element, CALLBACK { goal_xscale = 1+0.02; goal_yscale = 1+0.02; clickOffsetGoal = 0.5;});
	//SetButtonLeaveCallback(_element, CALLBACK { goal_xscale = 1; goal_yscale = 1; clickOffsetGoal = 0;});
	//SetButtonClickCallback(_element, CALLBACK { goal_xscale = 1-0.02; goal_yscale = 1-0.02; clickOffsetGoal = 1;});
	SetButtonSFX_default2(_element);
}

function UILib_condtions(_element, condition_angry, condition_careless, condition_focus, condition_sad) {
	_element.condtionValues = [condition_angry, condition_careless, condition_focus, condition_sad];
	SetElementDrawer(_element, DRAWER {
		var condtionColors = [make_color_rgb(217, 102, 91), make_color_rgb(145, 153, 98), make_color_rgb(242, 206, 162), make_color_rgb(128, 145, 242)];
		var currLength = 0;
		
		var _margin = 70;
		var _height = 50;
		draw_set_valign(fa_middle);
		draw_set_halign(fa_left);
		draw_set_font(global.FontDefault);
		draw_set_alpha(_alpha*0.9);
		draw_set_color(c_black);
		for (var i = 0; i < 4; i ++) {
			var _arrows;
			if (condtionValues[i] == 0) { // 0
				_arrows = -3;
			}
			else if (condtionValues[i] <= 100) { // 100 이하
				_arrows = -2;
			}
			else if (condtionValues[i] <= 300) { // 300 이하
				_arrows = -1;
			}
			else if (condtionValues[i] < 500) {
				_arrows = 0;
			}
			else if (condtionValues[i] < 600) {
				_arrows = 1;
			}
			else { // 600 이상
				_arrows = 2;
			}
			
			if (_arrows == 0) continue;
			
			var _length = 100;
			/*draw_frame_outlineRounded( _x1 + currLength*_xscale
								, (_y1+_y2)/2 - _height*_yscale/2
								, _x1 + (currLength + _length)*_xscale
								, (_y1+_y2)/2 + _height*_yscale/2
								, _alpha*0.5, condtionColors[i],0.5, 4);*/
			draw_sprite_ext(sp_icon_conditions_01,i,_x1 + (32+currLength)*_xscale, (_y1+_y2)/2, _xscale*0.75, _yscale*0.75, 0, condtionColors[i], _alpha);
			if (_arrows == -3) {
				draw_sprite_ext(sp_dial_icon, 0
									,_x1 + (currLength + _length - 20)*_xscale
									, (_y1+_y2)/2
									,_xscale*0.3
									,_yscale*0.3
									,0 , condtionColors[i], _alpha);
			}
			else {
				for (var j = 0; j < abs(_arrows); j ++) {
					draw_sprite_ext(s_icon_arrow, 0
									,_x1 + (currLength + _length - 20)*_xscale
									, (_y1+_y2)/2 + (j - (abs(_arrows)-1)/2) * 10
									,_xscale*0.5
									,_yscale*0.5
									,90*((_arrows > 0)*2-1) , condtionColors[i], _alpha);
				}
			}
			/*draw_text_transformed(_x1 + (currLength + _length - 80)*_xscale
								, (_y1+_y2)/2
								, string(condtionValues[i]/1000)+"%",_xscale,_yscale,0);*/
			
			currLength += _length + _margin;
		}
	});
}

function UILib_AddImageFit(_element, _image) {
	_element.imageElement = AddElement(0,0,0,0,_element);
	_element.imageElement.image_ = _image;
	SetElementFit(_element.imageElement, FIT_FULL);
	SetElementDrawer(_element.imageElement, DRAWER{
		draw_sprite_ext(image_,0,_x1,_y1
						,(_x2-_x1)/sprite_get_width(image_)
						,(_y2-_y1)/sprite_get_height(image_)
						,0,c_white, _alpha);
	});
}
function UILib_AddGradationFit(_element, _color, _alpha, _roundness = 12, _subimg = 0) { 
	_element.gradationElement = AddElement(0,0,0,0,_element);
	_element.gradationElement.color_ = _color;
	_element.gradationElement.opacity = _alpha;
	_element.gradationElement._roundness = _roundness;
	_element.gradationElement._subimg = _subimg; // seungmin
	SetElementFit(_element.gradationElement, FIT_FULL);
	SetElementDrawer(_element.gradationElement, DRAWER{
		draw_frame_gradation(_x1,_y1,_x2,_y2,_alpha,color_,_roundness/12, _subimg);
	});
	return _element.gradationElement;
}

function UILib_LoadAnimation(_element, color = c_white){
	_element.animationNow = 0;
	_element.opacity_rate = 8;
	_element.opacity = 0;
	_element.scale_rate = 8;
	_element.element_xscale = 0.5;
	_element.element_yscale = 0.5;
	_element.color = color;
	SetElementDrawer(_element, DRAWER{
		var _bars = 4;
		var _barMargin = 50*_xscale;
		var _barWidth = 15*_xscale;
		animationNow += 1;
		if (animationNow > pi*2*5)
			animationNow -= pi*2*5;
		for (var i = 0; i < _bars; i++) {
			var _barHeight = (40 * max(sin(-animationNow/5+ i * 0.75),0)+30)*_yscale;
			var _x = (_x1+_x2)/2 + _barMargin*(i - (_bars-1)/2), _y = (_y1+_y2)/2
			draw_frame_12rounded(_x-_barWidth/2,_y-_barHeight/2,_x+_barWidth/2,_y+_barHeight/2,_alpha,color,_xscale*0.5);
		}
	});
}

function UILib_ScrollBar(_element, _scrollTarget, _alpha = 0.1) {
	_element._scrollTarget = _scrollTarget;
	_element._scrollBarAlpha = 0;
	_element._scrollBarCheck = 0//_scrollTarget.scrollNow/_scrollTarget.scrollMax;
	_element._scrollBarFixedAlpha = _alpha
	SetElementDrawer(_element, DRAWER{
		draw_set_alpha(_alpha*_scrollBarFixedAlpha*min(_scrollBarAlpha, 1));
		draw_set_color(c_white);
		//draw_rectangle(_x1,_y1,_x2,_y2, 0);
		var _isScrollHorizontal = _scrollTarget.isScrollHorizontal;
		var _viewArea = _isScrollHorizontal? _scrollTarget.total_width : _scrollTarget.total_height;
		var _rate = _viewArea/_scrollTarget.scrollMax;
		if (_scrollBarCheck != _scrollTarget.scrollNow/_scrollTarget.scrollMax) {
			_scrollBarCheck = _scrollTarget.scrollNow/_scrollTarget.scrollMax;
			_scrollBarAlpha = 10;
		}
		else {
			_scrollBarAlpha = SimpleLerp(_scrollBarAlpha, 0, 8);
		}
		if (_scrollBarAlpha >= 0) {
			var _pos = _scrollBarCheck;
			if (_isScrollHorizontal) {
				_pos = (_x2-_x1)*_pos + _x1;
				draw_rectangle(max(_pos,_x1),_y1,min(_pos + (_x2-_x1)*_rate,_x2),_y2, 0);
			}
			else {
				_pos = (_y2-_y1)*_pos + _y1;
				draw_rectangle(_x1,max(_pos,_y1),_x2,min(_pos+ (_y2-_y1)*_rate, _y2), 0);
			}
		}
	});
}

function UILib_innerOrangeFrameIcon(_element, _sprite, _title, _subTitle = "", _spriteSize = 1, _iconColor = c_dkgray, _frameColor = COLOR_JS_LTGOLD, _frameAlpha = 1) {
	var _mainTextSize = 1.85;
	_spriteSize *= 0.9
	_element.IconArea = AddElement(50,-50,150,150, _element);
	SetElementAlignment(_element.IconArea, AL_LEFTDOWN);
	UILib_orangeFrameIcon(_element.IconArea, _sprite, _spriteSize, _iconColor, _frameColor, _frameAlpha);


	_element.NameLabel = AddLabel(50 + 180,-80,230 + 50,120, _title, _element);// 스토리 //*LANGUAGE_APPLIED
	SetElementFit(_element.NameLabel, FIT_HORIZONTAL);
	SetElementAlignment(_element.NameLabel, AL_LEFTDOWN)
	SetLabel(_element.NameLabel, c_white, _mainTextSize, _mainTextSize,1,0,AL_LEFTTOP);
	
	if (_subTitle != "") {
		_element.subLabel = AddLabel(50 + 180,-60,230,120,_subTitle, _element);
		SetElementFit(_element.subLabel, FIT_HORIZONTAL);
		SetElementAlignment(_element.subLabel, AL_LEFTDOWN)
		SetLabel(_element.subLabel, c_white, _mainTextSize*0.75, _mainTextSize*0.75,0.85,0,AL_LEFTDOWN);
	}
}

function UILib_selectPlayTitle(_element, _sprite, _title, _icon_leftPadding = 0, _title_leftPadding = 110, _top_padding = 80, _spriteSize = 1, _iconColor = c_white, _frameAlpha = 1) { // seungmin
	var _mainTextSize = 1.9;
	_spriteSize *= 0.9
	
	//UILib_transparentFrameIcon(_element.IconArea, _sprite, _spriteSize, _iconColor, _frameAlpha);
	
	
	_element.titleArea = AddElement(0,_top_padding,580,200,_element);
	SetElementAlignment(_element.titleArea, AL_TOPCENTER);
	
	var _text_width = string_width(_title) * _mainTextSize;
	var _modified_x = (580 - (_text_width + _title_leftPadding)) /2
	
	_element.titleArea.IconArea = AddElement(_modified_x,_top_padding,100,100, _element.titleArea);
	SetElementAlignment(_element.titleArea.IconArea, AL_LEFTCENTER);
	
	_element.titleArea.IconArea.iconSprite = _sprite;
	_element.titleArea.IconArea.spriteSize = _spriteSize;
	_element.titleArea.IconArea.iconColor = _iconColor;
	SetElementDrawer(_element.titleArea.IconArea, DRAWER{
		draw_sprite_ext(iconSprite, 0,  (_x1+_x2)/2, (_y1+_y2)/2, spriteSize*_xscale, spriteSize*_yscale, 0,iconColor,_alpha);
	});
	
	_element.titleArea.NameLabel = AddLabel(_title_leftPadding + _modified_x,_top_padding,_text_width,200, _title, _element.titleArea);// 스토리 //*LANGUAGE_APPLIED
	//SetElementFit(_element.titleArea.NameLabel, FIT_HORIZONTAL);
	SetElementAlignment(_element.titleArea.NameLabel, AL_LEFTCENTER)
	SetLabel(_element.titleArea.NameLabel, c_white, _mainTextSize, _mainTextSize,1,0,AL_LEFTCENTER);
	
}

function UILib_gradationIconLabelButton(_element, _sprite, _spriteSize, spriteColor, _text, _textSize, _textColor, _leftMargin = 100){
	
	
	
	SetElementDrawer(_element, DRAWER{
					draw_frame_glow1(_x1,_y1,_x2,_y2,_alpha*0.85, c_black,_xscale);
					draw_frame_12rounded(_x1,_y1,_x2,_y2,_alpha*0.65, c_black,_xscale);
					draw_frame_gradation(_x1,_y1,_x2,_y2,_alpha*0.15, c_white, _xscale, 2);
				});	
				
			_element.IconArea = AddElement(_leftMargin,0,0,0, _element);
			_element.IconArea.icon = _sprite;
			_element.IconArea.spriteSize = _spriteSize;
			_element.IconArea.spriteColor = spriteColor;
			SetElementAlignment(_element.IconArea, AL_LEFTCENTER);
			SetElementDrawer(_element.IconArea, DRAWER{
				draw_sprite_ext(icon, 0,  (_x1+_x2)/2, (_y1+_y2)/2, spriteSize*_xscale, spriteSize*_yscale, 0,spriteColor,_alpha);
			});
	
			_element.labelArea = AddLabel(20, 0, _element.element_width, _element.element_height, _text,_element);


			SetElementAlignment(_element.labelArea, AL_CENTER)
			SetLabel(_element.labelArea, _textColor, _textSize, _textSize,1,0,AL_CENTER);

}
function UILib_gradationIconButton(_element, _sprite, _spriteSize, spriteColor){
	
	
	
	SetElementDrawer(_element, DRAWER{
					draw_frame_glow1(_x1,_y1,_x2,_y2,_alpha*0.85, c_black,_xscale);
					draw_frame_12rounded(_x1,_y1,_x2,_y2,_alpha*0.65, c_black,_xscale);
					draw_frame_gradation(_x1,_y1,_x2,_y2,_alpha*0.15, c_white, _xscale, 2);
				});	
				
			_element.IconArea = AddElement(0,0,0,0, _element);
			_element.IconArea.icon = _sprite;
			_element.IconArea.spriteSize = _spriteSize;
			_element.IconArea.spriteColor = spriteColor;
			SetElementFit(_element.IconArea, FIT_FULL);
			SetElementDrawer(_element.IconArea, DRAWER{
				draw_sprite_ext(icon, 0,  (_x1+_x2)/2, (_y1+_y2)/2, spriteSize*_xscale, spriteSize*_yscale, 0,spriteColor,_alpha);
			});

}

function UILib_gradationLabelButton(_element, _text, _textSize, _textColor ){
	
	SetElementDrawer(_element, DRAWER{
					draw_frame_glow1(_x1,_y1,_x2,_y2,_alpha*0.85, c_black,_xscale);
					draw_frame_12rounded(_x1,_y1,_x2,_y2,_alpha*0.65, c_black,_xscale);
					draw_frame_gradation(_x1,_y1,_x2,_y2,_alpha*0.15, c_white, _xscale, 2);
				});	
				
	
		_element.labelArea = AddLabel(0, 0, _element.element_width, _element.element_height, _text,_element);

		SetElementAlignment(_element.labelArea, AL_CENTER)
		SetLabel(_element.labelArea, _textColor, _textSize, _textSize,1,0,AL_CENTER);

}

function UILib_gradationLabel(_element, _subTitle = "", _mainTextSize = 2){ // seungmin
	
		_element.subArea = AddElement(0,+165,300,120,_element); // 버튼
		UILib_labelGradation(_element.subArea, 15,1, c_black, 1);
		SetElementAlignment(_element.subArea, AL_TOPCENTER);

		_element.subLabel = AddLabel(0,+165,230,120,_subTitle, _element);
		SetElementFit(_element.subLabel, FIT_HORIZONTAL);
		SetElementAlignment(_element.subLabel, AL_TOPCENTER)
		SetLabel(_element.subLabel, c_white, _mainTextSize*0.65, _mainTextSize*0.65,0.85,0,AL_CENTER);
}


function UILib_centerIconLabel(_element, _totalWidth, _text, _mainTextSize, _gap = 0, _iconSprite = -1, _iconSize = 0, _subimg = 0, _text_color = c_white, _icon_color = c_white){ // seungmin
		draw_set_font(global.FontDefault);
		var _text_width = string_width(_text) * _mainTextSize;
		var _modified_width = min(_text_width,_element.element_width)
		var _text_x = (_totalWidth - ( _modified_width)) / 2;
			
		if(_iconSprite != -1){
			var _sprite_width = sprite_get_width(_iconSprite) * _iconSize; 
			var _sprite_height = sprite_get_height(_iconSprite) * _iconSize;
			
			var _modified_x = (_totalWidth - (_sprite_width + _gap + _modified_width)) / 2 - 10;
			_text_x = _modified_x + _sprite_width + _gap;
	
			_element.IconArea = AddElement(_modified_x,0,_sprite_width,_sprite_height, _element);
			SetElementAlignment(_element.IconArea, AL_LEFTCENTER);
		
			_element.IconArea.sprite = _iconSprite;
			_element.IconArea.iconSize = _iconSize;
			_element.IconArea.icon_color = _icon_color;
			_element.IconArea.subimg = _subimg;
			SetElementDrawer(_element.IconArea, DRAWER{
				draw_sprite_ext(sprite, subimg,  (_x1+_x2)/2, (_y1+_y2)/2, iconSize*_xscale, iconSize*_yscale, 0,icon_color,_alpha);
			});
		}
		
		
	
		_element.labelArea = AddLabel(_text_x, 0, _modified_width, _element.element_height, _text,_element);
		//SetElementFit(_element.bottomArea.ItemCountLabel, FIT_HORIZONTAL);
		SetElementAlignment(_element.labelArea, AL_LEFTCENTER)
		SetLabel(_element.labelArea, _text_color, _mainTextSize, _mainTextSize,1,0,AL_CENTER);
	
}