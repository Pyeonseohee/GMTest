/// @description Insert description here
// You can write your code in this editor

global.gameManager = self;

playerCount = 0;
maxRound = 3;
maxScore = 2;
current_round = 0;

is_round_end = false;
is_match_end = false;

playerArray = [];
groundArray = [];


function IsGameEnd()
{
	return is_match_end;
}

function GameEnd()
{
	RoundEnd();
	is_match_end = true;
	
	show_message("게임이 끝났습니다!!!!!");
}

function RoundEnd()
{
	is_round_end = true;
	show_message("1 라운드가 끝났습니다!!!!!");
}

function RoundStart()
{
	is_round_end = false;
	
	
}

function CreateMap(_mapType)
{
	groundArray = [];
	
	switch(_mapType)
	{
		case 0:
			groundArray[0] = instance_create_layer(center_x, center_y, "Environments", obj_tile, 
			{image_xscale: 3, image_yscale: 3});
			// ord("V"), ord("B"), ord("N")
			AddPlayer(center_x, 100, ord("A"), ord("D"), ord("W"), ord("C"), ord("V"),  ord("B"), "P1");
			AddPlayer(center_x, 100, vk_left, vk_right, vk_up, ord("I") , ord("O"), ord("P"), "P2", c_yellow);
			break;
		case 1:
			groundArray[0] = instance_create_layer(center_x/2 + offset, center_y, "Environments", obj_tile,
			{image_xscale: 3, image_yscale: 3});
		
			groundArray[1] = instance_create_layer(room_width - center_x/2 - offset, center_y, "Environments", obj_tile,
			{image_xscale: 3, image_yscale: 3});
		
			AddPlayer(center_x/2 + offset, 100, ord("A"), ord("D"), ord("W"), ord("C"), ord("V"),  ord("B"), "P1");
			AddPlayer(room_width - center_x/2 - offset, 100, vk_left, vk_right, vk_up, ord("I") , ord("O"), ord("P"), "P2", c_yellow);
			break;
		case 2:
			break;
	}
}

function AddPlayer(_x, _y, _left, _right, _jump, _s1, _s2, _s3, _name, _color = c_white)
{
	playerArray[playerCount] = instance_create_layer(_x, _y, DEFAULT_LAYER, obj_player_parent,
	{
		image_xscale: 2,
		image_yscale: 2,
		image_blend: _color,
	});
	playerArray[playerCount].MatchKey(_left, _right, _jump, _s1, _s2, _s3);
	playerArray[playerCount].SetName(_name);
	playerCount++;
}

function CheckRoundEnd()
{
	var aliveCount = 0;
	var alivePlayer = [];
	
	for(var i = 0; i < playerCount; i++)
	{
		if(!playerArray[i].IsDead())
		{
			alivePlayer[aliveCount] = playerArray[i];
			aliveCount++;
		}
	}
	
	if(aliveCount == 1)
	{
		
		_player = alivePlayer[0];
		
		show_message(string(_player.GetName()) + "가 이겼습니다!!!");
		
		_player.WinRound();
		if(_player.GetScore() >= maxScore)
		{
			GameEnd();
		}
		else RoundEnd();
	}
}

function GetTargetEnemy(_instance)
{
	for(var i = 0; i < playerCount; i++)
	{
		if(playerArray[i].id != _instance.id)
		{
			return playerArray[i];
		}
	}
}