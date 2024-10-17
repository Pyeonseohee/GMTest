// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
#macro NULL undefined
#macro DEFAULT_LAYER "Instances"
#macro RADIAN_SPEED 3

function InitUserMove()
{
	collision_obj_tile = NULL;
	current_radius = NULL;
}


function GetCollositionTileObj()
{
	return collision_obj_tile;
}

function SetCollisionTileObj(collisionTile)
{
	collision_obj_tile = collisionTile;
}

function SetCurrentRadius(_val)
{
	current_radius = _val
}

function MoveLandAlongEdge(_dir, _spd = RADIAN_SPEED)
{
	if(collision_obj_tile == NULL) return ;
	
	if(_dir < 0)
	{
		image_xscale = -2;
		var cx = collision_obj_tile.x;
		var cy = collision_obj_tile.y;
	
		// 원형 경계 따라 이동
		var radius = collision_obj_tile.sprite_width / 2;
		var dir = point_direction(cx, cy, x, y); // 플레이어와 중심 간의 각도 계산
		image_angle = dir - 90;
		
		var test_dir = dir + _spd;
		current_radius = test_dir;
		
		x = cx + lengthdir_x(radius, test_dir);
		y = cy + lengthdir_y(radius, test_dir);
	}
	else if(_dir > 0)
	{
		image_xscale = 2;
		
		var cx = collision_obj_tile.x;
		var cy = collision_obj_tile.y;
	
		// 원형 경계 따라 이동
		var radius = collision_obj_tile.sprite_width / 2;
		var dir = point_direction(cx, cy, x, y); // 플레이어와 중심 간의 각도 계산
		image_angle = dir - 90;
		
		var test_dir = dir - _spd;
		current_radius = test_dir;
		
		x = cx + lengthdir_x(radius, test_dir);
		y = cy + lengthdir_y(radius, test_dir);
	}
	else
	{
		var cx = collision_obj_tile.x;
		var cy = collision_obj_tile.y;
	
		// 원형 경계 따라 이동
		var radius = collision_obj_tile.sprite_width / 2;
		
		x = cx + lengthdir_x(radius, current_radius);
		y = cy + lengthdir_y(radius, current_radius);
	}
};

function MoveHorizontal(_dir, _spd = 15)
{	
	if(_dir < 0) // 왼쪽으로 이동
	{
		//image_angle = 0;
		image_xscale = -2;
		
	}
	else // 오른쪽으로 이동
	{
		//image_angle = 0;
		image_xscale = 2;
	}
	x += _dir * _spd;
}

function Jump()
{
	if(GetIsOnGround())
	{
		var ground = GetCollositionTileObj();
	
		var cx = ground.x;
		var cy = ground.y;
	
			// 원형 경계 따라 이동
		var radius = ground.sprite_width / 2;
		var dir = point_direction(cx, cy, x, y); // 플레이어와 중심 간의 각도 계산
	
		if (dir >= 180 && dir <= 360) {
	        return ;
	    } else {
	        // 일반 위쪽 점프 처리
	        vspeed = -12;  // 위로 점프
	    }
	
		SetIsOnGround(false);
		SetCanJump(false);
		SetCollisionTileObj(NULL);
		
		audio_play_sound(sound_jump, 1, 0);
	}
}

function Drop()
{
	if(GetIsOnGround())
	{
		var ground = GetCollositionTileObj();
	
		var cx = ground.x;
		var cy = ground.y;
	
			// 원형 경계 따라 이동
		var radius = ground.sprite_width / 2;
		var dir = point_direction(cx, cy, x, y); // 플레이어와 중심 간의 각도 계산
	
		if (dir >= 180 && dir <= 360){
	        vspeed = 7;  // 아래로 떨어짐
	    }
		else{
			return ;
		}
	
		SetIsOnGround(false);
		SetCanDrop(false);
		SetCollisionTileObj(NULL);
		
		audio_play_sound(sound_jump, 1, 0);
	}
}

function MoveOpponent()
{
	if(GetIsOnGround())
	{
		if(collision_obj_tile == NULL) return ;
	
		var cx = collision_obj_tile.x;
		var cy = collision_obj_tile.y;
	
		// 원형 경계 따라 이동
		var radius = collision_obj_tile.sprite_width / 2;
		//var dir = point_direction(cx, cy, x, y); // 플레이어와 중심 간의 각도 계산
		
		var _ddir = 180 + current_radius;
		current_radius = _ddir;
		image_angle = _ddir - 90;
		
		x = cx + lengthdir_x(radius, _ddir);
		y = cy + lengthdir_y(radius, _ddir);
	}
}

function Stop()
{
	hspeed = 0;
}