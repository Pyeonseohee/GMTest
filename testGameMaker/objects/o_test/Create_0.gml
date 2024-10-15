var wid = display_get_gui_width()/2;
var hei = display_get_gui_height()/2;


//var button_instance_id = AddButton(wid, hei, 500, 200);
with(AddButton(200, 200, 200, 200))
{
	SetElementDrawer(self, DRAWER{
		// 스킬 쿨타임 있을 때
		draw_sprite_pie_reverse(sp_circle_line_256_256, 0, (_x1+_x2)/2, (_y1+_y2)/2, 0, 270, c_white, _alpha, _xscale * 2, _yscale * 2)
	});
	with(AddElement(0, 0, 150, 150, self))
	{
		SetElementAlignment(self, AL_CENTER);
		SetElementDrawer(self, DRAWER{
			draw_sprite_ext(sp_icon_star_02, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale * 2, _yscale * 2, 0, c_white, _alpha);
		});
	}
	
	SetButtonCallback(self, CALLBACK{
	});
}


with(AddButton(wid - 250, hei - 75, 500, 150))
{
	var selectButton = SetElementDrawer(self, DRAWER{
		draw_frame_roundedEdgeOrange(_x1, _y1, _x2, _y2, _alpha, _xscale);
	});
	UILIb_button_scaleAnimation(self);
	//UILIb_roundedLineEdge(self);
	
	with (AddLabel(0, 0, 0, 0, "Game Start", self)) {
		SetLabel(self, c_black, 2, 2, 1, 10, AL_CENTER); // 가운데 중앙정렬
		SetElementFit(self, FIT_FULL);
	}
	
	SetButtonCallback(self, CALLBACK{
		room_goto(MainMenu);
	});
}

with(AddButton(wid - 250, hei + 75 + 20, 500, 150))
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

//CO_SCOPE = id;
//var _co = CO_BEGIN
//	DELAY 50 THEN
//	show_message(11);
//	DELAY 50 THEN
//	show_message(11);
//	DELAY 50 THEN
//	show_message(11);
//CO_END
