element_parent = null;
element_layer = array_last(obj_UIElement_manager.layerTargetStack);
isfixedDepth = false;

fixed_x = 0;
fixed_y = 0;

goal_x = 0;
goal_y = 0;
goal_width = 0;
goal_height = 0;
goal_opacity = 1;
goal_xscale = 1;
goal_yscale = 1;

origin_x = 0; // 부모 위치 기준
origin_y = 0;
isPositionRatio = false; // 위치값이 부모 오브젝트에 대한 비율을 기준으로 작동할

element_width = 0; // 기본 너비
element_height = 0;
	
opacity = 1;
total_opacity = 1;
	
element_xscale = 1; // 기본 스케일
element_yscale = 1;
total_xscale = 1; // 부모 스케일*자신
total_yscale = 1;
	
total_width = 0;
total_height = 0;


fit_width = 0;
fit_height = 0;
alignment = 0;

scale_rate = 0;
position_rate = 0;
opacity_rate = 0;
	
drawer = function(){}
	
child = array_create(0);

isAdjusted = false; // 위치 조정되었는지 여부

isSurfaceField = false;
element_surface = -1;

deleteAction = pointer_null; // 삭제될 때 실행할 함수