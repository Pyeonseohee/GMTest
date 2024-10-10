// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


function InitUserInput()
{
	input_left = false;
	input_right = false;
	can_jump = false;
	is_on_ground = false;
}


#region GET

function GetIsOnGround()
{
	return is_on_ground;
}

function GetCanJump()
{
	return can_jump;
}

function GetInputLeft()
{
	return input_left;
}

function GetInputRight()
{
	return input_right;
}
#endregion

#region SET

function SetIsOnGround(_val)
{
	is_on_ground = _val
}

function SetCanJump(_val)
{
	can_jump = _val
}

#endregion

function DownLeftKey()
{
	input_left = true;
	input_right = false;
}

function DownRightKey()
{
	input_left = false;
	input_right = true;
}

function UpLeftKey()
{
	input_left = false;
}

function UpRightKey()
{
	input_right = false;
}

function NoneHorizontalKey()
{
	input_left = false;
	input_right = false;
	Stop();
}


function OnTheGround()
{
	is_on_ground = true;
	can_jump = true;
};