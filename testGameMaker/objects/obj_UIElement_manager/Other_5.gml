for (var i = 0; i < array_length(element_list); i ++)  {
	if (isLayerPersistent[i] == true)
		continue;
	
	var	_parentLessElementsTemp = array_create(0);
	for (var j = 0; j < array_length(element_list[i]); j ++) {
		var _element = element_list[i][j];
		if (_element.element_parent == null)
			array_push(_parentLessElementsTemp, _element);
	}
	
	for (var j = 0; j < array_length(_parentLessElementsTemp); j ++) {
		var _element = _parentLessElementsTemp[j];
		SetElementRemove(_element);
	}
	//ds_list_destroy(_parentLessElementsTemp);
	//ds_list_clear(element_list[i]);
}


/*
// 팝업관련 조치
obj_popup_manager.isPopupShowing = false;
activeLayerNow = LAYER_NORMAL;*/