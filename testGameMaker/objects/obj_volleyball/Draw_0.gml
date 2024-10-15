/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

draw_set_color(c_red);

// 궤적 그리기
if (array_length(trajectory) > 1) {
    for (var i = 0; i < array_length(trajectory) - 1; i++) {
        var start_point = trajectory[i];
        var end_point = trajectory[i + 1];
        draw_line(start_point[0], start_point[1], end_point[0], end_point[1]); // 선 그리기
    }
}

// 현재 오브젝트 그리기
draw_self(); // 오브젝트 본체도 그리기