/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

collision_obj = NULL;
mask_index = -1;

function StickSword()
{
	sprite_index = spr_sword;
	mask_index = spr_sword;
}

function CreateSword(_obj)
{
	SetStickedGround(_obj);
	CO_SCOPE = id;
	var _co = CO_BEGIN
	DELAY 50 THEN
	show_message(11);
	DELAY 50 THEN
	show_message(11);
	DELAY 50 THEN
	show_message(11);
	CO_END
}

function GetStickedGround()
{
	return collision_obj;
}

function SetStickedGround(_obj)
{
	collision_obj = _obj;
}

