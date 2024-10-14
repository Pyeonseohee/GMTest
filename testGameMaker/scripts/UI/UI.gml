// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function AddSkillSlot(_x, _y, _skill)
{
	// 플레이어 옆에 띄우는 UI 스킬 슬롯
	with(AddButton(_x, _y, 100, 100))
	{
		SetElementDrawer(self, DRAWER{
			switch(_skill)
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
		});
	
		SetElementVariables(self, {skill: SKILL.ARROW});
	
		UILIb_button_scaleAnimation(self); // 애니메이션
	
		SetButtonCallback(self, CALLBACK{
			skill = !skill;
			clicked_player = PLAYER1;
			clicked_slot = 0;
		});
	}
}