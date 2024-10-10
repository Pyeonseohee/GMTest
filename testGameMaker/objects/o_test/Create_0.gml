var wid = display_get_gui_width()/2;
var hei = display_get_gui_height()/2;


//var button_instance_id = AddButton(wid, hei, 500, 200);

with (AddElement(0, 0, 100, 100)) {
	SetElementDrawer(self, DRAWER {
		draw_frame_12rounded(_x1,_y1,_x2,_y2, _alpha, c_white, _xscale);
	});
}

with (AddButton(200, 0, 100, 100)) {
	SetElementDrawer(self, DRAWER {
		draw_frame_12rounded(_x1,_y1,_x2,_y2, _alpha, c_blue, _xscale);
	});
	SetButtonCallback(self, CALLBACK {
		show_message(1);
	});
}

with(AddElement(300, 0, 200, 200)){
	SetElementDrawer(self, DRAWER{
		draw_frame_glow1(_x1, _y1, _x2, _y2, _alpha, c_aqua, _xscale);
	});
} 

with(AddElement(500, 0, 200, 200)){
	SetElementDrawer(self, DRAWER{
		draw_frame_outlineRounded(_x1, _y1, _x2, _y2, _alpha, c_red, _xscale);
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
		room_goto(InGameRoom);
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