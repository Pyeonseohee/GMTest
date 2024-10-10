/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

if(global.gameManager.IsGameEnd()) return ;
if(other.id == invokePlayer.id) return ;

if(other.IsDead()) return ;
else other.Dead();

other.sprite_index = spr_sSlime_Crouch;

alarm[0] = 10 * room_speed;

