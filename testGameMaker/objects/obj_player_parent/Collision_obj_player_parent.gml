/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
show_debug_message("?");
for(var _i = 0; _i < instance_number(obj_player_parent); _i++)
{
	var _ins = instance_find(obj_player_parent, _i);
	if(_ins.GetIndex() != GetIndex())
	{
		if(infected && can_remove)
		{
			if(!_ins.infected)
			{
				bombIns.ChangeTarget(_ins);
				RemoveBomb();
			}
		}
	}
}