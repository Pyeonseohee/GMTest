/// @description Insert description here
// You can write your code in this editor

if(audio_is_playing(sound_main)) return ;
audio_sound_gain(audio_play_sound(sound_main, 0 , true), 0.3, 0);
