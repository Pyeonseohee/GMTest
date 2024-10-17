/// @description Insert description here
// You can write your code in this editor
name = "";
playerIndex = NULL;
is_dead = false;
gravity_strength = 0.5; // 중력 세기
vspeed = 0; // 수직 속도
infected = false;

#region 셰이더
_uniColor = shader_get_uniform(BombEffect, "u_colour");
_color = [1.0, 1.0, 0.0, 1.0];

_uniUV = shader_get_uniform(BombEffect, "u_uv");
_uniTime = shader_get_uniform(BombEffect, "u_time");
_uniSpeed = shader_get_uniform(BombEffect, "u_speed");
_uniSection = shader_get_uniform(BombEffect, "u_section");
_uniSaturation = shader_get_uniform(BombEffect, "u_saturation");
_uniBrightness = shader_get_uniform(BombEffect, "u_brightness");
_uniMix = shader_get_uniform(BombEffect, "u_mix");

_time = 0;
_speed = 1.0;
_section = 0.5;
_saturation = 0.7;
_brightness = 0.8;
timer_duration = 10;
_mix = 0.5;
#endregion

#region 유저 오브제 Init
InitUserInput();
InitUserMove();
InitSkill();
#endregion

#region 스킬 관련
user_skill_list = [];
skillCoolTimeArray=
[
	0,
	0,
	0
];

function InitSkill(_skillList)
{
	user_skill_list = _skillList;
}



function GetLeftAllSkillCoolTime()
{
	return skillCoolTimeArray;
}

function ReceiveBomb()
{
	infected = true;
	_time = 0;
}

function RemoveBomb()
{
	infected = false;
	_time = 0;
}

function SparkTheBomb()
{
	Dead();
}

function DrawBombEffectShader()
{
	shader_set(BombEffect);
	var uv = sprite_get_uvs(sprite_index, image_index);
	
	shader_set_uniform_f(_uniUV, uv[0], uv[2]);
	shader_set_uniform_f(_uniSpeed, _speed);
	shader_set_uniform_f(_uniTime, _time);
	shader_set_uniform_f(_uniSection, _section);
	shader_set_uniform_f(_uniSaturation, _saturation);
	shader_set_uniform_f(_uniBrightness, _brightness);
	shader_set_uniform_f(_uniMix, _mix);
	
	draw_self();
	shader_reset();
}
#endregion

function SetIndex(_idx)
{
	playerIdx = _idx;
}


function SetName(_name)
{
	name = _name;
}

function Dead()
{
	is_dead = true;
	sprite_index = spr_sSlime_Crouch;
	global.gameManager.CheckRoundEnd();
}
#region GET
function GetScore()
{
	return win_score;
}

function IsDead()
{
	return is_dead;
}

function GetIndex()
{
	return playerIdx;
}

function GetName()
{
	return name;
}

#endregion

#region ABOUT 키 매칭
leftKey = NULL;
rightKey = NULL;
jumpKey = NULL;
dropKey = NULL;
skill1 = NULL;
skill2 = NULL;
skill3 = NULL;

function MatchKey(stu_keyMap)
{
	leftKey = stu_keyMap.left;
	rightKey = stu_keyMap.right;
	jumpKey = stu_keyMap.jump;
	dropKey = stu_keyMap.drop;
	skill1 = stu_keyMap.skill1;
	skill2 = stu_keyMap.skill2;
	skill3 = stu_keyMap.skill3;
}
#endregion

#region About 키 입력 체크
function CheckUserInput()
{
	if(keyboard_check_pressed(leftKey))
	{
		if(keyboard_check(rightKey) || keyboard_check_pressed(rightKey))
			NoneHorizontalKey();
		else
			DownLeftKey();
	}

	if(keyboard_check_pressed(rightKey))
	{
		if(keyboard_check(leftKey) || keyboard_check_pressed(leftKey))
			NoneHorizontalKey();
		else
			DownRightKey();
	}

	if(keyboard_check_released(leftKey))
	{
		if(keyboard_check(rightKey) || keyboard_check_pressed(rightKey))
			DownRightKey();
		else
			NoneHorizontalKey();
	}

	if(keyboard_check_released(rightKey))
	{
		if(keyboard_check(leftKey) || keyboard_check_pressed(leftKey))
			DownLeftKey();
		else
			NoneHorizontalKey();
	}

	if(keyboard_check_pressed(jumpKey))
	{
		if(can_jump) Jump();
	}
	
	if(keyboard_check_pressed(dropKey))
	{
		if(can_drop) Drop();
	}
	
	if(keyboard_check_pressed(skill1) && obj_ingame_manager.GetLeftSkillCoolTime(GetIndex(), 0) == 0)
	{
		obj_ingame_manager.ResetLeftSkillCoolTime(GetIndex(), 0, user_skill_list[0]);
		InvokeSkill(id, global.gameManager.GetTargetEnemy(self), user_skill_list[0]);
	}

	if(keyboard_check_pressed(skill2) && obj_ingame_manager.GetLeftSkillCoolTime(GetIndex(), 1) == 0)
	{
		obj_ingame_manager.ResetLeftSkillCoolTime(GetIndex(), 1, user_skill_list[1]);
		InvokeSkill(id, global.gameManager.GetTargetEnemy(self), user_skill_list[1]);
	}

	if(keyboard_check_pressed(skill3) && obj_ingame_manager.GetLeftSkillCoolTime(GetIndex(), 2) == 0)
	{
		obj_ingame_manager.ResetLeftSkillCoolTime(GetIndex(), 2, user_skill_list[2]);
		InvokeSkill(id, global.gameManager.GetTargetEnemy(self), user_skill_list[2]);
	}
}

#endregion

#region About 이동
function ExecutekUserMove()
{
	if(GetIsOnGround()) // 땅에 있을 때
	{
		vspeed = 0;
		if(GetInputLeft())
		{
			MoveLandAlongEdge(-1);
		}
		else if(GetInputRight())
		{
			MoveLandAlongEdge(1);
		}
		else
		{
			MoveLandAlongEdge(0);
		}
	}
	else // 공중에 있을 때
	{
		 vspeed += gravity_strength; // 중력에 따른 속도 증가
		 y += vspeed;
	 
		if(GetInputLeft())
		{
			MoveHorizontal(-1);
		}
		else if(GetInputRight())
		{
			MoveHorizontal(1);
		}
	}
}
#endregion

#region 스킬 쿨타임

function CheckSkillCoolTime()
{
	var _decreaseValue = 1;
	for(var _i = 0; _i < 3; _i++)
	{
		if(obj_ingame_manager.GetLeftSkillCoolTime(GetIndex(), _i) > 0)
		{
			obj_ingame_manager.DecreaseLeftSkillCoolTime(GetIndex(), _i, _decreaseValue/room_speed);
		}
	}
}
#endregion
