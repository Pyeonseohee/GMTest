/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

offset = 50;
current_timer = 0;
timeout = 10;
targetInstance = NULL;
soundElem = NULL;
image_speed = 0.5;

function GetTargetIns()
{
	return targetInstance;
}

function GetTimeOut()
{
	return timeout;
}

function DecreseTimeOut(_val)
{
	timeout -= _val
}

function ChangeTarget(_target)
{
	targetInstance = _target;
	targetInstance.ReceiveBomb(self);
}

function ShowExplain()
{
	explainElem = AddElement(0, 0, 500, 100)
	with(explainElem)
	{
		SetElementAlignment(self, AL_CENTER);
		with(AddLabel(0, 0, 0, 0, "상대방에게 붙어 폭탄을 떠넘기세요!", self))
		{
			SetLabel(self, c_black, 1, 1, 1, 10, AL_CENTER); // 가운데 중앙정렬
			SetElementFit(self, FIT_FULL);
		}
	}
}

function HideExplain()
{
	if(instance_exists(explainElem))
	{
		with(explainElem)
		{
			SetElementRemove(self);
		}
	}
}

ShowExplain();
sound_clock = audio_sound_gain(audio_play_sound(sound_clock_tick, 0, true), 2.0, 0);