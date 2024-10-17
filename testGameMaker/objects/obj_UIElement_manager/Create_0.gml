

depth = -9999;


//여기서 각 레이어마다 depth의 시작점을 지정해 줍니다.
//참고 : depth는 -16000~16000 까지만 작동합니다.
var _layerAmount = 4; 
layerDepthOrigin = array_create(_layerAmount);
layerDepthOrigin[LAYER_NORMAL] = -100;
layerDepthOrigin[LAYER_ACHIEVEMENT] = -700;
layerDepthOrigin[LAYER_POPUP] = -1000;
layerDepthOrigin[LAYER_TUTORIAL] = -1300;

isLayerPersistent = array_create(_layerAmount); // 룸 이동시 요소들이 삭제되지 않아야 하면 true
isLayerPersistent[LAYER_NORMAL] = false;
isLayerPersistent[LAYER_ACHIEVEMENT] = true;
isLayerPersistent[LAYER_POPUP] = true;
isLayerPersistent[LAYER_TUTORIAL] = false;

layerTargetStack = array_create(0); // 엘리먼트를 생성할 레이어 타겟
array_push(layerTargetStack, LAYER_NORMAL);
activeLayerNow = LAYER_NORMAL; // 유저가 엘리먼트를 조작(버튼, 스크롤 등)할 수 있는 레이어

element_list = array_create(_layerAmount); // 각 레이어마다 가지는 요소들의 리스트 [LAYER][IDX]
var _len = array_length(element_list);
for (var i = 0; i < _len; i ++) {
	element_list[i] = array_create(0);
}

lastDeletedOldestElementIdx = array_create(_layerAmount); // 마지막으로 삭제된 엘리먼트 중 가장 나중에 생성된 것의 ID를 담는 변수입니다.
var _len = array_length(lastDeletedOldestElementIdx);
for (var i = 0; i < _len; i ++) {
	lastDeletedOldestElementIdx[i] = 9999;
}

global.DisplayRatioW = 1.5;
global.DisplayRatioH = 0.65;

global.DisplayDefaultWidth =  1;
global.DisplayDefaultHeight = 1;
global.DisplayDefaultUIScale = 1;
displayUnsafeSize = 0; // 좌우 안전영역을 제외한 영역 길이값 (노치 크기)
ui_scale = 0.6;

isKeepRatio = true; // UI 비율 유지

view_width_temp = camera_get_view_width(view_camera[0]);
view_height_temp = camera_get_view_height(view_camera[0]);
window_width_temp = window_get_width();
window_height_temp = window_get_height();
ui_scale_temp = ui_scale;

window_set_size(2346*1.2, 1125*1.2);
//window_set_size();
//window_set_size(2346*1.5, 1125*1.5);

function ResizeUI() {
	if (window_get_width() = 0 || window_get_height() = 0) return;
	
	var scale_standard = 1;
	if (isKeepRatio) {
		scale_standard = window_get_height()/800;
		var _ratio = (window_get_width()-GetNotchArea()*2)/window_get_height();
		if (_ratio <= 1/1.1) {
			scale_standard *= 0.5;
		}
		else if (_ratio <= 4/3) {
			scale_standard *= 0.65;
		}
		else if (_ratio <= 4.3/3) {
			scale_standard *= 0.7;
		}
		else if (_ratio <= 17.75/9) {
			scale_standard *= 0.75;
		}
	}
	var calculatedScale = ui_scale*scale_standard;

	ui_width = window_get_width()/calculatedScale;
	ui_height = window_get_height()/calculatedScale;
	
	global.DisplayDefaultWidth =  ui_width;
	global.DisplayDefaultHeight = ui_height;
	global.DisplayRatioW = global.DisplayDefaultWidth / global.DisplayDefaultHeight;
	global.DisplayDefaultUIScale = 1 / calculatedScale;
	//surface_resize( application_surface, window_get_width(), window_get_height());
	display_set_gui_size(window_get_width()/calculatedScale, window_get_height()/calculatedScale);
}
ResizeUI();

UpdateElements = function() {
	var _len = array_length(element_list);
	for (var j = 0; j < _len; j ++)  {
		var __len = array_length(element_list[j]);
		for (var i = 0; i < __len; i++) {
			var _ins = element_list[j][i];
			if _ins.element_parent = null
				with (_ins)
					isAdjusted = false;
		}
	}
}


// AnalogPointing
function CheckButtons() {
	activeButtons = [];
	var __len = array_length(element_list[activeLayerNow]);
	for (var i = 0; i < __len; i++) {
		var _elm = element_list[activeLayerNow][i];
		if (_elm.elementType == ELEMENT_BUTTON && _elm.isActivated ) {
			array_push(activeButtons, i);
		}
	}
}
function InitButtonArray() {
	CheckButtons();
	
	var _nearElmId = -1;
	var _resDis = INF;
	var __len = array_length(activeButtons);
	if (__len == 0) return;
	for (var i = 0; i < __len; i++) {
		if (i == nowFocusingButtonIdx) continue;
		
		var _elm = element_list[activeLayerNow][activeButtons[i]];
		var _elmX = _elm.x + _elm.total_width/2, _elmY = _elm.y + _elm.total_height/2;
		var _dis = point_distance(lastPointProperties.x, lastPointProperties.y, _elmX, _elmY);
		if (_dis < _resDis) {
			_resDis = _dis;
			_nearElmId = i;
		}
	}
	if (_nearElmId == -1)
		return;
	nowFocusingButtonIdx = _nearElmId;
	var _nowElm = element_list[activeLayerNow][activeButtons[nowFocusingButtonIdx]];
	var _myX = _nowElm.x + _nowElm.total_width/2, _myY = _nowElm.y + _nowElm.total_height/2;
	lastPointProperties = {
		x : _myX,
		y : _myY
	}
}
function ValidateButton() {
	if (nowFocusingButtonIdx == -1)
		return false;
	
	if (array_length(activeButtons)-1 < nowFocusingButtonIdx) {
		InitButtonArray();
		return false;
	}
	if (array_length(element_list[activeLayerNow])-1 < activeButtons[nowFocusingButtonIdx]) {
		InitButtonArray();
		return false;
	}
	var _elm = element_list[activeLayerNow][activeButtons[nowFocusingButtonIdx]];
	if (_elm.elementType != ELEMENT_BUTTON) {
		InitButtonArray();
		return false;
	}
	return true;
}
function IsAnalogPointingAvailable() {
	return !IsMobileOS();
}
function FindNearButton(_direction, _range = 45) {
	CheckButtons();
	if (!ValidateButton()) {
		return;
	}
	
	var _nowElm = element_list[activeLayerNow][activeButtons[nowFocusingButtonIdx]];
	var _myX = _nowElm.x + _nowElm.total_width/2, _myY = _nowElm.y + _nowElm.total_height/2;
	var _nearElmId = -1;
	var _resDis = INF;
	var __len = array_length(activeButtons);
	for (var i = 0; i < __len; i++) {
		if (i == nowFocusingButtonIdx) continue;
		
		var _elm = element_list[activeLayerNow][activeButtons[i]];
		var _elmX = _elm.x + _elm.total_width/2, _elmY = _elm.y + _elm.total_height/2;
		var _dir = point_direction(_myX, _myY, _elmX, _elmY);
		var __diffReg = abs(_dir - _direction) % 360, _dff = min(__diffReg, 360 - __diffReg);
		if (_dff <= _range) {
			var _dis = point_distance(_myX, _myY, _elmX, _elmY);
			if (_dis < _resDis) {
				_resDis = _dis;
				_nearElmId = i;
			}
		}
	}
	if (_nearElmId == -1)
		return false;
	nowFocusingButtonIdx = _nearElmId;
	var _nowElm = element_list[activeLayerNow][activeButtons[nowFocusingButtonIdx]];
	var _myX = _nowElm.x + _nowElm.total_width/2, _myY = _nowElm.y + _nowElm.total_height/2;
	lastPointProperties = {
		x : _myX,
		y : _myY
	}
	return true;
}

function FindNearButtonExt(_direction) {
	if (!FindNearButton(_direction, 15))
		if (!FindNearButton(_direction, 25))
			if (!FindNearButton(_direction, 45))
				FindNearButton(_direction, 88)
}

activeButtons = [];
nowFocusingButtonIdx = -1;
lastPointProperties = {
	x : 0,
	y : 0
}

event_user(0);
room_goto(r_Home);