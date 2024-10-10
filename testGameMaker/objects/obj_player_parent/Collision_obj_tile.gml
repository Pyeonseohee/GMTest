/// @description Insert description here
// You can write your code in this editor
if(!GetIsOnGround())
{
	OnTheGround();
	
	SetCollisionTileObj(other);
	
	// 충돌한 오브젝트의 중심 계산
	var cx = other.x;
	var cy = other.y;
	
	// 원형 경계 따라 이동
    var radius = other.sprite_width / 2;
    var dir = point_direction(cx, cy, x, y); // 플레이어와 중심 간의 각도 계산
	
	image_angle = dir - 90;
	
	hspeed = 0;
	
	x = cx + lengthdir_x(radius, dir);
	y = cy + lengthdir_y(radius, dir);
	
	sprite_index = spr_sSlime_Walk;
}