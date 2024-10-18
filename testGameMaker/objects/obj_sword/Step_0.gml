/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

var _obj = GetStickedGround();

if(_obj != NULL)
{
	var cx = _obj.x;
	var cy = _obj.y;
	
	// 원형 경계 따라 이동
	var radius = _obj.sprite_width / 2;
	
	if(!GetStartStick())
	{
		radius += GetSwordHeight();
	}
	else
	{
		DecreaseSwordHeight(room_speed*0.9);
		radius += GetSwordHeight();
		
		if(IsSticked())
		{
			if(is_end_stick)
			{
				radius = 0;
			}
			else
			{
				if(radius <= 0)
					EndStickSword();
			}
		}
		else
		{
			if(GetSwordHeight() < -50)
			{
				StickSword();
			}
		}
		
	}
		
	x = cx + lengthdir_x(radius, GetDir());
	y = cy + lengthdir_y(radius, GetDir());
}