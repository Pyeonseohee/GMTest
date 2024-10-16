// v2.3.0에 대한 스크립트 어셋 변경됨 자세한 정보는
function draw_sprite_pie_reverse(sprite, subimage, _x, _y, startangle, endangle, color, alpha, xsize = pointer_null, ysize = pointer_null)
{
	if (xsize == pointer_null)
		var width = sprite_get_width(sprite);
	else
		var width = sprite_get_width(sprite) * xsize;
	if (ysize == pointer_null)
		var height = sprite_get_height(sprite);
	else
		var height = sprite_get_height(sprite) * ysize;
	
	var texel_x = 0.5 / width;
	var texel_y = 0.5 / height;
	draw_primitive_begin_texture(pr_trianglefan, sprite_get_texture(sprite, subimage));
	draw_vertex_texture_color(_x, _y, 0.5, 0.5, color, alpha);
	while (1) {
	 var angle = degtorad(startangle);
	 var dx = -min(abs(tan(angle + pi / 2)), 1) * sign(cos(angle));
	 var dy = min(abs(tan(angle)), 1) * sign(-sin(angle));
	 draw_vertex_texture_color(_x + width * 0.5 * dx, _y + height * 0.5 * dy, dx / 2 + 0.5 + texel_x, dy / 2 + 0.5 + texel_y, color, alpha);
	 if (startangle = endangle)
	  break;
	 var next = floor(startangle / 45 + 1) * 45;
	 if (next >= endangle)
	  startangle = endangle;
	 else
	  startangle = next;
	}
	draw_primitive_end();
}

#region 스킬 선택 관련 (스킬 선택 FootBar 관련)
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
	UILIb_button_scaleAnimation(self); // 애니메이션
	
	SetElementDrawer(self, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
	});
	
	with(AddElement(0, 0, 0, 0, self))
	{
		SetElementAlignment(self, AL_CENTER);
		SetElementDrawer(self, DRAWER{
			draw_sprite_ext(sp_icon_rotation_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
		});
	}
				
	// 클릭하면 스킬 변경
	SetButtonCallback(self, CALLBACK{
		if(obj_ui_system.clicked_player == NULL || obj_ui_system.clicked_slot == NULL) return ;
		global.all_skill[obj_ui_system.clicked_player][obj_ui_system.clicked_slot] = SKILL.RECREATE;
	});
	
	// 호버인듯
	SetButtonFocusCallback(self,CALLBACK{
		SetLabelText(obj_ui_system.skillExplainLabel, "RECREATEEEEE")
		//show_message("플레이어가 바라보는 방향으로 직선 궤도로 나아가는 화살을 발사합니다." );  
	});
	
}

function AddSwordSkill(_ins, _idx)
{
	UILIb_button_scaleAnimation(self); // 애니메이션
	
	SetElementDrawer(self, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
	});
	
	with(AddElement(0, 0, 0, 0, self))
	{
		SetElementAlignment(self, AL_CENTER);
		SetElementDrawer(self, DRAWER{
			draw_sprite_ext(sp_icon_sword_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
		});
	}
				
	// 클릭하면 스킬 변경
	SetButtonCallback(self, CALLBACK{
		if(obj_ui_system.clicked_player == NULL || obj_ui_system.clicked_slot == NULL) return ;
		global.all_skill[obj_ui_system.clicked_player][obj_ui_system.clicked_slot] = SKILL.SWORD;
	});
	
	// 호버인듯
	SetButtonFocusCallback(self, CALLBACK{
		SetLabelText(obj_ui_system.skillExplainLabel, "SWORRRRDD")
		//show_message("플레이어가 바라보는 방향으로 직선 궤도로 나아가는 화살을 발사합니다." );  
	});
	
}

function AddArrowSkill(_ins, _idx)
{
	UILIb_button_scaleAnimation(self); // 애니메이션
	
	SetElementDrawer(self, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
		draw_sprite_ext(sp_icon_pin_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
	});
	
	with(AddElement(0, 0, 0, 0, self))
	{
		SetElementAlignment(self, AL_CENTER);
		SetElementDrawer(self, DRAWER{
			draw_sprite_ext(sp_icon_pin_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
		});
	}
	
	// 클릭하면 스킬 변경
	SetButtonCallback(self, CALLBACK{
		if(obj_ui_system.clicked_player == NULL || obj_ui_system.clicked_slot == NULL) return ;
		global.all_skill[obj_ui_system.clicked_player][obj_ui_system.clicked_slot] = SKILL.ARROW;
	});

	// 호버인듯
	SetButtonFocusCallback(self, CALLBACK{
		SetLabelText(obj_ui_system.skillExplainLabel, "ARROOWWWWWW")
		//show_message("플레이어가 바라보는 방향으로 직선 궤도로 나아가는 화살을 발사합니다." );  
	});
	
}

function AddVolleyballSkill(_ins, _idx)
{
	UILIb_button_scaleAnimation(self); // 애니메이션
	
	SetElementDrawer(self, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
	});
	
	with(AddElement(0, 0, 0, 0, self))
	{
		SetElementAlignment(self, AL_CENTER);
		SetElementDrawer(self, DRAWER{
			draw_sprite_ext(sp_icon_ball_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
		});
	}
	
	// 클릭하면 스킬 변경
	SetButtonCallback(self, CALLBACK{
		if(obj_ui_system.clicked_player == NULL || obj_ui_system.clicked_slot == NULL) return ;
		global.all_skill[obj_ui_system.clicked_player][obj_ui_system.clicked_slot] = SKILL.VOLLEYBALL;
	});
	
	// 호버인듯
	SetButtonFocusCallback(self, CALLBACK{
		SetLabelText(obj_ui_system.skillExplainLabel, "VOLLEYYBALLL")
		//show_message("플레이어가 바라보는 방향으로 직선 궤도로 나아가는 화살을 발사합니다." );  
	});
	
}

function AddTeleportSkill(_ins, _idx)
{
	UILIb_button_scaleAnimation(self); // 애니메이션
	
	SetElementDrawer(self, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
	});
	
	with(AddElement(0, 0, 0, 0, self))
	{
		SetElementAlignment(self, AL_CENTER);
		SetElementDrawer(self, DRAWER{
			draw_sprite_ext(sp_icon_person_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
		});
	}
				
	// 클릭하면 스킬 변경
	SetButtonCallback(self, CALLBACK{
		if(obj_ui_system.clicked_player == NULL || obj_ui_system.clicked_slot == NULL) return ;
		global.all_skill[obj_ui_system.clicked_player][obj_ui_system.clicked_slot] = SKILL.TELEPORT;
	});
	
	// 호버인듯
	SetButtonFocusCallback(self, CALLBACK{
		SetLabelText(obj_ui_system.skillExplainLabel, "TELLEPORTTT " + string(obj_ui_system.clicked_player) + ", " + string(obj_ui_system.clicked_slot));
		
		//show_message("플레이어가 바라보는 방향으로 직선 궤도로 나아가는 화살을 발사합니다." );  
	});
	
}

function AddDashSkill(_ins, _idx)
{
	UILIb_button_scaleAnimation(self); // 애니메이션
	
	SetElementDrawer(self, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
	});
	
	with(AddElement(0, 0, 0, 0, self))
	{
		SetElementAlignment(self, AL_CENTER);
		SetElementDrawer(self, DRAWER{
			draw_sprite_ext(sp_icon_shoes_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
		});
	}
				
	// 클릭하면 스킬 변경
	SetButtonCallback(self, CALLBACK{
		if(obj_ui_system.clicked_player == NULL || obj_ui_system.clicked_slot == NULL) return ;
		global.all_skill[obj_ui_system.clicked_player][obj_ui_system.clicked_slot] = SKILL.DASH;
	});
	
	// 호버인듯
	SetButtonFocusCallback(self,CALLBACK{
		SetLabelText(obj_ui_system.skillExplainLabel, "DASSSHH")
		//show_message("플레이어가 바라보는 방향으로 직선 궤도로 나아가는 화살을 발사합니다." );  
	});
	
}

function AddBombSkill(_ins, _idx)
{
	
	UILIb_button_scaleAnimation(self); // 애니메이션
	
	SetElementDrawer(self, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
	});
	
	with(AddElement(0, 0, 0, 0, self))
	{
		SetElementAlignment(self, AL_CENTER);
		SetElementDrawer(self, DRAWER{
			draw_sprite_ext(spr_bomb, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
		});
	}
				
	// 클릭하면 스킬 변경
	SetButtonCallback(self, CALLBACK{
		if(obj_ui_system.clicked_player == NULL || obj_ui_system.clicked_slot == NULL) return ;
		global.all_skill[obj_ui_system.clicked_player][obj_ui_system.clicked_slot] = SKILL.BOMB;
	});
	
	// 호버인듯
	SetButtonFocusCallback(self, CALLBACK{
		SetLabelText(obj_ui_system.skillExplainLabel, "BOMMBBB")
		//show_message("플레이어가 바라보는 방향으로 직선 궤도로 나아가는 화살을 발사합니다." );  
	});
}
#endregion

