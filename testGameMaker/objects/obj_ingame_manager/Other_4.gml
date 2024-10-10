/// @description Insert description here
// You can write your code in this editor

show_debug_message("InGameRoom start!!!!");
map_type = 1;
// 맵 무작위 생성
// 랜덤 맵 0-2 뽑고
// case에 따라서 obj_tile 생성

var random_map_idx = irandom(2);
center_x = room_width/2;
center_y = room_height/2;
offset = 150;	

CreateMap(map_type);