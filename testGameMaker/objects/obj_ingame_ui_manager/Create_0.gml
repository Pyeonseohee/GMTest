/// @description Insert description here
// You can write your code in this editor

topBarHeight = 300;
sideBarWidth = 300;
footBarHeight = 300;

#region About TopBar
function AddHomeButton(_ins)
{
	var _buttonWidth = 200;
	var _buttonHeight = 100;
	var _buttonMargin = 100;
	
	with(AddButton(-1*_buttonMargin, 0, _buttonWidth, _buttonHeight, _ins))
	{
		SetElementAlignment(self, AL_RIGHTCENTER);
		SetElementDrawer(self, DRAWER{
			draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha, c_yellow, _xscale);
			draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
			draw_sprite_ext(sp_icon_home_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
		});
	
		UILIb_button_scaleAnimation(self); // 애니메이션
	
		SetButtonCallback(self, CALLBACK{
			room_goto(Home); 
		});
	}
}

function AddTopBar()
{
	with(AddButton(0, 0, display_get_gui_width(), topBarHeight))
	{
		obj_ingame_ui_manager.AddHomeButton(self);
	}
}
#endregion

#region About Sidebar
function AddSkillSlot(_playerIdx, _ins)
{
	var _margin = 70;
	var _skillIconSize = 180;
	
	for(var i = 0; i < 3; i++)
	{
		with(AddButton(0, (_skillIconSize + _margin)*(i - 1), _skillIconSize, _skillIconSize, _ins))
		{
			var _idx = _playerIdx;
			var _num = i;
			
			SetElementAlignment(self, AL_CENTER);
			SetElementVariables(self, {
				_all_skill_spr: global.all_skill_spr,
				_all_skill: global.all_skill,
				_left_skill_coolTime: obj_ingame_manager.GetAllPlayerAllSkillCoolTimeArray(),
				_playerIndex: _idx,
				_slotNum: _num
			});
				
			SetElementDrawer(self, DRAWER{
				var _skill = _all_skill[_playerIndex][_slotNum];
				var _defaultCoolTime = obj_ingame_manager.GetSkillCoolTime(_skill);
				var _leftCoolTime = _left_skill_coolTime[_playerIndex][_slotNum]
				var _leftRatio = (_defaultCoolTime - _leftCoolTime)/_defaultCoolTime;

				draw_sprite_pie_reverse(sp_circle_line_256_256, 0, (_x1+_x2)/2, (_y1+_y2)/2, 0, 360*_leftRatio, c_white, (max(0.3, _leftRatio)) *_alpha, _xscale*0.8, _yscale*0.8);
			});
			
			with(AddElement(0, 0, 0, 0, self))
			{
				SetElementVariables(self, {
					_par: element_parent
				});
				
				SetElementAlignment(self, AL_CENTER);
				SetElementDrawer(self, DRAWER{
					draw_sprite_ext(_par._all_skill_spr[_par._all_skill[_par._playerIndex][_par._slotNum]], 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale*1.2, _yscale*1.2, 0, c_white, _alpha);
				});
			}
		}
	}
}

function AddSkillSlotLeft(_ins)
{
	AddSkillSlot(0, _ins);
}

function AddSkillSlotRight(_ins)
{
	AddSkillSlot(1, _ins);
}

function AddSideBar()
{
	// 왼쪽 스킬 창
	with(AddButton(0, topBarHeight, sideBarWidth, display_get_gui_height() - topBarHeight - footBarHeight))
	{
		obj_ingame_ui_manager.AddSkillSlotLeft(self);
	}
	// 오른쪽 스킬 창
	with(AddButton(display_get_gui_width() - sideBarWidth, topBarHeight, sideBarWidth, display_get_gui_height() - topBarHeight - footBarHeight))
	{
		obj_ingame_ui_manager.AddSkillSlotRight(self);
	}
}
#endregion

#region UI 호출
AddTopBar();
AddSideBar();
#endregion