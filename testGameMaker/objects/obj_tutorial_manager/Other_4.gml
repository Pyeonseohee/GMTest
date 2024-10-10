/// @description Insert description here
// You can write your code in this editor

show_debug_message("Toturial Room start!!!!");
global.instance_player1 = instance_create_layer(960, 100, "Instances", obj_player1, {image_xscale: 2, image_yscale: 2});
global.instance_player2 = instance_create_layer(960, 100, "Instances", obj_player2, {image_xscale: 2, image_yscale: 2, image_blend: c_yellow});

//global.instance_player2 = instance_create_layer(200, 200, "Instances", obj_player2, {image_xscale: 2, image_yscale: 2, image_blend: c_yellow});
//var instance_player2 = instance_create(test_x, test_x, obj_player2);