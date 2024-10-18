/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

invokePlayer = NULL;
collision_tile = NULL;
_current_angle = 0;
start = false;
firstDir = NULL;

function SetCollisionTile(_obj)
{
	collision_tile = _obj
}

function GetCollisionTile()
{
	return collision_tile;
}

function StartMove()
{
	start = true;
}

function GetStartMove()
{
	return start;
}

function InitStartDir()
{
	var cx = GetCollisionTile().x;
	var cy = GetCollisionTile().y;
	
	// 원형 경계 따라 이동
	var radius = GetCollisionTile().sprite_width / 2;
	var dir = point_direction(cx, cy, x, y); // 플레이어와 중심 간의 각도 계산

	image_angle = dir - 90;
	firstDir = dir;
		
	x = cx + lengthdir_x(radius, dir);
	y = cy + lengthdir_y(radius, dir);
}



	
CO_SCOPE = id;
var _co = CO_BEGIN
DELAY 1000 THEN
StartMove();
CO_END