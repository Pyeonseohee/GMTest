/// @description Insert description here
// You can write your code in this editor

topBarHeight = 300;
sideBarWidth = 300;
footBarHeight = 300;

global.leftCountDown = COUNT_DOWN;

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
			room_goto(r_Home); 
		});
	}
}

function AddTopBar()
{
	with(AddButton(0, 0, display_get_gui_width(), topBarHeight))
	{
		SetElementAlignment(self, AL_LEFTTOP); // 왼쪽 
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
				_left_skill_coolTime: obj_ingame_manager.GetAllPlayerLeftSkillCoolTimeArray(),
				_playerIndex: _idx,
				_slotNum: _num
			});
				
			SetElementDrawer(self, DRAWER{
				var _skill = _all_skill[_playerIndex][_slotNum];
				var _defaultCoolTime = obj_ingame_manager.GetSkillDefaultCoolTime(_skill);
				var _leftCoolTime = _left_skill_coolTime[_playerIndex][_slotNum]
				var _leftRatio = (_defaultCoolTime - _leftCoolTime)/_defaultCoolTime;
				
				if(_leftRatio == 1)
				{
					draw_sprite_pie_reverse(sp_circle_line_256_256, 0, (_x1+_x2)/2, (_y1+_y2)/2, 0, 360*_leftRatio, c_yellow, (max(0.3, _leftRatio)) *_alpha, _xscale*0.8, _yscale*0.8);
				}
				else
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

#region About Round
function ShowGameStart()
{
	gameStartElem = AddElement(0, 0, display_get_gui_width(), display_get_gui_height());
	
	with(gameStartElem)
	{
		SetElementAlignment(self, AL_CENTER);
		with(AddLabel(0, 0, 0, 0, "게임 시작!!", self))
		{
			SetLabel(self, c_black, 2, 2, 1, 10, AL_CENTER); // 가운데 중앙정렬
			SetElementFit(self, FIT_FULL);
		}
	}
}

function HideGameStart()
{
	if(instance_exists(gameStartElem))
	{
		with(gameStartElem)
		{
			SetElementRemove(self);
		}
	}
}

function ShowGameOver(_winPlayerName)
{
	HideGameStart();
	gameOverElem = AddElement(0, 0, display_get_gui_width(), display_get_gui_height());
	
	with(gameOverElem)
	{
		var _winnerName = _winPlayerName;
		SetElementAlignment(self, AL_CENTER);
		with(AddLabel(0, 0, 0, 0, "게임 오버!!\n\n" + string(_winnerName) + "이가 이겼습니다!", self))
		{
			SetLabel(self, c_black, 2, 2, 1, 10, AL_CENTER); // 가운데 중앙정렬
			SetElementFit(self, FIT_FULL);
		}
	}
}

function HideGameOver()
{
	if(instance_exists(gameOverElem))
	{
		with(gameOverElem)
		{
			SetElementRemove(self);
		}
	}
}

function ShowWinner(_winnerIns)
{
	winnerElem = AddElement(0, 0, display_get_gui_width(), display_get_gui_height())
	
	with(winnerElem)
	{
		var _ins = _winnerIns
		
		SetElementDrawer(self, DRAWER{
			draw_sprite_ext(sp_square_16_16, 0, (_x1+_x2)/2, (_y1+_y2)/2, (_x2-_x1)/16, (_y2-_y1)/16, 0, c_black, 0.5);
		});
		SetElementAlignment(self, AL_CENTER);
		
		with(AddLabel(0, 0, 0, 0, "경기 끝!!\n\n" + string(_ins.GetName()) + "이가 이겼습니다!", self))
		{
			SetLabel(self, c_black, 2, 2, 1, 10, AL_CENTER); // 가운데 중앙정렬
			SetElementFit(self, FIT_FULL);
		}
		
		with(AddButton(0, -1*150, 500, 100, self))
		{
			SetElementAlignment(self, AL_DOWNCENTER);
			SetElementDrawer(self, DRAWER{
				draw_frame_roundedEdgeOrange(_x1, _y1, _x2, _y2, _alpha, _xscale);
			});
	
			UILIb_button_scaleAnimation(self);
	
			with (AddLabel(0, 0, 0, 0, "홈으로", self)) {
				SetLabel(self, c_black, 2, 2, 1, 10, AL_CENTER); // 가운데 중앙정렬
				SetElementFit(self, FIT_FULL);
			}
	
			SetButtonCallback(self, CALLBACK{
				room_goto(r_Home);
			});
			
		}
		
	}
	
}

function HideWinner()
{
	if(instance_exists(winnerElem))
	{
		with(winnerElem)
		{
			SetElementRemove(self);
		}
	}
}

#endregion

#region About CountDown

function StartCountDown()
{
	countDownElem = AddElement(0, 0, display_get_gui_width(), display_get_gui_height());
	with(countDownElem)
	{
		SetElementAlignment(self, AL_CENTER);
		SetElementVariables(self, {_leftCountDown: COUNT_DOWN})
		CO_SCOPE = id;
		var _co = CO_BEGIN
		DELAY 1000 THEN
		_leftCountDown--;
		DELAY 1000 THEN
		_leftCountDown--;
		DELAY 1000 THEN
		_leftCountDown--;
		CO_END
		
		with(AddElement(0, 0, 0, 0, self))
		{
			SetElementVariables(self, {_par: element_parent})
			SetElementDrawer(self, DRAWER{
				draw_set_valign(fa_middle);
				draw_set_halign(fa_center);
				draw_set_color(c_black);
				draw_set_alpha(_alpha);
				draw_text_transformed((_x1+_x2)/2, (_y1+_y2)/2, string(_par._leftCountDown), _xscale*2, _yscale*2, 0);
			});
			SetElementFit(self, FIT_FULL);
		} 
	}
}

function EndCountDown()
{
	if(instance_exists(countDownElem))
	{
		with(countDownElem)
		{
			SetElementRemove(self);
		}
	}
	global.leftCountDown = COUNT_DOWN;
}
#endregion

#region UI 호출
//AddTopBar();
AddSideBar();
#endregion