/// @description Insert description here
// You can write your code in this editor

#region About 스킬 슬롯
clicked_slot = NULL;
clicked_player = NULL;
maxSkillCount = 3;
#endregion

#region About 스킬
global.all_skill = 
[
	[SKILL.ARROW, SKILL.DASH, SKILL.BOMB],
	[SKILL.SWORD, SKILL.TELEPORT, SKILL.VOLLEYBALL]
];

global.spr_skill = 
{
	recreate: sp_icon_rotation_01,
	arrow: sp_icon_pin_01,
	sword: sp_icon_sword_01,
	volleyball: sp_icon_ball_01,
	teleport: sp_icon_person_01,
	dash: sp_icon_shoes_01,
	bomb: spr_bomb
};
#endregion

#region About UI element
var UI_center_x = display_get_gui_width()/2;
var UI_center_y = display_get_gui_height()/2;

topBarHeight = 300;
footBarHeight = 300;
sideBarWidth = 300;

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

function AddSkillSlot(_playerIdx, _ins)
{
	var _margin = 50;
	var skillIconSize = 180;
	
	for(var i = 0; i < 3; i++)
	{
		with(AddButton(0, (skillIconSize + _margin)*(i - 1), skillIconSize, skillIconSize, _ins))
		{
			var _idx = _playerIdx;
			var _num = i;
			
			UILIb_button_scaleAnimation(self); // 애니메이션
			SetElementAlignment(self, AL_CENTER);
			SetElementVariables(self, {
				_test: global.all_skill,
				_playerIndex: _idx,
				_slotNum: _num
				});
			SetElementDrawer(self, DRAWER{
				draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
				draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
				switch(_test[_playerIndex][_slotNum])
				{
					case SKILL.RECREATE:
						draw_sprite_ext(global.spr_skill.recreate, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
						break;
					case SKILL.SWORD:
						draw_sprite_ext(global.spr_skill.sword, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
						break;
					case SKILL.ARROW:
						draw_sprite_ext(global.spr_skill.arrow, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
						break;
					case SKILL.VOLLEYBALL:
						draw_sprite_ext(global.spr_skill.volleyball, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
						break;
					case SKILL.TELEPORT:
						draw_sprite_ext(global.spr_skill.teleport, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
						break;
					case SKILL.DASH:
						draw_sprite_ext(global.spr_skill.dash, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
						break;
					case SKILL.BOMB:
						draw_sprite_ext(global.spr_skill.bomb, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
						break;
					default:
						break;
				}
			});
	
			SetButtonCallback(self, CALLBACK{
				obj_ui_system.clicked_player = _playerIndex;
				obj_ui_system.clicked_slot = _slotNum;
				show_message("클릭한 플레이어: " + string(obj_ui_system.clicked_player) + ", 클릭한 슬롯: " + string(obj_ui_system.clicked_slot));
			});
		}
	}
}

function AddSkillSlotLeft(_x, _y, _ins)
{
	AddSkillSlot(0, _ins);
}

function AddSkillSlotRight(_x, _y, _ins)
{
	AddSkillSlot(1, _ins);
}

function AddSideBar()
{
	// 왼쪽 스킬 창
	with(AddButton(0, topBarHeight, sideBarWidth, display_get_gui_height() - topBarHeight - footBarHeight))
	{
		obj_ui_system.AddSkillSlotLeft(x, y, self);
	}
	// 오른쪽 스킬 창
	with(AddButton(display_get_gui_width() - sideBarWidth, topBarHeight, sideBarWidth, display_get_gui_height() - topBarHeight - footBarHeight))
	{
		obj_ui_system.AddSkillSlotRight(x, y, self);
	}
}
#endregion

#region About FootBar

function AddSkillGuideButton(_ins)
{
	for(var i = 0; i < SKILL_COUNT; i++)
	{
		var _margin = 150;
		var _skillButtonSize = 150;
		with(AddButton(_skillButtonSize * (2.5 - i) + (2.5 - i) * _margin, 0, _skillButtonSize, _skillButtonSize, _ins))
		{
			SetElementAlignment(self, AL_CENTER);
			UILIb_button_scaleAnimation(self); // 애니메이션
			global.showSkillList[i](self, SKILL.ARROW);
		}
	}
}
function AddFootBar()
{
	with(AddButton(0, display_get_gui_height() - footBarHeight, display_get_gui_width(), footBarHeight))
	{
		var _skillButtonSize = 200;
		var _skillExplainLabel = AddLabel(0, 0, 0, 0, "", self);
		obj_ui_system.skillExplainLabel = _skillExplainLabel;
		
		SetElementDrawer(self, DRAWER{
			draw_set_alpha(0.7);
			draw_set_color(c_black);
			draw_rectangle(_x1, _y1, _x2, _y2, false);
			//draw_sprite_ext(sp_square_16_16, 0, (_x1+_x2)/2, (_y1+_y2)/2, (_x2-_x1) / 16, (_y2-_y1) / 16, 0, c_gray, _alpha);
		});
		
		with(_skillExplainLabel)
		{
			SetLabel(self, c_white, 1, 1, 1, 5, AL_DOWNCENTER, global.FontDefault, false);
			SetElementFit(self, FIT_FULL);
		}
		obj_ui_system.AddSkillGuideButton(self);
	}
}
#endregion

#region About player sprtie
function AddPlayerSprite()
{
	var _player_margin = 500;
	var _player_offset = 100;
	var _player_y = display_get_gui_height()/2;
	var _player_size = 300;
	
	var _par = AddElement(sideBarWidth, topBarHeight, display_get_gui_width() - sideBarWidth*2, display_get_gui_height() - topBarHeight - footBarHeight)
	with(_par)
	{
		// 플레이어 1 생성
		with(AddButton(-1*_player_margin, 0, _player_size, _player_size, self))
		{
			SetElementAlignment(self, AL_CENTER);
			SetElementDrawer(self, DRAWER{
				draw_sprite_ext(spr_sSlime_Walk, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale*8, _yscale*8, 0, c_green, _alpha);
			});
		}

		// 플레이어 2 생성
		with(AddButton(_player_margin, 0, _player_size, _player_size))
		{
			SetElementAlignment(self, AL_CENTER);
			SetElementDrawer(self, DRAWER{
				draw_sprite_ext(spr_sSlime_Walk, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale*8, _yscale*8, 0, c_yellow, _alpha);
			});
		}
	}
}
#endregion

#region 실제 함수 호출
AddTopBar();
AddSideBar();
AddFootBar();
AddPlayerSprite();
#endregion