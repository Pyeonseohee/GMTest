/// @description Insert description here
// You can write your code in this editor

// 여기에 화면 중앙 정렬
var offset = 50;
var instance_ui_login_button = instance_create_layer(room_width/2, room_height/2, "Instances", obj_ui_button);
// 텍스트 삽입
instance_ui_login_button.text = "LOGIN";
show_debug_message("login!!!");
var instance_ui_register_button = instance_create_layer(room_width/2, room_height/2 + obj_ui_button.sprite_height + offset, "Instances", obj_ui_button);
show_debug_message("register!!!");
instance_ui_register_button.text = "REGISTER";


