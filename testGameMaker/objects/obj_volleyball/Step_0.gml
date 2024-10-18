/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

if(_current_angle > 360) 
{
	instance_destroy();
	return ;
}

if(GetCollisionTile() == NULL) return ;


if(GetStartMove())
{
	var _spd = 7;
	var cx = GetCollisionTile().x;
	var cy = GetCollisionTile().y;
	
	// 원형 경계 따라 이동
	var radius = GetCollisionTile().sprite_width / 2;
	var dir = point_direction(cx, cy, x, y); // 플레이어와 중심 간의 각도 계산

	image_angle = dir - 90;
	_current_angle += _spd;		

	var test_dir = dir + _spd;
		
	x = cx + lengthdir_x(radius, test_dir);
	y = cy + lengthdir_y(radius, test_dir);
}
else
{
	var cx = GetCollisionTile().x;
	var cy = GetCollisionTile().y;
	
	// 원형 경계 따라 이동
	var radius = GetCollisionTile().sprite_width / 2;
	var dir = point_direction(cx, cy, x, y); // 플레이어와 중심 간의 각도 계산
		
	x = cx + lengthdir_x(radius, firstDir);
	y = cy + lengthdir_y(radius, firstDir);
}
