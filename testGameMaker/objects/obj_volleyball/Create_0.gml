/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

invokePlayer = NULL;
collision_tile = NULL;

volleyball_radius = sprite_width/2;

var start_angle = 0;
_current_angle = 0;
var end_angle = 360;

function SetCollisionTile(_obj)
{
	collision_tile = _obj
}

trajectory = []; // 궤적을 저장할 배열
trail_length = 50; // 궤적의 길이