/// @description Insert description here
// You can write your code in this editor

global.gameManager = self;
application_surface_enable(false);
global.playerCount = 0;
maxRound = 3;
maxScore = 2;
current_round = 0;

is_round_end = false;
is_match_end = false;

global.playerArray = [];
groundArray = [];
groundCount = 0;


player1KeyMap = {
	//ord("A"), ord("D"), ord("W"), ord("C"), ord("V"),  ord("B")
	left: ord("A"),
	right: ord("D"),
	jump: ord("W"),
	skill1: ord("C"),
	skill2: ord("V"),
	skill3: ord("B")
}

player2KeyMap = {
	//vk_left, vk_right, vk_up, ord("I") , ord("O"), ord("P")
	left: vk_left,
	right: vk_right,
	jump: vk_up,
	skill1: ord("I"),
	skill2: ord("O"),
	skill3: ord("P")
}

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
	switch(_mapType)
	{
		case 0:
			groundArray[0] = instance_create_layer(center_x, center_y, "Environments", obj_tile, 
			{image_xscale: 3, image_yscale: 3});
			AddPlayer(center_x, 100, player1KeyMap, "P1");
			AddPlayer(center_x, 100, player2KeyMap, "P2", c_yellow);
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

function AddPlayer(_x, _y, stu_keyMap, _name, _color = c_white)
{
	for(var i = 0; i < groundCount; i++)
	{
		var _ground = groundArray[i];
		var _hei = _ground.sprite_height/2;
		if(_ground.y - _hei * 3 > 0)
		{
			var offset = 10;
			var test_x = _ground.x;
			var test_y = _ground.y - _hei * 3 - offset;
			global.playerArray[global.playerCount] = instance_create_layer(test_x, test_y, DEFAULT_LAYER, obj_player_parent,
			{
				image_xscale: 2,
				image_yscale: 2,
				image_blend: _color,
			});
			global.playerArray[global.playerCount].MatchKey(stu_keyMap);
			global.playerArray[global.playerCount].SetName(_name);
			global.playerCount++;
			break;
		}	
	}
}

function CheckRoundEnd()
{
	var aliveCount = 0;
	var alivePlayer = [];
	
	for(var i = 0; i < global.playerCount; i++)
	{
		if(!global.playerArray[i].IsDead())
		{
			alivePlayer[aliveCount] = global.playerArray[i];
			aliveCount++;
		}
	}
	
	if(aliveCount == 1)
	{
		
		_player = alivePlayer[0];
		
		show_message(string(_player.GetName()) + "가 이겼습니다!!!");
		
		_player.WinRound();
		if(_player.GetScore() >= maxScore) // maxScore에 도달하면 게임이 끝납니다.
		{
			GameEnd();
		}
		else RoundEnd();
	}
}    

function GetTargetEnemy(_instance)
{
	for(var i = 0; i < global.playerCount; i++)
	{
		if(global.playerArray[i].id != _instance.id)
		{
			return global.playerArray[i];
		}
	}
}

function SetSkill(_skill)
{
	
}