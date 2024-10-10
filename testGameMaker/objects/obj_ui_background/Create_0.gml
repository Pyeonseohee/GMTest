// 룸 첫 시작에 가져올 것으로 예상되는 배경을 미리 로드한 뒤에 ChangeBackground로 그때 그때 바꿔주는 방식

depth = obj_UIElement_manager.layerDepthOrigin[LAYER_NORMAL] + 2;

scale_now        = 1.2;
scale_goal       = 1;
opacity_now      = 0.1;
opacity_goal     = 1;
overlayRate      = 4;
overlayRate_goal = 0;
isScrollable     = false;
isScrollVertical = false;
scrollRate       = 0;
scrollRateFollow = 0;

backgroundImageWaitStruct = {}
backgroundNowName = -1;

function SetBackground(_overlayRate = 0, _scale = 1, _opacity = 1, _isScrollable = false, _isScrollVertical = false) {
	scale_goal        = 1.05*_scale;
	opacity_goal      = _opacity;
	overlayRate_goal  = _overlayRate;
	isScrollable      = _isScrollable;
	isScrollVertical  = _isScrollVertical;
}

function SkipAnimation() {
	scale_now        = scale_goal;
	opacity_now      = opacity_goal;
	overlayRate  = 1;
	overlayRate_goal = 1;
}

function ChangeBackground(_name) {
	backgroundNowName = _name;
	scale_goal        = 1.05;
	scale_now         = 1.2
	opacity_goal      = 1;
	opacity_now       = 0;
	overlayRate       = 0;
	overlayRate_goal  = 0;
	isScrollable      = false;
	isScrollVertical  = false;
	scrollRate        = 0;
}

function AddBackgroundFromDirectory(_name,_path, binningBlurredImage, blurriness = 1) {
	if (!file_exists(_path)) {
		show_message_async("파일이 존재하지 않음! : "+_path);
		return;
	}
	var _image = sprite_add(_path, 0, 0, 0,0, 0);
	variable_struct_set(backgroundImageWaitStruct, _name, {
		original       : _image,
		blurred        : makeBlurredImage(_image, binningBlurredImage, blurriness*8),
		blurredBinning : binningBlurredImage
	});
}

function DeleteBackgrounds() {
	var _arr = variable_struct_get_names(backgroundImageWaitStruct);
	for (var i = 0; i < array_length(_arr); i ++) {
		sprite_delete(backgroundImageWaitStruct[$ _arr[i]].original);
		sprite_delete(backgroundImageWaitStruct[$ _arr[i]].blurred);
	}
}