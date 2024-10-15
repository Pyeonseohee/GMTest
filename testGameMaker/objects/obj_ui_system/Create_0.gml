/// @description Insert description here
// You can write your code in this editor
#macro PLAYER1 0
#macro PLAYER2 1

// 여기에 화면 중앙 정렬
var UI_center_x = window_get_width()/2;
var UI_center_y = window_get_height()/2;
var player_offset = 200;

var bottom_margin = 10;
var backButtonMargin = 100;
var gameStartButtonMargin = 30;
var center_x = room_width/2;
var center_y = room_height/2;


global.stu_player_skills = [];
clicked_slot = NULL;

var stu_p1_skill = {
	skill1: SKILL.ARROW,
	skill2: SKILL.VOLLEYBALL,
	skill3: SKILL.TELEPORT
}

var stu_p2_skill = {
	skill1: SKILL.ARROW,
	skill2: SKILL.SWORD,
	skill3: SKILL.TELEPORT
}

stu_player_skills[0] = stu_p1_skill;
stu_player_skills[1] = stu_p2_skill;

var spr_skill = 
{
	arrow: sp_icon_pin_01,
	sword: sp_icon_sword_01,
	volleyball: sp_icon_ball_01,
	teleport: sp_icon_person_01,
};

// 뒤로 가기 버튼
with(AddButton(backButtonMargin, backButtonMargin, 200, 100))
{
	var selectButton = SetElementDrawer(self, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
		draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
		draw_sprite_ext(sp_icon_arrow_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
	});
	
	UILIb_button_scaleAnimation(self); // 애니메이션
	
	SetButtonCallback(self, CALLBACK{
		show_message("클릭??"); 
		room_goto(Room1);
	});
}

// 게임 시작 버튼
with(AddButton((window_get_width() - 300), backButtonMargin, 200, 100))
{
	var selectButton = SetElementDrawer(self, DRAWER{
		draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha, c_yellow, _xscale);
		draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
		draw_sprite_ext(sp_triangle_64_64, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
	});
	
	UILIb_button_scaleAnimation(self); // 애니메이션
	
	SetButtonCallback(self, CALLBACK{
		show_message("클릭??"); 
		room_goto(InGameRoom); 
	});
}



