/// @description Insert description here
// You can write your code in this editor

if(obj_ingame_manager.IsGameEnd()) exit;

//if(keyboard_check_pressed(ord("R")))  room_restart();
CheckUserInput();
ExecutekUserMove();
CheckSkillCoolTime();
if(place_meeting(x, y, obj_player_parent))
{
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
}





