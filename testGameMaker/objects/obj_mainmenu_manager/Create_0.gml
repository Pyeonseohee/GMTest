/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

// 플레이어 두 명 생성
// 밑의 스프라이트 생성

var center_x = room_width/2;
var center_y = room_height/2;

var player_set_x = center_x/2;
var player_set_y = center_y/2;

show_debug_message("Create!!!!!" + string(center_x) + ", " + string(center_y) + ", " + string(player_set_x));
var ins_vs = instance_create_layer(center_x, player_set_y, "Instances", obj_vs,{
	image_xscale: 0.5,
	image_yscale: 0.5
});

var ins_player1 = instance_create_layer(center_x - player_set_x, player_set_y,  "Instances", obj_test_player);
var ins_player2 = instance_create_layer(center_x + player_set_x, player_set_y, "Instances", obj_test_player);

