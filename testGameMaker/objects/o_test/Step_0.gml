/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
if (mouse_check_button_pressed(mb_left)) {
    instance_create_layer(mouse_x, mouse_y, "Instances", obj_click_event);
}