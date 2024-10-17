/// @description Insert description here
// You can write your code in this editor

#macro COUNT_DOWN 3
application_surface_enable(false);
global.gameManager = self;
global.playerArray = [];

playerScore = [0, 0];
playerCount = 2;
groundArray = [];
groundCount = 0;
roundScore = [];



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


#region 카운트 다운

current_count_down = COUNT_DOWN;
is_countDown = false;

function StartCountDown()
{
	is_countDown = true;
}


#endregion

#region About 라운드
current_round = 0;
maxRound = 3;
maxScore = 2;


is_round_end = true;
is_game_end = false;


function IsGameEnd()
{
	return (is_round_end || is_game_end);
}

function GameEnd()
{
	is_round_end = true;
	is_game_end = true;
	
	show_message("게임이 끝났습니다!!!!!");
	
	CO_SCOPE = id;
	var _co = CO_BEGIN
	DELAY 2000 THEN
	room_goto(r_Home);
	CO_END
}

function RoundEnd()
{
	var _playerName = global.playerArray[roundScore[current_round]].GetName();
	is_round_end = true;
	
	  
	for(var _i = 0; _i < playerCount; _i++)
	{
		instance_destroy(global.playerArray[_i]);
	}
	global.playerArray = [];
	obj_ingame_ui_manager.ShowGameOver(_playerName);
	
	CO_SCOPE = id;
	var _co = CO_BEGIN
	DELAY 2000 THEN
	obj_ingame_ui_manager.HideGameOver();
	obj_ingame_ui_manager.StartCountDown();
	DELAY 3000 THEN 
	obj_ingame_ui_manager.EndCountDown();
	obj_ingame_ui_manager.ShowGameStart();
	RoundStart();
	DELAY 2000 THEN
	obj_ingame_ui_manager.HideGameStart();
	CO_END
}

function RoundStart()
{
	is_round_end = false;
	current_round++;
	AddPlayer(0, player1KeyMap, "P1");
	AddPlayer(1, player2KeyMap, "P2", c_yellow);
	ResetSkillLeftCoolTime();
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
		roundScore[current_round] = _player.GetIndex();
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
skill_slot_count = 3;
all_skill_coolTime_Array = [
	INF,
	3,
	5,
	5,
	2,
	3,
	10
];

player_left_skill_coolTime = 
[
	[0, 0, 0],
	[0, 0, 0]
];

function GetLeftSkillCoolTime(_playerIdx, _slotNum)
{
	return GetAllPlayerLeftSkillCoolTimeArray()[_playerIdx][_slotNum];
}
function DecreaseLeftSkillCoolTime(_playerIdx, _slotNum, _val)
{
	player_left_skill_coolTime[_playerIdx][_slotNum] -= _val;
	if(player_left_skill_coolTime[_playerIdx][_slotNum] < 0)
	{
		player_left_skill_coolTime[_playerIdx][_slotNum] = 0;
	}
}

function ResetLeftSkillCoolTime(_playerIdx, _slotNum, _skill)
{
	GetAllPlayerLeftSkillCoolTimeArray()[_playerIdx][_slotNum] = obj_ingame_manager.GetSkillDefaultCoolTime(_skill);
}

function ResetSkillLeftCoolTime()
{	
	for(var _i = 0; _i < playerCount; _i++)
	{
		for(var _j = 0; _j < skill_slot_count; _j++)
		{
			GetAllPlayerLeftSkillCoolTimeArray()[_i][_j] = 0;
		}
	}
}

function GetAllPlayerLeftSkillCoolTimeArray()
{
	return player_left_skill_coolTime;
}

function GetSkillDefaultCoolTime(_skill)
{
	return all_skill_coolTime_Array[_skill];
}
#endregion

#region 함수 호출
CreateMap(1);
CO_SCOPE = id;
var _co = CO_BEGIN
ingmae_ui_manager = instance_create_layer(0, 0, DEFAULT_LAYER, obj_ingame_ui_manager);
obj_ingame_ui_manager.StartCountDown();
DELAY 3000 THEN
obj_ingame_ui_manager.EndCountDown();
obj_ingame_ui_manager.ShowGameStart();
RoundStart();
DELAY 2000 THEN
obj_ingame_ui_manager.HideGameStart();
CO_END

#endregion
