/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

if(GetTargetIns() == NULL) return ;

x += (GetTargetIns().x - x)/16;
y += (GetTargetIns().y - y)/16;

if(GetTimeOut() > 0)
{
	DecreseTimeOut(1/room_speed);
}
else
{
	if(global.gameManager.IsGameEnd()) return ;
	var _targetIns = GetTargetIns();
	if(_targetIns.IsDead()) return ;
	_targetIns.Dead();
}

