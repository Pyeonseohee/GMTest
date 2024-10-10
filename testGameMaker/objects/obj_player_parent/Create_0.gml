/// @description Insert description here
// You can write your code in this editor

show_debug_message("-------------Create!!!!!!");

is_dead = false;
_score = 0;

var name = "";

gravity_strength = 0.5; // 중력 세기
vspeed = 0; // 수직 속도

#region 키 매칭
leftKey = NULL;
rightKey = NULL;
jumpKey = NULL;
skill1 = NULL;
skill2 = NULL;
skill3 = NULL;
#endregion

InitUserInput();
InitUserMove();

function WinRound()
{
	_score++;
}

function SetName(_name)
{
	name = _name;
}

function Dead()
{
	is_dead = true;
	show_message("죽었다!!!");
	sprite_index = spr_sSlime_Crouch;
	global.gameManager.CheckRoundEnd();
}
#region GET
function GetScore( )
{
	return _score;
}

function IsDead()
{
	return is_dead;
}

function GetName()
{
	return name;
}

#endregion

#region ABOUT_INPUT
function MatchKey(_left, _right, _jump, _skill1, _skill2, _skill3)
{
	leftKey = _left;
	rightKey = _right;
	jumpKey = _jump;
	skill1 = _skill1;
	skill2 = _skill2;
	skill3 = _skill3;
}

function CheckUserInput()
{
	if(keyboard_check_pressed(leftKey))
	{
		if(keyboard_check(rightKey) || keyboard_check_pressed(rightKey))
		{
			NoneHorizontalKey();
		}
		else
		{
			DownLeftKey();
		}
	}

	if(keyboard_check_pressed(rightKey))
	{
		if(keyboard_check(leftKey) || keyboard_check_pressed(leftKey))
		{
			NoneHorizontalKey();
		}
		else
		{
			DownRightKey();
		}
	}

	if(keyboard_check_released(leftKey))
	{
		if(keyboard_check(rightKey) || keyboard_check_pressed(rightKey))
		{
			DownRightKey();
		}
		else
		{
			NoneHorizontalKey();
		}
	}

	if(keyboard_check_released(rightKey))
	{
		if(keyboard_check(leftKey) || keyboard_check_pressed(leftKey))
		{
			DownLeftKey();
		}
		else
		{
			NoneHorizontalKey();
		}
	}

	if(keyboard_check_pressed(jumpKey))
	{
		if(can_jump)
		{
			Jump();
		}
	}
	
	if(keyboard_check_pressed(skill1))
	{
		InvokeSkill(id, global.gameManager.GetTargetEnemy(self), SKILL.TELEPORT);
	}

	if(keyboard_check_pressed(skill2))
	{
		InvokeSkill(id, global.gameManager.GetTargetEnemy(self), SKILL.ARROW);
	}

	if(keyboard_check_pressed(skill3))
	{
		InvokeSkill(id, global.gameManager.GetTargetEnemy(self), SKILL.VOLLEYBALL);
	}
}

#endregion

#region SKILL


#endregion


