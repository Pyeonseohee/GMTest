/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
show_debug_message("??????????" + string(other) + " 상대 충돌!!!!!!!!!!!!");

if(infected)
{
	show_debug_message(string(other) + " 상대 충돌!!!!!!!!!!!!");
	other.ReceiveBomb(bombIns);
	bombIns.ChangeTarget(other);
	self.RemoveBomb();
	show_debug_message("건네!!!");
}