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
	DASH = 5,
	BOMB = 6
}

function InitSkill()
{
	var stu_skill_coolTime =
	{
		recreate: INF,
		sword: 3,
		arrow: 5,
		volleyball: 5,
		teleport: 2,
		dash: 3,
		bomb: 10
	};
	
	skillCoolTimeList=
	[
		stu_skill_coolTime.recreate,
		stu_skill_coolTime.sword,
		stu_skill_coolTime.arrow,
		stu_skill_coolTime.volleyball,
		stu_skill_coolTime.teleport,
		stu_skill_coolTime.dash,
		stu_skill_coolTime.bomb,
		stu_skill_coolTime.bomb,
	];
	
	
	skillInvokeFunc = [
		SkillRecreate,
		SkillSword,
		SkillArrow,
		SkillVolleyBall,
		SkillTeleport,
		SkillDash,
		SkillBomb
	];
}

// 스킬의 쿨타임을 반환합니다.
function GetSkillCoolTime(_skill)
{
	return skillCoolTimeList[_skill];
}

// 스킬을 발동시킵니다.
function InvokeSkill(_invokeInstance, _targetInstance, skill)
{
	skillInvokeFunc[skill](_invokeInstance, _targetInstance);
}

#region 부활 스킬
function SkillRecreate(_invokeInstance, _targetInstance)
{
}
#endregion

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
	var sword_obj = instance_create_layer(_x, _y, "Instances", obj_sword, {image_xscale: 3, image_yscale: 5, depth: 101, image_angle: sword_image_dir});
	sword_obj.CreateSword(collision_obj);
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
	arrow_instance.invokePlayer = _invokeinstance;
}
#endregion

#region 배구공 스킬
function SkillVolleyBall(_invokeInstance, _targetInstance)
{
	var collision_obj = GetCollositionTileObj();
	if(collision_obj == NULL) return ;
	
	var volleyball_instance = instance_create_layer(_invokeInstance.x, _invokeInstance.y, "Instances", obj_volleyball);
	
	volleyball_instance.invokePlayer = _invokeInstance;
	volleyball_instance.SetCollisionTile(collision_obj);
}
#endregion

#region 텔레포트 스킬
function SkillTeleport(_invokeInstance, _targetInstance)
{
	MoveOpponent();
}
#endregion


#region 대시 스킬
function SkillDash(_invokeInstance, _targetInstance)
{
	effect_create_below(ef_smokeup, _invokeInstance.x, _invokeInstance.y, 50, c_orange);
	
	if(GetIsOnGround())
	{
		var collision_obj_tile = GetCollositionTileObj();
		if(collision_obj_tile == NULL) return ;
		// 여기서는 땅바닥에서 대쉬합니다
		if(GetInputLeft())
		{
			MoveLandAlongEdge(-1, 30);
		}
		else if(GetInputRight())
		{
			MoveLandAlongEdge(1, 30);
		}
		else{} // 멈췄을 때
		
	}
	else
	{
		// 여기선 공중에서 대쉬
		if(GetInputLeft())
		{
			MoveHorizontal(-1, 120);
		}
		else if(GetInputRight())
		{
			MoveHorizontal(1, 120);
		}
		else{} // 멈췄을 때
	}
	
}
#endregion

#region 폭탄 스킬
function SkillBomb(_invokeInstance, _targetInstance)
{
	_targetInstance.ReceiveBomb();
	var bomb = instance_create_layer(_targetInstance.x, _targetInstance.y, DEFAULT_LAYER, obj_bomb );
	bomb.ChangeTarget(_targetInstance);
}
#endregion