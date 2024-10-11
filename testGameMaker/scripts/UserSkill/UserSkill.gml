// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
#macro SKILL_COUNT 5
#macro INF infinity
enum SKILL
{
	RECREATE = 0,
	SWORD = 1,
	ARROW = 2,
	VOLLEYBALL = 3,
	TELEPORT = 4,
}

function InitSkill()
{
	stu_skill =
	{
		recreate: INF,
		sword: 3,
		arrow: 5,
		volleyball: 5,
		teleport: 2
	};
}

function GetSkillCoolTime(_skill)
{
	switch(_skill)
	{
		case SKILL.RECREATE:
			return stu_skill.recreate;
			break;
		case SKILL.SWORD:
			return stu_skill.sword;
			break;
		case SKILL.ARROW:
			return stu_skill.arrow;
			break;
		case SKILL.VOLLEYBALL:
			return stu_skill.volleyball;
			break;
		case SKILL.TELEPORT:
			return stu_skill.teleport;
			break;
		default:
			return NULL; 
			break;
	}
}

function InvokeSkill(_invokeInstance, _targetInstance, skill)
{
	switch(skill)
	{
		case SKILL.RECREATE:
			break;
		case SKILL.SWORD:
			SkillSword(_invokeInstance);
			break;
		case SKILL.ARROW:
			SkillArrow(_invokeInstance);
			break;
		case SKILL.VOLLEYBALL:
			SkillVolleyBall(_invokeInstance);
			break;
		case SKILL.TELEPORT:
			SkillTeleport(_invokeInstance);
			break;
		default:
			show_debug_message("default");
			break;
	}
}

function SkillSword(_instance)
{
	// 또 있으면 없앴다가
	var collision_obj = GetCollositionTileObj();
	if(collision_obj == NULL) return ;
	
	var cx = collision_obj.x;
	var cy = collision_obj.y;
	
		// 원형 경계 따라 이동
	var radius = collision_obj.sprite_width / 2;
	var dir = point_direction(cx, cy, x, y); // 플레이어와 중심 간의 각도 계산
	
	var sword_image_dir = dir - 90;
	
	instance_create_layer(cx, cy, "Instances", obj_sword, {image_xscale: 3, image_yscale: 5, depth: 101, image_angle: sword_image_dir});
}


// 임시
function SkillArrow(_Invokeinstance)
{
	var arrow_move_dir = _Invokeinstance.image_angle;
	if(sign(_Invokeinstance.image_xscale) < 0)
	{
		arrow_move_dir += 180;
	}
	
	//var player_dir = _Invokeinstance.image_angle * sign(_Invokeinstance.image_xscale);
	
	var arrow_dir = 90 + arrow_move_dir;
	var arrow_instance = instance_create_layer(_Invokeinstance.x, _Invokeinstance.y, "Instances", obj_arrow,
	{
		image_angle: arrow_dir,
		image_xscale: 2,
		image_yscale: 2,
		direction: arrow_move_dir,
		speed: 20,
	});
	arrow_instance.invokePlayer = _Invokeinstance;
}

function SkillArrow2(_Invokeinstance, _targetInstance)
{
	var dir = point_direction(_Invokeinstance.x, _Invokeinstance.y, _targetInstance.x, _targetInstance.y);
	var arrow_dir = 90 + dir;
	var arrow_instance = instance_create_layer(_Invokeinstance.x, _Invokeinstance.y, "Instances", obj_arrow,
	{
		image_angle: arrow_dir,
		image_xscale: 2,
		image_yscale: 2,
		direction: dir,
		speed: 20,
	});
	arrow_instance.invokePlayer = _Invokeinstance;
}

function SkillVolleyBall(_instance)
{
	var collision_obj = GetCollositionTileObj();
	if(collision_obj == NULL) return ;
	
	var volleyball_instance = instance_create_layer(_instance.x, _instance.y, "Instances", obj_volleyball);
	
	volleyball_instance.invokePlayer = _instance;
	volleyball_instance.SetCollisionTile(collision_obj);
}

function SkillTeleport(_instance)
{
	MoveOpponent();
}

function SkillRecreate(_instance)
{
	
}
