/// @description Insert description here
// You can write your code in this editor

if(keyboard_check(ord("A")) || keyboard_check_pressed(ord("A"))) // D키를 누르고 있거나 막 눌렀으면
{
	NoneHorizontalKey();
}
else
{
	DownRightKey();
}