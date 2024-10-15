/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
center_x = room_width/2; // 원의 중심 x 좌표
center_y = room_height/2; // 원의 중심 y 좌표
radius = 500;   // 반지름
current_radian = 0;     // 현재 각도 (라디안)
radian_speed = 0.01;   // 각도 변화 속도

function SetInitPos(_rad)
{
	current_radian = _rad;
	x = center_x + radius * cos(current_radian); // x 좌표 계산
	y = center_y - radius * sin(current_radian); // y 좌표 계산
}