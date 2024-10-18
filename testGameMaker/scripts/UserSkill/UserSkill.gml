// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
#macro SKILL_COUNT 6
#macro INF infinity
enum SKILL
{
	SWORD = 0,
	ARROW = 1,
	VOLLEYBALL = 2,
	TELEPORT = 3,
	DASH = 4,
	BOMB = 5
}
/*
skillData = {
	"SWORD" : { skillFunc : SkillSword , skillcoolTime : },
}*/

function InitSkill()
{
	skillInvokeFunc = [
		SkillSword,
		SkillArrow,
		SkillVolleyBall,
		SkillTeleport,
		SkillDash,
		SkillBomb
	];
}
// 스킬을 발동시킵니다.
function InvokeSkill(_invokeInstance, _targetInstance, skill)
{
	skillInvokeFunc[skill](_invokeInstance, _targetInstance);
}

#region 검 스킬
function SkillSword(_invokeInstance, _targetInstance)
{
	var offset = 50;
	// 또 있으면 없앴다가
	var collision_obj = GetCollositionTileObj();
	if(collision_obj == NULL) return ;
	
	var cx = collision_obj.x;
	var cy = collision_obj.y;
	
		// 원형 경계 따라 이동
	var radius = collision_obj.sprite_width / 2;
	var dir = point_direction(cx, cy, _invokeInstance.x, _invokeInstance.y); // 플레이어와 중심 간의 각도 계산
	
	var sword_image_dir = dir - 90;
	_x = cx + lengthdir_x(radius + offset, dir);
	_y = cy + lengthdir_y(radius + offset, dir);
	
	if(instance_exists(obj_sword)) 
	{
		for(var _i = 0; _i < instance_number(obj_sword); _i++)
		{
			var sword_ins = instance_find(obj_sword, _i);
			if(sword_ins.GetInvokePlayer() == _invokeInstance)
			{
				instance_destroy(sword_ins);
			}
		}
	}
	var sword_obj = instance_create_layer(0, 0, "Instances", obj_sword, {image_xscale: 3, image_yscale: 5, depth: 101, image_angle: sword_image_dir});
	sword_obj.CreateSword(collision_obj, dir, _invokeInstance);
}
#endregion

#region 화살 스킬
function SkillArrow(_invokeinstance, _targetInstance)
{
	var arrow_move_dir = _invokeinstance.image_angle;
	if(sign(_invokeinstance.image_xscale) < 0)
	{
		arrow_move_dir += 180;
	}
	
	var arrow_dir = 90 + arrow_move_dir;
	var arrow_instance = instance_create_layer(_invokeinstance.x, _invokeinstance.y, "Instances", obj_arrow,
	{
		image_angle: arrow_dir,
		image_xscale: 2,
		image_yscale: 2,
		direction: arrow_move_dir,
		speed: 20,
	});
	audio_play_sound(sound_arrow, 0, false);
	arrow_instance.invokePlayer = _invokeinstance;
}
#endregion

#region 배구공 스킬
function SkillVolleyBall(_invokeInstance, _targetInstance)
{
	show_debug_message(string(_invokeInstance));
	var collision_obj = GetCollositionTileObj();
	if(collision_obj == NULL) return ;
	
	var volleyball_instance = instance_create_layer(_invokeInstance.x, _invokeInstance.y, "Instances", obj_volleyball);
	
	audio_play_sound(sound_volleyball, 0, false);
	volleyball_instance.invokePlayer = _invokeInstance;
	volleyball_instance.SetCollisionTile(collision_obj);
	volleyball_instance.InitStartDir();
}
#endregion

#region 텔레포트 스킬
function SkillTeleport(_invokeInstance, _targetInstance)
{
	audio_sound_gain(audio_play_sound(sound_teleport, 0 , false), 0.9, 0);
	MoveOpponent();
}
#endregion


#region 대시 스킬
function SkillDash(_invokeInstance, _targetInstance)
{
	audio_sound_set_track_position(audio_play_sound(sound_dash, 0, false), 0.25);
	effect_create_below(ef_smokeup, _invokeInstance.x, _invokeInstance.y, 500, c_orange);
	
	if(GetIsOnGround())
	{
		var collision_obj_tile = GetCollositionTileObj();
		if(collision_obj_tile == NULL) return ;
		// 여기서는 땅바닥에서 대쉬합니다
		if(GetInputLeft())
		{
			MoveLandAlongEdge(-1, 40);
		}
		else if(GetInputRight())
		{
			MoveLandAlongEdge(1, 40);
		}
		else{} // 멈췄을 때
		
	}
	else
	{
		// 여기선 공중에서 대쉬
		if(GetInputLeft())
		{
			MoveHorizontal(-1, 150);
		}
		else if(GetInputRight())
		{
			MoveHorizontal(1, 150);
		}
		else{} // 멈췄을 때
	}
	
}
#endregion

#region 폭탄 스킬
function SkillBomb(_invokeInstance, _targetInstance)
{
	var bomb = instance_create_layer(_invokeInstance.x, _invokeInstance.y, DEFAULT_LAYER, obj_bomb );
	_invokeInstance.ReceiveBomb(bomb);
	bomb.ChangeTarget(_invokeInstance);
}
#endregion