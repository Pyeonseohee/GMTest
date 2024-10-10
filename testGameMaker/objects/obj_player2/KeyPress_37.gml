/// @description Insert description here
// You can write your code in this editor
if(keyboard_check(vk_right) || keyboard_check_pressed(vk_right)) // D키를 누르고 있거나 막 눌렀으면
{
	NoneHorizontalKey();
}
else
{
	DownLeftKey();
}
