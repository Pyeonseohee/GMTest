global.showSkillList=[
	AddRecreateSkill,
	AddSwordSkill,
	AddArrowSkill,
	AddVolleyballSkill,
	AddTeleportSkill,
	AddDashSkill,
	AddBombSkill,
];
function AddRecreateSkill(_ins, _idx)
{
	SetElementDrawer(_ins, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
		draw_sprite_ext(sp_icon_rotation_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, 2 * _xscale, 2 * _yscale, 0, c_white, _alpha);
	});
				
		// 클릭하면 스킬 변경
	SetButtonCallback(_ins, CALLBACK{
		show_message("부활 클릭??");
					
	});
	// 호버인듯
	SetButtonFocusCallback(_ins,CALLBACK{
		SetLabelText(obj_ui_system.skillExplainLabel, "RECREATEEEEE")
		//show_message("플레이어가 바라보는 방향으로 직선 궤도로 나아가는 화살을 발사합니다." );  
	});
	
}

function AddSwordSkill(_ins, _idx)
{
	SetElementDrawer(_ins, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
		draw_sprite_ext(sp_icon_sword_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, 2 * _xscale, 2 * _yscale, 0, c_white, _alpha);
	});
				
		// 클릭하면 스킬 변경
	SetButtonCallback(_ins, CALLBACK{
		show_message("검 클릭??");
					
	});
	// 호버인듯
	SetButtonFocusCallback(_ins,CALLBACK{
		SetLabelText(obj_ui_system.skillExplainLabel, "SWORRRRDD")
		//show_message("플레이어가 바라보는 방향으로 직선 궤도로 나아가는 화살을 발사합니다." );  
	});
	
}

function AddArrowSkill(_ins, _idx)
{
	SetElementDrawer(_ins, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
		draw_sprite_ext(sp_icon_pin_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, 2 * _xscale, 2 * _yscale, 0, c_white, _alpha);
	});
				
		// 클릭하면 스킬 변경
	SetButtonCallback(_ins, CALLBACK{
		show_message("화살 클릭??");
					
	});
	// 호버인듯
	SetButtonFocusCallback(_ins,CALLBACK{
		SetLabelText(obj_ui_system.skillExplainLabel, "ARROOWWWWWW")
		//show_message("플레이어가 바라보는 방향으로 직선 궤도로 나아가는 화살을 발사합니다." );  
	});
	
}

function AddVolleyballSkill(_ins, _idx)
{
	SetElementDrawer(_ins, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
		draw_sprite_ext(sp_icon_ball_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, 2 * _xscale, 2 * _yscale, 0, c_white, _alpha);
	});
				
		// 클릭하면 스킬 변경
	SetButtonCallback(_ins, CALLBACK{
		show_message("배구공 클릭??");
					
	});
	// 호버인듯
	SetButtonFocusCallback(_ins,CALLBACK{
		SetLabelText(obj_ui_system.skillExplainLabel, "VOLLEYYBALLL")
		//show_message("플레이어가 바라보는 방향으로 직선 궤도로 나아가는 화살을 발사합니다." );  
	});
	
}

function AddTeleportSkill(_ins, _idx)
{
	SetElementDrawer(_ins, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
		draw_sprite_ext(sp_icon_person_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, 2 * _xscale, 2 * _yscale, 0, c_white, _alpha);
	});
				
		// 클릭하면 스킬 변경
	SetButtonCallback(_ins, CALLBACK{
		show_message("텔레포트 클릭??");
					
	});
	// 호버인듯
	SetButtonFocusCallback(_ins,CALLBACK{
		SetLabelText(obj_ui_system.skillExplainLabel, "TELLEPORTTT")
		//show_message("플레이어가 바라보는 방향으로 직선 궤도로 나아가는 화살을 발사합니다." );  
	});
	
}

function AddDashSkill(_ins, _idx)
{
	SetElementDrawer(_ins, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
		draw_sprite_ext(sp_icon_shoes_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, 2 * _xscale, 2 * _yscale, 0, c_white, _alpha);
	});
				
		// 클릭하면 스킬 변경
	SetButtonCallback(_ins, CALLBACK{
		show_message("대시 클릭??");
					
	});
	// 호버인듯
	SetButtonFocusCallback(_ins,CALLBACK{
		SetLabelText(obj_ui_system.skillExplainLabel, "DASSSHH")
		//show_message("플레이어가 바라보는 방향으로 직선 궤도로 나아가는 화살을 발사합니다." );  
	});
	
}

function AddBombSkill(_ins, _idx)
{
	SetElementDrawer(_ins, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
		draw_sprite_ext(sp_icon_clock_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, 2 * _xscale, 2 * _yscale, 0, c_white, _alpha);
	});
				
		// 클릭하면 스킬 변경
	SetButtonCallback(_ins, CALLBACK{
		show_message("폭탄 클릭??");
					
	});
	// 호버인듯
	SetButtonFocusCallback(_ins,CALLBACK{
		SetLabelText(obj_ui_system.skillExplainLabel, "BOMMBBB")
		//show_message("플레이어가 바라보는 방향으로 직선 궤도로 나아가는 화살을 발사합니다." );  
	});
	
}