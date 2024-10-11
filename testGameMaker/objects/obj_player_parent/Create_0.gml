/// @description Insert description here
// You can write your code in this editor

show_debug_message("-------------Create!!!!!!");

is_dead = false;
_score = 0;

var name = "";

user_skill = {
	skill1: SKILL.ARROW,
	skill2: SKILL.SWORD,
	skill3: SKILL.VOLLEYBALL
};
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
InitSkill();

function SetSkill(_skill)
{
	user_skill.skill1 = _skill.skill1;
	user_skill.skill2 = _skill.skill2;
	user_skill.skill3 = _skill.skill3;
}

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
function MatchKey(stu_keyMap)
{
	leftKey = stu_keyMap.left;
	rightKey = stu_keyMap.right;
	jumpKey = stu_keyMap.jump;
	skill1 = stu_keyMap.skill1;
	skill2 = stu_keyMap.skill2;
	skill3 = stu_keyMap.skill3;
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
		InvokeSkill(id, global.gameManager.GetTargetEnemy(self), user_skill.skill1);
	}

	if(keyboard_check_pressed(skill2))
	{
		InvokeSkill(id, global.gameManager.GetTargetEnemy(self), user_skill.skill2);
	}

	if(keyboard_check_pressed(skill3))
	{
		InvokeSkill(id, global.gameManager.GetTargetEnemy(self), user_skill.skill3);
	}
}

#endregion

#region SKILL


#endregion


