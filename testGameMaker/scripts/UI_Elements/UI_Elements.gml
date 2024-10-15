 #macro ELEMENT_NORMAL 0
#macro ELEMENT_LABEL 1
#macro ELEMENT_BUTTON 2
#macro ELEMENT_SCROLL 3
#macro OVERFLOW_FIT 0
#macro OVERFLOW_WRAP 1
#macro OVERFLOW_STATIC 2
#macro null undefined

function IsUIDebugging() {
	return keyboard_check(ord("K"));
}
function AddElement(_x, _y, _width, _height, parent = null, type = ELEMENT_NORMAL) {
	var _ins;
	if (parent == null) {
		_ins = instance_create_depth(_x, _y, 0, obj_ui_element);
	}
	else { // 부모 엘리먼트 존재
		_ins = instance_create_depth(parent.x + _x, parent.y + _y, 0, obj_ui_element);
		_ins.element_parent = parent;
		array_push(parent.child, _ins);
		with (parent) {
			UIElementAdjust(0);
		}
		if (parent.element_surface != -1) {
			_ins.element_surface = parent.element_surface;
		}
	}
	_ins.origin_x = _x;
	_ins.origin_y = _y;
	_ins.element_width = _width;
	_ins.element_height = _height;
	_ins.goal_x = _x;
	_ins.goal_y = _y;
	_ins.goal_width = _width;
	_ins.goal_height = _height;
	_ins.elementType = type;
	
	with (_ins)
		UIElementSetVariables(type);
	
	var _layerIdx = _ins.element_layer; // 현재 설정된 레이어 id
	array_push(obj_UIElement_manager.element_list[_layerIdx], _ins.id);
	var idx = array_get_index(obj_UIElement_manager.element_list[_layerIdx], _ins.id);
	if (idx != -1) _ins.depth = obj_UIElement_manager.layerDepthOrigin[_layerIdx] - idx
	
	return _ins;
}
function AddScrollField(_x, _y, _width, _height, _isScrollHorizontal, parent = null) {
	var _ins = AddElement(_x, _y, _width, _height, parent , ELEMENT_SCROLL);
	_ins.isScrollHorizontal = _isScrollHorizontal;
	return _ins;
}
function AddLabel(_x, _y, _width, _height, text, parent = null) {
	var _ins = AddElement(_x, _y, _width, _height, parent, ELEMENT_LABEL);
	SetLabelText(_ins, text);
	return _ins;
}
function AddButton(_x, _y, _width, _height, parent = null) {
	var _ins = AddElement(_x, _y, _width, _height, parent, ELEMENT_BUTTON);
	_ins.scrollParent = undefined;
	while (true) {
		if (parent == null) {
			break;
		}
		if (parent.elementType == ELEMENT_SCROLL) {
			_ins.scrollParent = parent;
			break;
		}
		parent = parent.element_parent;
	}
	return _ins;
}
function SetElementVariables(_element, instance_variable_struct) {
	var array = variable_struct_get_names(instance_variable_struct);
	for (var i = 0; i < array_length(array); i++) {
		if (variable_instance_exists(_element, array[i]))
			throw { error: "이미 존재하는 변수를 재선언 하셨습니다." };
		variable_instance_set(_element, array[i], instance_variable_struct[$ array[i]]);
	}
	return _element;
}
function SetLabel(_element, _color, _xscale, _yscale, _alpha, _margin, _align, _font = global.FontDefault, _isBold = false) {
	_element.label_color = _color;
	_element.text_xscale = _xscale;
	_element.text_yscale = _yscale;
	_element.label_alpha = _alpha;
	_element.margin = _margin;
	_element.align = _align;
	_element.font_ = _font;
	_element.isBold = _isBold;
	return _element;
}
function SetLabelText(_element, _text) {
	if (_element.labelOverflow == OVERFLOW_WRAP) {
		with (_element) {
			draw_set_font(font_);
			text_wrap = StringCut(text, (total_width-margin*2)/(text_xscale*goal_xscale));
		}
	}
	
	_element.text = _text;
	_element.isAdjusted = false;
	return _element;
}
function SetLabelOverflow(_element, overflow) {
	if (overflow == OVERFLOW_WRAP) {
		with (_element) {
			draw_set_font(font_);
			text_wrap = StringCut(text, (total_width-margin*2)/(text_xscale*goal_xscale));
		}
	}
	_element.labelOverflow = overflow;
	_element.isAdjusted = false;
	return _element;
}
function GetLabelTextHeight(_label) {
	with (_label) {
		var _str;
		if (labelOverflow == OVERFLOW_WRAP) {
			_str = text_wrap;
		}
		else {
			_str = text;
		}
		return string_height(_str)*text_yscale*goal_yscale + margin*2;
	}
}

function SetElementAlignment(_element, _type) {
	_element.alignment = _type;
	with (_element) {UIElementAdjust(elementType);}
	return _element;
}
#macro AL_LEFTTOP 0
#macro AL_RIGHTTOP 1
#macro AL_LEFTDOWN 2
#macro AL_RIGHTDOWN 3
#macro AL_LEFTCENTER 4
#macro AL_RIGHTCENTER 5
#macro AL_TOPCENTER 6
#macro AL_DOWNCENTER 7
#macro AL_CENTER 8
function SetElementFit(_element, _fit_width, _fit_height) {
	_element.fit_width = _fit_width;
	_element.fit_height = _fit_height;
	with (_element) {isAdjusted = false; UIElementAdjust(elementType);}
	return _element;
}
#macro FIT_NONE 0,0
#macro FIT_HORIZONTAL 1,0
#macro FIT_VERTICAL 0,1
#macro FIT_FULL 1,1
function SetElementClear(_element) {
	var _len = array_length(_element.child);
	for (var i = 0; i < _len; i ++) {
		var child = _element.child[i];
		SetElementClear(child);
		instance_destroy(child);
	}
	_element.child = array_create(0);
	return _element;
}
function SetElementRemove(_element) {
	if (instance_exists(_element)) {
		SetElementClear(_element);
	
		if (_element.element_parent != null)
			array_delete(_element.element_parent.child,array_get_index(_element.element_parent.child, _element),1);
		
		instance_destroy(_element);
	}
	return _element;
}

function SetElementDrawer(_element, _drawer, instance_variable_struct = {}) {
	var array = variable_struct_get_names(instance_variable_struct);
	for (var i = 0; i < array_length(array); i++) {
		if (variable_instance_exists(_element, array[i]))
			throw { error: "이미 존재하는 변수를 재선언 하셨습니다." };
		variable_instance_set(_element, array[i], instance_variable_struct[$ array[i]]);
	}
	
	_element.drawer = method(_element, _drawer);
	return _element;
}

function SetButtonCallback(_element, _callback, instance_variable_struct = {}) {
	var array = variable_struct_get_names(instance_variable_struct);
	for (var i = 0; i < array_length(array); i++) {
		if (variable_instance_exists(_element, array[i]))
			throw { error: "이미 존재하는 변수를 재선언 하셨습니다." };
		variable_instance_set(_element, array[i], instance_variable_struct[$ array[i]]);
	}
	
	_element.callback =  method(_element, _callback);
	return _element;
}
function SetButtonFocusCallback(_element, _callback) {
	_element.focusCallback = method(_element, _callback);
	return _element;
}
function SetButtonLeaveCallback(_element, _callback) {
	_element.leaveCallback = method(_element, _callback);
	return _element;
}
function SetButtonClickCallback(_element, _callback) {
	_element.clickCallback = method(_element, _callback);
	return _element;
}
function SetElementDeleteAction(_element, _action) {
	_element.deleteAction = method(_element, _action);
	return _element;
}
function SetElementDeactiveAnimation(_element, _animation) {
	_element.deactiveAnimation = method(_element, _animation);
	return _element;
}
function SetButtonActivate(_element, _isActivated) {
	_element.isActivated = _isActivated;
	var callback = is_method(_element.leaveCallback) ? _element.leaveCallback : function(v){}
	if (_isActivated) {
		callback(id);
	}
	else {
		callback(id);
		if (is_method(_element.deactiveAnimation))
			_element.deactiveAnimation();
	}
	return _element;
}
#macro DRAWER function(_x1,_y1,_x2,_y2,_e,_xscale,_yscale,_alpha, ext)
#macro CALLBACK function(_e)
function PushLayerTarget(_id) {
	array_push(obj_UIElement_manager.layerTargetStack,_id);
}
function PopLayerTarget() {
	array_pop(obj_UIElement_manager.layerTargetStack);
}
function SetActiveLayer(_id) {
	obj_UIElement_manager.activeLayerNow = _id;
}
function SetButtonSFX(_element, hover = pointer_null, click = pointer_null, release = pointer_null) {
	with (_element) {
		sfx_hover   = hover;
		sfx_click   = click;
		sfx_release = release;
	}
	return _element;
}
function SetButtonOneOff(_button, _isOneOff = true) {
	with (_button) {
		isOneOff = _isOneOff;
	}
	return _button;
}
function SetElementFixDepth(_element, _depth = -1) {
	with (_element) {
		isfixedDepth = true;
	
		if (_depth < 0) {
			if (element_layer+1 == array_length(obj_UIElement_manager.layerDepthOrigin))
				depth = -16000 + _depth;
			else
				depth = obj_UIElement_manager.layerDepthOrigin[element_layer+1] + _depth;
		}
		else
			depth = obj_UIElement_manager.layerDepthOrigin[element_layer] - _depth;
	}
	return _element;
}
#macro LAYER_NORMAL 0
#macro LAYER_ACHIEVEMENT 1
#macro LAYER_POPUP 2
#macro LAYER_TUTORIAL 3
function IsUIElement(_element) {
	if (_element.object_index == obj_ui_element)
		return true;
	return false;
}


function IsMobileOS() {

	return false;
}