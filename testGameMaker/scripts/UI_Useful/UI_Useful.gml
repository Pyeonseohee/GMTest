function draw_line_sprite(x1,y1,x2,y2,color = c_white, alpha, width = 1) {
	var _len = point_distance(x1,y1,x2,y2);
	var _dir = point_direction(x1,y1,x2,y2);
	draw_sprite_ext(sp_square_16_16,0,(x2+x1)/2,(y2+y1)/2, _len/16, width/16, _dir, color, alpha);
}

function isOutOfArea(x1,y1,x2,y2, p_x1,p_y1,p_x2,p_y2) {
	if (x1 > p_x2 || x2 < p_x1)
		return true;
	if (y1 > p_y2 || y2 < p_y1)
		return true;
	return false;
}
function isAreaIntruded(x1,y1,x2,y2, p_x1,p_y1,p_x2,p_y2) {
	if (x1 < p_x2 || x2 > p_x1)
		return true;
	if (y1 < p_y2 || y2 > p_y1)
		return true;
	return false;
}

function isOutOfScreen(x1,y1,x2,y2) {
	return isOutOfArea(x1,y1,x2,y2, 0,0,global.DisplayDefaultWidth, global.DisplayDefaultHeight);
}

function SimpleLerp(start, goal, rate, clampRate = 0.00015*rate) { // (많이 쓰던 그거)
	if (start == goal || abs(goal-start) > clampRate)
		return start + (goal-start)/rate;
	else
		return goal;
}

function getRankString(_rank) {
	switch (_rank) {
		case 0 :
			return "D-";
		case 1 :
			return "D";
		case 2 :
			return "D+";
		case 3 :
			return "C-";
		case 4 :
			return "C";
		case 5 :
			return "C+";
		case 6 :
			return "B-";
		case 7 :
			return "B";
		case 8 :
			return "B+";
		case 9 :
			return "A-";
		case 10 :
			return "A";
		case 11 :
			return "A+";
		case 12 :
			return "S-";
		case 13 :
			return "S";
		case 14 :
			return "S+";
		default :
			return "?"
	}
}
function getRankNumber(_rank) {
	switch (_rank) {
		case RANK_D :
			return RANK_D_NUMBER;
		case RANK_DP :
			return RANK_DP_NUMBER;
		case RANK_CM :
			return RANK_CM_NUMBER;
		case RANK_C :
			return RANK_C_NUMBER;
		case RANK_CP :
			return RANK_CP_NUMBER;
		case RANK_BM :
			return RANK_BM_NUMBER;
		case RANK_B :
			return RANK_B_NUMBER;
		case RANK_BP :
			return RANK_BP_NUMBER;
		case RANK_AM :
			return RANK_AM_NUMBER;
		case RANK_A :
			return RANK_A_NUMBER
		case RANK_AP :
			return RANK_AP_NUMBER;
		case "S-" :
			return RANK_SM_NUMBER;
		case RANK_S :
			return RANK_S_NUMBER;
		case RANK_SP :
			return RANK_SP_NUMBER;
		default :
			return 0
	}
}
function getRankReleaseTable(_rank) {
	switch (_rank) {
		case RANK_D_NUMBER :
			return 33;
		case RANK_DP_NUMBER :
			return 33;
		case RANK_CM_NUMBER :
			return 32;
		case RANK_C_NUMBER :
			return 32;
		case RANK_CP_NUMBER :
			return 32;
		case RANK_BM_NUMBER :
			return 31;
		case RANK_B_NUMBER :
			return 31;
		case RANK_BP_NUMBER :
			return 30;
		case RANK_AM_NUMBER :
			return 29;
		case RANK_A_NUMBER :
			return 48
		case RANK_AP_NUMBER :
			return 28;
		case RANK_SM_NUMBER :
			return 27;
		case RANK_S_NUMBER :
			return 26;
		case RANK_SP_NUMBER :
			return 25;
		default :
			return 33
	}
}

function DrawRank(_rank, _x, _y,_xscale, _yscale, _alpha) {
	var _index = _rank >= 14? 5 : _rank div 3;
	draw_textFrame(getRankString(_rank)
					,_x - 22 * _xscale
					,_y - 32 * _yscale
					,_x + 22 * _xscale
					,_y + 32 * _yscale
					, c_white, _xscale*0.4, _yscale*0.4, _alpha*0.7,OVERFLOW_FIT,  0, AL_CENTER,font_NotoSansKR_SemiBold64); // 이름 드로우
}
	
function DrawGraph(x1,y1,x2,y2, rate, roundness = 0, color1 = c_white, color2 = c_gray, alpha1 = 1, alpha2 = 1) {
	rate = median(rate, 0, 1);
	if (roundness == 0) {
		draw_set_color(color2);
		draw_set_alpha(alpha2);
		draw_rectangle(x1,y1,x2,y2,0);
		draw_set_color(color1);
		draw_set_alpha(alpha1);
		draw_rectangle(x1,y1,x1+(x2-x1)*rate,y2,0);
	}
	else {
		draw_frame_12rounded(x1,y1,x2,y2,alpha2,color2,roundness/12);
		draw_frame_12rounded(x1,y1,x1+(x2-x1)*rate,y2,alpha1,color1,roundness/12);
	}
}
function DrawGraphDetail(x1,y1,x2,y2, _max, value, checkRange, roundness = 0, color1 = c_white, color2 = c_gray, alpha1 = 1, alpha2 = 1) {
	var rate = value/_max;
	
	if (roundness == 0) {
		draw_set_color(color2);
		draw_set_alpha(alpha2);
		draw_rectangle(x1,y1,x2,y2,0);
		draw_set_color(color1);
		draw_set_alpha(alpha1);
		draw_rectangle(x1,y1,x1+(x2-x1)*rate,y2,0);
	}
	else {
		draw_frame_12rounded(x1,y1,x2,y2,alpha2,color2,roundness/12);
		draw_frame_12rounded(x1,y1,x1+(x2-x1)*rate,y2,alpha1,color1,roundness/12);
	}
	
	if (checkRange == 0) {
		return
	}
	var od = true;
	for (var i = checkRange; i < _max; i += checkRange) {
		od = !od;
		if (od) continue;
		var _xx = (i/_max)*(x2-x1);
		draw_set_alpha(alpha2*0.35);
		draw_set_color(c_black);
		draw_rectangle(x1+_xx,y1,x1+checkRange*((x2-x1)/_max)+_xx,y2-1,0);
	}
}
function DrawGraphGlow(x1,y1,x2,y2, _max, value, checkRange, roundness = 0, color1 = c_white, color2 = c_gray, alpha1 = 1, alpha2 = 1) {
	var rate = value/_max;
	
	draw_frame_12rounded(x1,y1,x1+(x2-x1)*rate,y2,alpha1,color1,roundness/12)
	
	var od = true;
	for (var i = checkRange; i < _max; i += checkRange) {
		od = !od;
		if (od) continue;
		var _xx = (i/_max)*(x2-x1);
		draw_set_alpha(alpha2*0.75);
		draw_set_color(c_black);
		draw_rectangle(x1+_xx,y1,x1+checkRange*((x2-x1)/_max)+_xx,y2-1,0);
	}
	
	if (roundness == 0) {
		draw_set_color(color2);
		draw_set_alpha(alpha2);
		draw_rectangle(x1,y1,x2,y2,0);
		draw_set_color(c_white);
		draw_set_alpha(alpha1*0.6);
		gpu_set_blendmode(bm_add);
		draw_rectangle(x1,y1,x1+(x2-x1)*rate,y2,0);
		gpu_set_blendmode(bm_normal);
	}
	else {
		draw_frame_12rounded(x1,y1,x2,y2,alpha2*0.9,color2,roundness/12);
		//gpu_set_blendmode(bm_add);
		//draw_frame_12rounded(x1,y1,x2,y2,alpha2*0.05,color2,roundness/12);
		//draw_frame_12rounded(x1,y1,x1+(x2-x1)*rate,y2,alpha1*0.75,c_white,roundness/12);
		//gpu_set_blendmode(bm_normal);
	}
}

function GetNotchArea() {
	return 0;
}