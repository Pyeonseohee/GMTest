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


function DrawSpriteSkill(skill)
{
	switch(skill)
	{
		case SKILL.ARROW:
			draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
			draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
			draw_sprite_ext(spr_skill.arrow, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
			break;
		case SKILL.VOLLEYBALL:
			draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
			draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
			draw_sprite_ext(spr_skill.volleyball, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
			break;
		case SKILL.TELEPORT:
			draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
			draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
			draw_sprite_ext(spr_skill.arrow, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
			break;
		case SKILL.SWORD:
			draw_frame_roundedGlow(_x1, _y1, _x2, _y2, _alpha,  c_yellow, _xscale);
			draw_frame_12rounded(_x1, _y1, _x2, _y2, _alpha, c_dkgray, _xscale);
			draw_sprite_ext(spr_skill.teleport, 0, (_x1+_x2)/2, (_y1+_y2)/2, _xscale, _yscale, 0, c_white, _alpha);
			break;
	}
}



with(AddButton(200, 200, 100, 100))
{
	SetElementDrawer(self, DRAWER{
		skill = stu_p1_skill.skill1;
		DrawSpriteSkill(skill);
	});
	
	SetElementVariables(self, {skill: SKILL.ARROW});
	
	UILIb_button_scaleAnimation(self); // 애니메이션
	
	SetButtonCallback(self, CALLBACK{
		skill = !skill;
		clicked_player = PLAYER1;
		clicked_slot = 0;
	});
}

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


// 스킬 나타낼 창 구현
var skillBackObj = instance_create_layer(0, 0, DEFAULT_LAYER, obj_skill_background, 
{
	image_alpha: 0.6
});

var _sprite_width =  skillBackObj.sprite_width;
var _sprite_height = skillBackObj.sprite_height;
skillBackObj.x = room_width - _sprite_width;
skillBackObj.y = room_height - _sprite_height;
var scale = window_get_height() / room_height;

var skillButtonSize = 200;
var center_of_skill_background_in_room = skillBackObj.y + _sprite_height/2;
var center_of_skill_background_in_UI = center_of_skill_background_in_room * scale;

// method 찾아보기 method(self, Enter());
show_message("Enter!!");

for(var i = 0; i < SKILL_COUNT; i++)
{
	with(AddButton(200*(i+1)+ skillButtonSize*i , center_of_skill_background_in_UI - skillButtonSize/2, skillButtonSize, skillButtonSize))
	{
		switch(i)
		{
			case SKILL.ARROW:
				var selectButton = SetElementDrawer(self, DRAWER{
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
					draw_sprite_ext(sp_icon_pin_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, 2 * _xscale, 2 * _yscale, 0, c_white, _alpha);
				});
					// 클릭하면 스킬 변경
				SetButtonCallback(self, CALLBACK{
					show_message("화살 클릭??");
					
				});
				// 호버인듯
				SetButtonFocusCallback(self,CALLBACK{
					show_message("플레이어가 바라보는 방향으로 직선 궤도로 나아가는 화살을 발사합니다." );  
				});
				break;
			case SKILL.SWORD:
				var selectButton = SetElementDrawer(self, DRAWER{
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
					draw_sprite_ext(sp_icon_sword_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, 2 * _xscale, 2 * _yscale, 0, c_white, _alpha);
				});
			
					// 클릭하면 스킬 변경
				SetButtonCallback(self, CALLBACK{
					show_message("검 클릭??");  
				});
				// 호버인듯
				SetButtonFocusCallback(self,CALLBACK{
					show_message("땅에 붙어있는 상태에서 원의 반대편에 검을 꽂을 수 있습니다." );  
				});
				break;
			case SKILL.TELEPORT:
				var selectButton = SetElementDrawer(self, DRAWER{
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
					draw_sprite_ext(sp_icon_person_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, 2, 2, 0, c_white, _alpha);
				});
			
					// 클릭하면 스킬 변경
				SetButtonCallback(self, CALLBACK{
					show_message("텔레포트! 클릭??");  
				});
				// 호버인듯
				SetButtonFocusCallback(self,CALLBACK{
					show_message("땅에 붙어있는 상태에서 원의 반대편으로 이동할 수 있습니다." ); 
					
				});
				break;
			case SKILL.VOLLEYBALL:
				var selectButton = SetElementDrawer(self, DRAWER{
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
					draw_sprite_ext(sp_icon_ball_01, 0, (_x1+_x2)/2, (_y1+_y2)/2, 2, 2, 0, c_white, _alpha);
				});
			
					// 클릭하면 스킬 변경
				SetButtonCallback(self, CALLBACK{
					show_message("배구공 클릭??");  
				});
				// 호버인듯
				SetButtonFocusCallback(self,CALLBACK{
					show_message("땅에 붙어있는 상태에서 그 땅에 배구공을 굴려 적을 공격합니다.\n단, 자신은 죽지 않습니다." );  
				});
				break;
			case SKILL.RECREATE:
				var selectButton = SetElementDrawer(self, DRAWER{
					draw_frame_roundedGlow(_x1, _y1, _x2, _y2, 0.5, c_silver, _xscale);
					draw_sprite_ext(sp_icon_star_02, 0, (_x1+_x2)/2, (_y1+_y2)/2, 2, 2, 0, c_white, _alpha);
				});
			
				// 클릭하면 스킬 변경
				SetButtonCallback(self, CALLBACK{
					show_message("부활 클릭??");  
				});
				// 호버인듯
				SetButtonFocusCallback(self,CALLBACK{
					show_message("라운드에서 단 한 번 다시 부활할 수 있습니다." );  
				});
				break;
		}
		UILIb_button_scaleAnimation(self); // 애니메이션
	}
}


// 플레이어 1 생성
with(AddButton(700, center_y, 400, 400))
{
	var selectButton = SetElementDrawer(self, DRAWER{
		draw_sprite_ext(spr_sSlime_Walk, 0, (_x1+_x2)/2, (_y1+_y2)/2, 10, 10, 0, c_white, _alpha);
	});
	
	UILIb_button_scaleAnimation(self); // 애니메이션
	
	SetButtonCallback(self, CALLBACK{
		clicked_player = PLAYER1;
		show_message("플레이어 1 클릭??");
	});
}

// 플레이어 2 생성
with(AddButton(1600, center_y, 400, 400))
{
	var selectButton = SetElementDrawer(self, DRAWER{
		draw_sprite_ext(spr_sSlime_Walk, 0, (_x1+_x2)/2, (_y1+_y2)/2, 10, 10, 0, c_yellow, _alpha);
	});
	
	UILIb_button_scaleAnimation(self); // 애니메이션
	
	SetButtonCallback(self, CALLBACK{
		clicked_player = PLAYER2;
		show_message("플레이어 2 클릭??"); 
	});
}


















// 플레이어 두 명 생성


// 스킬 생성


