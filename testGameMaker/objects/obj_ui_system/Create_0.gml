/// @description Insert description here
// You can write your code in this editor
#macro PLAYER1 0
#macro PLAYER2 1

#region 데이터
// 여기에 화면 중앙 정렬
var UI_center_x = display_get_gui_width()/2;
var UI_center_y = display_get_gui_height()/2;

topBarHeight = 300;
footBarHeight = 400;

skillSlotFuncs = [

];
global.stu_player_skills = [];
clicked_slot = NULL;

global.stu_p1_skill = {
	skill1: SKILL.ARROW,
	skill2: SKILL.VOLLEYBALL,
	skill3: SKILL.TELEPORT
}

global.stu_p2_skill = {
	skill1: SKILL.ARROW,
	skill2: SKILL.SWORD,
	skill3: SKILL.TELEPORT
}

global.spr_skill = 
{
	arrow: sp_icon_pin_01,
	sword: sp_icon_sword_01,
	volleyball: sp_icon_ball_01,
	teleport: sp_icon_person_01,
	dash: sp_icon_shoes_01,
	
};
#endregion

#region UI element
skillExplainLabel = NULL;

#endregion

#region About TopBar
function AddBackButton(_x, _y) // 뒤로 가기 버튼
{
	var _buttonWidth = 200;
	var _buttonHeight = 100;
	var _buttonMargin = 100;
		
	with(AddButton(_x + _buttonMargin, _y + _buttonMargin, _buttonWidth, _buttonHeight))
	{
		SetElementDrawer(self, DRAWER{
			draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
			draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
			draw_sprite_ext(sp_icon_arrow_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
		});
	
		UILIb_button_scaleAnimation(self); // 애니메이션
	
		SetButtonCallback(self, CALLBACK{
			room_goto(Room1);
		});
	}
}

// 게임 시작 버튼
function AddGameStartButton(_parent_width)
{
	var _buttonWidth = 200;
	var _buttonHeight = 100;
	var _buttonMargin = 100;
	
	with(AddButton((_parent_width - _buttonMargin - _buttonWidth), _buttonMargin, _buttonWidth, _buttonHeight))
	{
		SetElementDrawer(self, DRAWER{
			draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha, c_yellow, _xscale);
			draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
			draw_sprite_ext(sp_triangle_64_64, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
		});
	
		UILIb_button_scaleAnimation(self); // 애니메이션
	
		SetButtonCallback(self, CALLBACK{
			room_goto(InGameRoom); 
		});
	}
}

function AddTopBar()
{
	with(AddButton(0, 0, display_get_gui_width(), topBarHeight))
	{
		obj_ui_system.AddBackButton(x, y);
		obj_ui_system.AddGameStartButton(element_width);
	}
}
#endregion

#region About SideBar(Skill Slot.. 실제로 사이드 바는 아닙니다 편의상..)

var _margin = 50;
var _skillSlotSize = 200;
var _slotCount = 3;



function AddSkillSlot1(_x, _y)
{
	var _margin = 50;
	var skillIconSize = 200;
	with(AddButton(_x + 50, (display_get_gui_height()/2 - skillIconSize/2) + skillIconSize*(1 - 2) - _margin, skillIconSize, skillIconSize))
	{
		SetElementVariables(self, {_skill: global.stu_p1_skill.skill1});
		
		SetElementDrawer(self, DRAWER{
			switch(_skill)
			{
				case SKILL.ARROW:
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
					draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
					draw_sprite_ext(global.spr_skill.arrow, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
					break;
				case SKILL.VOLLEYBALL:
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
					draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
					draw_sprite_ext(global.spr_skill.volleyball, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
					break;
				case SKILL.TELEPORT:
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
					draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
					draw_sprite_ext(global.spr_skill.arrow, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
					break;
				case SKILL.SWORD:
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
					draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
					draw_sprite_ext(global.spr_skill.teleport, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
					break;
				default:
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
					draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
					break;
			}
		});
	
		UILIb_button_scaleAnimation(self); // 애니메이션
	
		SetButtonCallback(self, CALLBACK{
			_skill = !_skill;
			clicked_player = PLAYER1;
			obj_ui_system.clicked_slot = 1;
		});
	}
}

function AddSkillSlot2(_x, _y)
{
	var _margin = 50;
	var skillIconSize = 200;
	with(AddButton(_x + 50, (display_get_gui_height()/2 - skillIconSize/2), skillIconSize, skillIconSize))
	{
		SetElementVariables(self, {_skill: global.stu_p1_skill.skill2});
		
		SetElementDrawer(self, DRAWER{
			switch(_skill)
			{
				case SKILL.ARROW:
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
					draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
					draw_sprite_ext(global.spr_skill.arrow, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
					break;
				case SKILL.VOLLEYBALL:
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
					draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
					draw_sprite_ext(global.spr_skill.volleyball, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
					break;
				case SKILL.TELEPORT:
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
					draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
					draw_sprite_ext(global.spr_skill.arrow, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
					break;
				case SKILL.SWORD:
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
					draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
					draw_sprite_ext(global.spr_skill.teleport, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
					break;
				default:
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
					draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
					break;
			}
		});
	
		UILIb_button_scaleAnimation(self); // 애니메이션
	
		SetButtonCallback(self, CALLBACK{
			_skill = !_skill;
			clicked_player = PLAYER1;
			obj_ui_system.clicked_slot = 2;
		});
	}
}

function AddSkillSlot3(_x, _y)
{
	var _margin = 50;
	var skillIconSize = 200;
	with(AddButton(_x + 50, (display_get_gui_height()/2 - skillIconSize/2) + skillIconSize*(3 - 2) + _margin, skillIconSize, skillIconSize))
	{
		SetElementVariables(self, {_skill: global.stu_p1_skill.skill3});
		
		SetElementDrawer(self, DRAWER{
			switch(_skill)
			{
				case SKILL.ARROW:
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
					draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
					draw_sprite_ext(global.spr_skill.arrow, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
					break;
				case SKILL.VOLLEYBALL:
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
					draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
					draw_sprite_ext(global.spr_skill.volleyball, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
					break;
				case SKILL.TELEPORT:
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
					draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
					draw_sprite_ext(global.spr_skill.arrow, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
					break;
				case SKILL.SWORD:
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
					draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
					draw_sprite_ext(global.spr_skill.teleport, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
					break;
				default:
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
					draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
					break;
			}
		});
	
		UILIb_button_scaleAnimation(self); // 애니메이션
	
		SetButtonCallback(self, CALLBACK{
			_skill = !_skill;
			clicked_player = PLAYER1;
			obj_ui_system.clicked_slot = 3;
		});
	}
}

function AddSkillSlotRight(_x, _y)
{
}

function AddSkillSlotLeft(_x, _y)
{
	AddSkillSlot1(_x, _y);
	AddSkillSlot2(_x, _y);
	AddSkillSlot3(_x, _y);
}
function AddSideBar()
{
	// 왼쪽 스킬 창
	with(AddButton(0, topBarHeight, 300, display_get_gui_height() - topBarHeight - footBarHeight))
	{
		obj_ui_system.AddSkillSlotLeft(x, y);
	}
	// 오른쪽 스킬 창
	with(AddButton(display_get_gui_width() - 300, topBarHeight, 300, display_get_gui_height() - topBarHeight - footBarHeight))
	{
		obj_ui_system.AddSkillSlotRight(x, y);
	}
}
#endregion

#region About FootBar
function AddFootBar()
{
	with(AddButton(0, display_get_gui_height() - footBarHeight, display_get_gui_width(), footBarHeight))
	{
		SetElementDrawer(self, DRAWER{
			draw_set_alpha(0.7);
			draw_set_color(c_black);
			draw_rectangle(_x1, _y1, _x2, _y2, false);
			//draw_sprite_ext(sp_square_16_16, 0, (_x1+_x2)/2, (_y1+_y2)/2, (_x2-_x1) / 16, (_y2-_y1) / 16, 0, c_gray, _alpha);
		});
		
		var _skillButtonSize = 200;
		
		var _skillExplainLabel = AddLabel(0, 0, 0, 0, "", self);
		obj_ui_system.skillExplainLabel = _skillExplainLabel;
		with(_skillExplainLabel)
		{
			SetLabel(self, c_white, 1, 1, 1, 1, AL_LEFTDOWN, global.FontDefault, false);
			SetElementFit(self, FIT_FULL);
		}
	}
}

#endregion

#region About player sprtie
function AddPlayerSprite()
{
	var _player_margin = 700;
	var _player_offset = 100;
	var _player_y = display_get_gui_height()/2;
	var _player_size = 400;
	
	// 플레이어 1 생성
	with(AddButton(_player_margin, _player_y - _player_offset, 400, 400))
	{
		SetElementDrawer(self, DRAWER{
			draw_sprite_ext(spr_sSlime_Walk, 0, (_x1+_x2)/2, (_y1+_y2)/2, 10, 10, 0, c_white, _alpha);
		});
	}

	// 플레이어 2 생성
	with(AddButton(display_get_gui_width() - _player_margin - _player_size/2, _player_y - _player_offset, 400, 400))
	{
		SetElementDrawer(self, DRAWER{
			draw_sprite_ext(spr_sSlime_Walk, 0, (_x1+_x2)/2, (_y1+_y2)/2, 10, 10, 0, c_yellow, _alpha);
		});
	}
}
#endregion

#region 실제 함수 호출
AddTopBar();
AddSideBar();
AddFootBar();
AddPlayerSprite();
#endregion


#region 스킬 창 고르는 footbar

// 스킬 나타낼 창 구현
var skillBackObj = instance_create_layer(0, 0, DEFAULT_LAYER, obj_skill_background, 
{
	image_alpha: 0
});

var _sprite_width =  skillBackObj.sprite_width;
var _sprite_height = skillBackObj.sprite_height;
skillBackObj.x = room_width - _sprite_width;
skillBackObj.y = room_height - _sprite_height;
var scale = window_get_height() / room_height;

var skillButtonSize = 200;
var center_of_skill_background_in_room = skillBackObj.y + _sprite_height/2;
var center_of_skill_background_in_UI = center_of_skill_background_in_room * scale;

// method 찾아보기 method(self, Enter());
show_message("Enter!!");

for(var i = 1; i < SKILL_COUNT; i++)
{
	with(AddButton(200*(i+1)+ skillButtonSize*i , center_of_skill_background_in_UI - skillButtonSize/2, skillButtonSize, skillButtonSize))
	{
		UILIb_button_scaleAnimation(self); // 애니메이션
		global.showSkillList[i](self, SKILL.ARROW);
		
	}
}
#endregion