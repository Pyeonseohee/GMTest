var _wid = display_get_gui_width()/2;
var _hei = display_get_gui_height()/2;

var _button_width = 500;
var _button_height = 150;
var _margin = 50;

#region 게임 시작 버튼
with(AddButton(_wid - _button_width/2, _hei - _button_height/2, _button_width, _button_height))
{
	SetElementDrawer(self, DRAWER{
		draw_frame_roundedEdgeOrange(_x1, _y1, _x2, _y2, _alpha, _xscale);
	});
	
	UILIb_button_scaleAnimation(self);
	
	with (AddLabel(0, 0, 0, 0, "Game Start", self)) {
		SetLabel(self, c_black, 2, 2, 1, 10, AL_CENTER); // 가운데 중앙정렬
		SetElementFit(self, FIT_FULL);
	}
	
	SetButtonCallback(self, CALLBACK{
		room_goto(GameReadyRoom);
	});
}
#endregion

#region 튜토리얼 버튼
with(AddButton(_wid - _button_width/2, _hei + _button_height/2 + _margin, _button_width, _button_height))
{
	var selectButton = SetElementDrawer(self, DRAWER{
		draw_frame_roundedEdgeOrange(_x1, _y1, _x2, _y2, _alpha, _xscale);
	});
	
	UILIb_button_scaleAnimation(self);
	
	with (AddLabel(0, 0, 0, 0, "Tutorial", self)) {
		SetLabel(self, c_black, 2, 2, 1, 10, AL_CENTER);
		SetElementFit(self, FIT_FULL);
	}
	
	SetButtonCallback(self, CALLBACK{
		room_goto(TutorialRoom);
	});
}
#endregion
