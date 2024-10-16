/// @description Insert description here
// You can write your code in this editor
application_surface_enable(false);
global.gameManager = self;
global.playerArray = [];

playerLeftCoolTimeArray = [];

playerScore = [0, 0];
playerCount = 2;
groundArray = [];
groundCount = 0;

#region 키 맵핑 정의
player1KeyMap = {
	left: ord("A"),
	right: ord("D"),
	jump: ord("W"),
	drop: ord("S"),
	skill1: ord("C"),
	skill2: ord("V"),
	skill3: ord("B")
}

player2KeyMap = {
	left: vk_left,
	right: vk_right,
	jump: vk_up,
	drop: vk_down,
	skill1: ord("I"),
	skill2: ord("O"),
	skill3: ord("P")
}
#endregion

#region About 라운드
current_round = 0;
maxRound = 3;
maxScore = 2;


is_round_end = true;
is_match_end = false;

function IsGameEnd()
{
	return (is_round_end || is_match_end);
}

function GameEnd()
{
	is_round_end = true;
	is_match_end = true;
	
	show_message("게임이 끝났습니다!!!!!");
}

function RoundEnd()
{
	is_round_end = true;
	for(var _i = 0; _i < playerCount; _i++)
	{
		instance_destroy(global.playerArray[_i]);
	}
	global.playerArray = [];
	
	CO_SCOPE = id;
	var _co = CO_BEGIN
	DELAY 3000 THEN
	RoundStart();
	CO_END
}

function RoundStart()
{
	CO_SCOPE = id;
	var _co = CO_BEGIN
	DELAY 3000 THEN
	show_message("시작!");
	is_round_end = false;
	current_round++;
	CO_END
	AddPlayer(0, player1KeyMap, "P1");
	AddPlayer(1, player2KeyMap, "P2", c_yellow);
}

function CheckRoundEnd()
{
	var aliveCount = 0;
	var alivePlayer = [];
	
	for(var i = 0; i < playerCount; i++)
	{
		if(!global.playerArray[i].IsDead())
		{
			alivePlayer[aliveCount] = global.playerArray[i];
			aliveCount++;
		}
	}
	
	if(aliveCount == 1)
	{
		var _player = alivePlayer[0];
		playerScore[_player.GetIndex()]++;
		if(playerScore[_player.GetIndex()] >= maxScore) // maxScore에 도달하면 게임이 끝납니다.
		{
			GameEnd();
		}
		else RoundEnd();
	}
}    

#endregion


function CreateMap(_mapType)
{	
	switch(_mapType)
	{
		case 0:
			break;
		case 1:
			groundArray[0] = instance_create_layer(0, 0, "Environments", obj_tile,
			{image_xscale: 3, image_yscale: 3});
			groundArray[0].SetInitPos(0);
			groundCount++;
			
			
			groundArray[1] = instance_create_layer(0, 0, "Environments", obj_tile,
			{image_xscale: 3, image_yscale: 3});
			groundArray[1].SetInitPos(pi/2);
			groundCount++;
			
			groundArray[2] = instance_create_layer(0, 0, "Environments", obj_tile,
			{image_xscale: 3, image_yscale: 3});
			groundArray[2].SetInitPos(pi);
			groundCount++;
		
			groundArray[3] = instance_create_layer(0, 0,  "Environments", obj_tile,
			{image_xscale: 3, image_yscale: 3});
			groundArray[3].SetInitPos(3*pi/2);
			groundCount++;
			break;
		case 2:
			break;
	}
}

function AddPlayer(_idx, stu_keyMap, _name, _color = c_white)
{
	for(var _i = 0; _i < groundCount; _i++)
	{
		var _ground = groundArray[_i];
		var _hei = _ground.sprite_height/2;
		if(_ground.y - _hei * 3 > 0)
		{
			var offset = 10;
			var test_x = _ground.x;
			var test_y = _ground.y - _hei * 3 - offset;
			global.playerArray[_idx] = instance_create_layer(test_x, test_y, DEFAULT_LAYER, obj_player_parent,
			{
				image_xscale: 2,
				image_yscale: 2,
				image_blend: _color,
			});
			global.playerArray[_idx].MatchKey(stu_keyMap);
			global.playerArray[_idx].SetIndex(_idx);
			global.playerArray[_idx].SetName(_name);
			global.playerArray[_idx].InitSkill(global.all_skill[_idx]);
			break;
		}	
	}
}

function GetTargetEnemy(_ins)
{
	for(var _i = 0; _i < playerCount; _i++)
	{
		if(global.playerArray[_i].id != _ins.id)
		{
			return global.playerArray[_i];
		}
	}
}

#region 스킬 관련
all_skill_coolTime_List = [
	INF,
	3,
	5,
	5,
	2,
	3,
	10
];

function GetSkillCoolTime(_skill)
{
	return all_skill_coolTime_List[_skill];
}

function GetAllPlayerAllSkillCoolTimeArray()
{
	playerLeftCoolTimeArray = [];
	for(var _i = 0; _i < playerCount; _i++)
	{
		playerLeftCoolTimeArray[_i] = global.playerArray[_i].GetLeftAllSkillCoolTime();
	}
	return playerLeftCoolTimeArray;
}
#endregion

#region 함수 호출
CreateMap(1);
RoundStart();
instance_create_layer(0, 0, DEFAULT_LAYER, obj_ingame_ui_manager);
#endregion
