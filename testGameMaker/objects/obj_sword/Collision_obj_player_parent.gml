/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

if(global.gameManager.IsGameEnd()) return ;
if(other.IsDead()) return ;
else other.Dead();

alarm[0] = 3 * room_speed;
