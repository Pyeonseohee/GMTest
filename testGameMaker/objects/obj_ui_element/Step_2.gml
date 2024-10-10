var _isScaleAdjusted = UIElementAdjust(elementType);

if (elementType == ELEMENT_NORMAL) {
	//isAdjusted = true;
	exit;
}

if (elementType == ELEMENT_BUTTON) {
	if (visible)
		UIElementButtonCheck();
	//isAdjusted = true;
	exit;
}

if (elementType == ELEMENT_LABEL) {
	if (!isAdjusted) {
		draw_set_font(font_);
		if (labelOverflow == OVERFLOW_WRAP) {
			//show_debug_message("asd")
			text_width = string_width(text_wrap);
			text_height = string_height(text_wrap);
			//text_wrap = StringCut(text, (total_width-margin*2)/(text_xscale*goal_xscale));
		}
		else {
			text_width = string_width(text);
			text_height = string_height(text);
		}
	}
	//isAdjusted = true;
	exit;
}

//if (elementType == ELEMENT_SCROLL) 
isAdjusted = true;
UIElementScrollCheck();
	
