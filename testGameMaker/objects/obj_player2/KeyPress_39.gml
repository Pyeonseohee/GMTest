/// @description Insert description here
// You can write your code in this editor
if(keyboard_check(vk_left) || keyboard_check_pressed(vk_left)) // D키를 누르고 있거나 막 눌렀으면
{
	NoneHorizontalKey();
}
else
{
	DownRightKey();
}