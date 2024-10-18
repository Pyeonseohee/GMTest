/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
check_collision = false;

collision_obj = NULL;
sword_height = sprite_height + 100;
sword_direction = NULL;
is_start_stick = false;
is_end_stick = false;
is_sticked = false;
invokePlayer = NULL;


function CreateSword(_obj, _dir, _invokeIns)
{
	SetStickedGround(_obj);
	SetDir(_dir);
	SetInvokePlayer(_invokeIns);
	CO_SCOPE = id
	var co = CO_BEGIN
	DELAY 2000 THEN
	StartStick()
	CO_END
}

function StickSword()
{
	sprite_index = spr_sword;
	object_set_mask(obj_sword, spr_sword);
	is_sticked = true;
	check_collision = true;
}


function EndStickSword()
{
	is_end_stick = true;
}

function StartStick()
{
	is_start_stick = true;
	audio_play_sound(sound_thunder, 0, false);
}

#region GET

function GetDir()
{
	return sword_direction;
}

function GetSwordHeight()
{
	return sword_height;
}

function GetEndStick()
{
	return is_end_stick;
}

function IsSticked()
{
	return is_sticked;
}
function GetStickedGround()
{
	return collision_obj;
}

function GetStartStick()
{
	return is_start_stick;
}

function GetInvokePlayer()
{
	return invokePlayer;
}

#endregion

#region SET

function SetStickedGround(_obj)
{
	collision_obj = _obj;
}

function SetDir(_dir)
{
	sword_direction = _dir; 
}

function SetInvokePlayer(_ins)
{
	invokePlayer = _ins;
}

#endregion



function DecreaseSwordHeight(_val)
{
	sword_height -= _val
}

