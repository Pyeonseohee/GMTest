/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
if(infected)
{
	draw_self();
	DrawBombEffectShader();
	
	_time += 1 / room_speed; // 타이머 업데이트
    //var intensity = clamp(timer / timer_duration, 0, 1);
    
    //shader_set_uniform_f(shader_get_uniform(BombEffect, "u_time"), timer * 10); // 주기 조절
    //shader_set_uniform_f(shader_get_uniform(BombEffect, "u_intensity"), intensity);
    
    if (_time >= timer_duration) { // 폭발!!!!
        RemoveBomb(); // 타이머 리셋
		SparkTheBomb();
    }
}
else
{
	draw_self();
	shader_reset();
}