/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

if(_current_angle > 360) 
{
	instance_destroy();
	return ;
}

var cx = collision_tile.x;
var cy = collision_tile.y;
	
// 원형 경계 따라 이동
var radius = collision_tile.sprite_width / 2;
var dir = point_direction(cx, cy, x, y); // 플레이어와 중심 간의 각도 계산

image_angle = dir - 90;
_current_angle += 7;		

var test_dir = dir + 7;
		
x = cx + lengthdir_x(radius, test_dir);
y = cy + lengthdir_y(radius, test_dir);

var point = [x, y]; // 현재 위치

array_push(trajectory, point); // 현재 위치를 배열에 추가

// 궤적 길이 제한
if (array_length(trajectory) > trail_length) {
    array_shift(trajectory); // 가장 오래된 점 삭제
}