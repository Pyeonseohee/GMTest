
if (backgroundNowName != -1) {
	if (!variable_struct_exists(backgroundImageWaitStruct, backgroundNowName)) {
		exit;
	}
	
	var img          = backgroundImageWaitStruct[$ backgroundNowName].original;
	var blurredImage = backgroundImageWaitStruct[$ backgroundNowName].blurred;
	var binning      = backgroundImageWaitStruct[$ backgroundNowName].blurredBinning
	if (!sprite_exists(img)) exit;
	if (!sprite_exists(blurredImage)) exit;
	
	
	var ratio = spriteSetRatioForBackground(img, scale_now);
	
	// LERP
	scale_now += (scale_goal - scale_now)/10;
	opacity_now += (opacity_goal - opacity_now)/10;
	overlayRate += (overlayRate_goal - overlayRate)/10;
	// POS
	var _posX = 0, _posY = 0;
	if (isScrollable) {
		if (isScrollVertical) { // 세로 스크롤
			_posY = (global.DisplayDefaultHeight - sprite_get_height(img)*ratio[$ "scale"])*(0.5-scrollRateFollow);
		}
		else { // 가로 스크롤
			_posX = (global.DisplayDefaultWidth - sprite_get_width(img)*ratio[$ "scale"])*(scrollRateFollow-0.5);
		}
	}
	
	// DRAW
	draw_sprite_ext(blurredImage,0
					,_posX+ratio[$ "xpos"]
					,_posY+ratio[$ "ypos"]
					, ratio[$ "scale"]*binning, ratio[$ "scale"]*binning,0,c_white,1);
	draw_sprite_ext(img,0
					,_posX+ratio[$ "xpos"]
					,_posY+ratio[$ "ypos"]
					, ratio[$ "scale"], ratio[$ "scale"],0,c_white,1-overlayRate);
	draw_set_alpha(1-opacity_now); // 투명도라는 표현이지만 사실 draw_rectangle로 가려주는 것
	draw_set_color(c_black);
	draw_rectangle(0,0,global.DisplayDefaultWidth,global.DisplayDefaultHeight,0);
}

