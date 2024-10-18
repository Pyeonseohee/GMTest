var _wid = display_get_gui_width()/2;
var _hei = display_get_gui_height()/2;

var _button_width = 500;
var _button_height = 150;
var _margin = 30;

#region 게임 시작 버튼

with(AddElement(0, 200, 500, 100))
{
	SetElementAlignment(self, AL_TOPCENTER);
	with(AddLabel(0, 0, 0, 0, "꼬물이: 리마스터드", self))
	{
		SetLabel(self, c_black, 2, 2, 1, 10, AL_CENTER);
		SetElementFit(self, FIT_FULL);
	}
}

with(AddButton(0, 0, _button_width, _button_height))
{
	SetElementAlignment(self, AL_CENTER);
	SetElementDrawer(self, DRAWER{
		draw_frame_roundedEdgeOrange(_x1, _y1, _x2, _y2, _alpha, _xscale);
	});
	
	UILIb_button_scaleAnimation(self);
	
	with (AddLabel(0, 0, 0, 0, "게임 시작", self)) {
		SetLabel(self, c_black, 2, 2, 1, 10, AL_CENTER); // 가운데 중앙정렬
		SetElementFit(self, FIT_FULL);
	}
	
	SetButtonCallback(self, CALLBACK{
		room_goto(r_GameReadyRoom);
	});
}
#endregion
