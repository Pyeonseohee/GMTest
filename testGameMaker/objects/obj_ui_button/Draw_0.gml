/// @description Insert description here
// You can write your code in this editor

draw_self(); // 자신의 스프라이트 먼저 그려줍니다.

// 텍스트 중앙 정렬을 위한 계산
var text_width = string_width(text);
var text_height = string_height(text);

// 버튼 스프라이트의 중심 좌표 계산 (스프라이트의 원점이 중앙일 경우)
var center_x = x;
var center_y = y;

//draw_set_font(fnt_button); // 미리 설정한 폰트 사용
draw_set_font(global.new_font);
draw_set_halign(fa_center); // 수평 중앙 정렬
draw_set_valign(fa_middle); // 수직 중앙 정렬
draw_set_color(c_black); // 텍스트 색상 설정

// 텍스트 그리기
draw_text(center_x, center_y, text);