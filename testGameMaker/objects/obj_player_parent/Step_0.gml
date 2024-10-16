/// @description Insert description here
// You can write your code in this editor

if(obj_ingame_manager.IsGameEnd()) return ;

if(keyboard_check_pressed(ord("R")))  room_restart();
CheckUserInput();
ExecutekUserMove();
CheckSkillCoolTime();




