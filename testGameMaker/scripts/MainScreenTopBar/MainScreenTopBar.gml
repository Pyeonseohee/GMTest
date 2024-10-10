// v2.3.0에 대한 스크립트 어셋 변경됨 자세한 정보는
// https://help.yoyogames.com/hc/en-us/articles/360005277377 참조
function AddTopBar() {
	var _notchSize = GetNotchArea();
	var profileAreaWidth = 1000;
	var tabButtonWidth = 250;
	tabNow = 0;
	
	topBar = AddElement(0,0,0,255);
	topBar.position_rate = 4;
	SetElementFit(topBar, FIT_HORIZONTAL);
	SetElementDrawer(topBar, DRAWER{
		draw_set_color(make_color_rgb(35,35,35));
		draw_set_alpha(0.85);
		draw_rectangle(_x1,_y1,_x2,_y2,0);
	});
	topBarLine = AddElement(0,255,0,5,topBar);
	SetElementFit(topBarLine, FIT_HORIZONTAL);
	SetElementDrawer(topBarLine, DRAWER{
		draw_set_color(make_color_rgb(35,35,35));
		draw_set_alpha(0.3);
		draw_rectangle(_x1,_y1,_x2,_y2,0);
	});
	tabLine = AddElement(profileAreaWidth+50,0,tabButtonWidth,0,topBarLine);
	SetElementFit(tabLine, FIT_VERTICAL);	
	tabLine.position_rate = 2;
	tabLine.opacity_rate = 4;
	SetElementDrawer(tabLine, DRAWER{
		draw_frame_glow1(_x1,_y1,_x2,_y2, 0.5*_alpha, COLOR_JS_ORANGE,1.5);
		gpu_set_blendmode(bm_add);
		draw_frame_glow1(_x1,_y1,_x2,_y2, _alpha, COLOR_JS_LTGOLD,0.05);
		gpu_set_blendmode(bm_normal);
		draw_set_alpha(0.35*_alpha);
		draw_set_color(COLOR_JS_LTGOLD);
		draw_rectangle(_x1,_y1,_x2,_y2,0);
	});
	SetElementFixDepth(tabLine);
	
	pageTitleField = AddElement(0,260,0,90, topBar);
	pageTitleField.scale_rate = 3.5;
	pageTitleField.opacity_rate = 2;
	SetElementAlignment(pageTitleField , AL_LEFTTOP);
	SetElementFit(pageTitleField , FIT_HORIZONTAL);
	
	settingButton = AddButton(-125-_notchSize,0,180,180,topBar);
	settingButton.position_rate = 4;
	SetElementAlignment(settingButton, AL_RIGHTDOWN);
	SetElementDrawer(settingButton, DRAWER{
		draw_sprite_ext(sp_icon_setting_01, 0, (_x1 + _x2)/2, (_y1 + _y2)/2, element_xscale*0.5, element_yscale*0.5,0,c_white, _alpha);
	});
	SetButtonCallback(settingButton, CALLBACK{
		obj_MainScreen_manager.UpdateTab(5);
	});
	UILIb_button_scaleAnimation(settingButton, 0.2, 0.3);
	
	/*
	mailButton = AddButton(-125-_notchSize,50,100,100,topBar);
	mailButton.position_rate = 4;
	SetElementAlignment(mailButton, AL_RIGHTCENTER);
	SetElementDrawer(mailButton, DRAWER{
		draw_sprite_ext(sp_icon_message_01, 0, (_x1 + _x2)/2, (_y1 + _y2)/2,  element_xscale*0.5,  element_yscale*0.5,0,c_white, _alpha);
	});
	SetButtonCallback(mailButton, CALLBACK{
		obj_MainScreen_manager.UpdateTab(6);
	});
	mailButton.scale_rate = 2;
	UILIb_button_scaleAnimation(mailButton, 0.2, 0.3);*/
	//SetButtonReleaseCallback(messageButton, CALLBACK {  _e.goal_xscale = 1;  _e.goal_yscale = 1;  _e.goal_opacity = 1;});
	
	
	
	// 프로필 영역
	profileArea = AddElement(0,0,profileAreaWidth+_notchSize,0, topBar);
	SetElementFit(profileArea, FIT_VERTICAL);
	SetElementDrawer(profileArea, DRAWER{
		draw_set_color(c_black);
		draw_set_alpha(0.3);
		draw_rectangle(_x1,_y1,_x2,_y2,0);
	});
	
	profile = AddElement(25+100+_notchSize,0,780,200, profileArea);
	SetElementAlignment(profile, AL_LEFTDOWN)
	
	var _totalTier = global.tier div 3; // 3단위로 나누기.
	
	var _tierColor = GetTierColor(global.tier);
	
	
	profileIcon = AddButton(0,0,180,120, profile);
	SetButtonCallback(profileIcon, CALLBACK {
		with (obj_MainScreen_manager) {
			UpdateTab(3);
		}
	});
	profileIcon.tierColor = _tierColor;
	profileIcon.tierIndex = _totalTier;
	profileIcon.position_rate = 4;
	profileIcon.opacity_rate = 4;
	SetElementDrawer(profileIcon, DRAWER{
		draw_set_color(c_ltgray);
		draw_set_alpha(0.1*_alpha);
		draw_rectangle(_x1,_y1, _x2, _y2, 0);
		draw_sprite_ext(sp_icon_tiers_01, tierIndex, (_x1+_x2)/2, (_y1+_y2)/2, _xscale*1.1, _yscale*1.1, 0, tierColor,_alpha);
		draw_set_color(tierColor);
		draw_set_alpha(_alpha);
		draw_rectangle(_x1,_y1, _x1+5, _y2, 0);
	});
	UILIb_button_scaleAnimation(profileIcon, 0.02);
	
	profileLabelField = AddButton(180+25,0,50+50+30, 120, profile);
	SetButtonCallback(profileLabelField, CALLBACK {
		with (obj_MainScreen_manager) {
			UpdateTab(5);
		}
	});
	profileLabelField.position_rate = 4;
	profileLabelField.opacity_rate = 4;
	SetElementAlignment(profileLabelField, AL_LEFTTOP);
	SetElementFit(profileLabelField, FIT_HORIZONTAL);
	UILIb_button_scaleAnimation(profileLabelField, 0.02);
	
	profileNameLabel = AddLabel(0,0, 0, 70, NAME_LANG(global.team_name), profileLabelField);
	SetElementFit(profileNameLabel, FIT_HORIZONTAL);
	
	var tierName = GetTierName(global.tier);
	
	SetLabel(profileNameLabel, c_white, 1.2, 1.2, 1, 0, AL_LEFTTOP);
	profileTitleLabel = AddLabel(2, 56, 0, 64, tierName, profileLabelField);
	SetElementFit(profileTitleLabel, FIT_HORIZONTAL);
	SetLabel(profileTitleLabel, _tierColor, 0.9, 0.9, 1, 0, AL_LEFTTOP, global.FontDefault, true);
	
	profileGraph = AddElement(0,-1,0,5, profileLabelField);
	SetElementAlignment(profileGraph ,AL_LEFTDOWN);
	SetElementFit(profileGraph ,FIT_HORIZONTAL);
	SetElementDrawer(profileGraph, DRAWER{
		var _nowStat = (global.tierPoint - (global.tier != 0 ? GetTierPointMax(global.tier - 1) : 0));
		var _maxStat = (GetTierPointMax(global.tier) - (global.tier != 0 ? GetTierPointMax(global.tier - 1) : 0));
		
		var _graph =  _nowStat / _maxStat;
		if (_graph < 0) _graph = 0;
		if (_graph > 1) _graph = 1;
		DrawGraph(_x1,_y1,_x2,_y2, _graph,0,COLOR_JS_ORANGE,c_ltgray,1*_alpha,0.15*_alpha);
	});
	
	
	var _currencyFieldWidth = 300;
	
	currencyArea = AddButton(0,0,_currencyFieldWidth*3-50, 80, profile);
	SetButtonCallback(currencyArea, CALLBACK {
		with (obj_MainScreen_manager) {
			r_change(r_NormalShopScreen);
			global.GlobalShopScreenTabData.room = r_NormalShopScreen
			global.GlobalShopScreenTabData.tab = 0;	
		}
	});
	SetElementAlignment(currencyArea, AL_LEFTDOWN);
	UILIb_button_scaleAnimation(currencyArea, 0.02);
	
	currencyField1 = AddElement(0,0,_currencyFieldWidth, 80, currencyArea);
	SetElementAlignment(currencyField1, AL_LEFTDOWN);
	currencyField1.icon = AddElement(0,0,80,80,currencyField1);
	currencyField1.icon.iconSpr = sp_icon_currencyCoin;
	SetElementDrawer(currencyField1.icon, DRAWER{
		draw_set_color(c_ltgray);
		draw_set_alpha(0.2);
		draw_rectangle(_x1,_y1, _x1+5, _y2, 0);
		
		draw_sprite_ext(iconSpr, 0,(_x1+_x2)/2, (_y1+_y2)/2, _xscale*0.45, _yscale*0.45, 0, c_white, _alpha);
	});
	currencyField1.label = AddLabel(0,0,80,80, format_currency(global.credit),currencyField1);
	SetElementAlignment(currencyField1.label, AL_RIGHTTOP);
	SetElementFit(currencyField1.label, FIT_HORIZONTAL);
	SetLabel(currencyField1.label, c_white, 0.35, 0.35, 0.85, 0, AL_LEFTCENTER, font_NotoSansKR_SemiBold64);
	
	currencyField3 = AddElement(_currencyFieldWidth,0,_currencyFieldWidth, 80, currencyArea);
	SetElementAlignment(currencyField3, AL_LEFTDOWN);
	currencyField3.icon = AddElement(0,0,80,80,currencyField3);
	currencyField3.icon.iconSpr = sp_icon_currencyEXP;
	SetElementDrawer(currencyField3.icon, DRAWER{
		draw_sprite_ext(iconSpr, 0,(_x1+_x2)/2, (_y1+_y2)/2, _xscale*0.45, _yscale*0.45, 0, c_white, _alpha);
	});
	currencyField3.label = AddLabel(0,0,80,80, format_currency(global.expPoint),currencyField3);
	SetElementAlignment(currencyField3.label, AL_RIGHTTOP);
	SetElementFit(currencyField3.label, FIT_HORIZONTAL);
	SetLabel(currencyField3.label, c_white, 0.35, 0.35, 0.85, 0, AL_LEFTCENTER, font_NotoSansKR_SemiBold64);
	
	currencyField2 = AddElement(_currencyFieldWidth*2,0,_currencyFieldWidth-20, 80, currencyArea);
	SetElementAlignment(currencyField2, AL_LEFTDOWN);
	currencyField2.icon = AddElement(0,0,80,80,currencyField2);
	currencyField2.icon.iconSpr = sp_icon_currencyVolleyball;
	SetElementDrawer(currencyField2.icon, DRAWER{
		draw_sprite_ext(iconSpr, 0,(_x1+_x2)/2, (_y1+_y2)/2, _xscale*0.45, _yscale*0.45, 0, c_white, _alpha);
	});
	currencyField2.label = AddLabel(0,0,80,80, format_currency(global.vPoint),currencyField2);
	SetElementAlignment(currencyField2.label, AL_RIGHTTOP);
	SetElementFit(currencyField2.label, FIT_HORIZONTAL);
	SetLabel(currencyField2.label, c_white, 0.35, 0.35, 0.85, 0, AL_LEFTCENTER, font_NotoSansKR_SemiBold64);
	
	var _oo = [currencyField1,currencyField2,currencyField3];
	for (var i = 0; i < 3; i ++) {
		with (AddElement(0, 0, 80, 0, _oo[i])) {
			SetElementAlignment(self, AL_RIGHTTOP);
			SetElementFit(self, FIT_VERTICAL);
			SetElementDrawer(self, DRAWER {
				draw_sprite_ext(sp_icon_plus_03, 0,  (_x1+_x2)/2, (_y1+_y2)/2, _xscale*.45, _yscale*.45, 0,COLOR_JS_LTGOLD,_alpha*0.9);
			});
		}
	}
	
	
	// 탭 버튼들
	topBarTabButtonField = AddElement(_notchSize+profileAreaWidth+50,0, profileAreaWidth, 00, topBar);
	SetElementFit(topBarTabButtonField, FIT_FULL);
	
	tabButton = array_create(0);
	var _tabButtonHeight = 350;
	
	var _tabButtonIcons = [sp_icon_home_01, sp_icon_ball_01, sp_icon_shop_01, sp_icon_star_01, sp_icon_people_01];
	var _tabButtonTexts = [LANG("COMMON/HOME"), LANG("COMMON/GAME"), LANG("COMMON/SHOP"), LANG("INGAME/CHALLENGE"), LANG("COMMON/PLAYER_MANAGEMENT")]; // 홈 경기 상점 도전과제 선수관리 //*LANGUAGE_APPLIED
	for (var i = 0; i < 5; i ++) {
		tabButton[i] = AddButton(tabButtonWidth*i,0, tabButtonWidth, _tabButtonHeight, topBarTabButtonField);
		with (tabButton[i]) {
			SetElementAlignment(self, AL_LEFTDOWN);
			SetElementDrawer(self, DRAWER{
				_animationOffset = SimpleLerp(_animationOffset, _animationOffsetGoal, 2);
				draw_sprite_ext(__spr, 0, (_x1 + _x2)/2, _y2 - element_yscale*100,  element_xscale*0.6*_animationOffset, element_yscale*0.6*_animationOffset,0, var1, _alpha*_animationOffset);
				draw_set_halign(fa_middle);
				draw_set_valign(fa_center);
				draw_set_alpha(_alpha*_animationOffset);
				draw_set_color(var1)
				draw_set_font(global.FontDefault);
				draw_text_transformed((_x1 + _x2)/2, _y2 - element_yscale*30,__str, element_xscale*0.9, element_yscale*0.9, 0);
			}, {__spr : _tabButtonIcons[i], __str : _tabButtonTexts[i]});
			var1 = c_white;
			
			_animationOffset = 1;
			_animationOffsetGoal = 1;
			SetButtonSFX_default(self);
			SetButtonFocusCallback(self, CALLBACK {_animationOffsetGoal = 1.2});
			SetButtonLeaveCallback(self, CALLBACK {_animationOffsetGoal = 1});
			SetButtonClickCallback(self, CALLBACK {_animationOffsetGoal = 0.8});
		}
	}
	SetButtonCallback(tabButton[0], CALLBACK {obj_MainScreen_manager.UpdateTab(0);});
	SetButtonCallback(tabButton[1], CALLBACK {obj_MainScreen_manager.UpdateTab(1); });
	SetButtonCallback(tabButton[2], CALLBACK { obj_MainScreen_manager.UpdateTab(2); });
	SetButtonCallback(tabButton[3], CALLBACK { obj_MainScreen_manager.UpdateTab(3); });
	SetButtonCallback(tabButton[4], CALLBACK { obj_MainScreen_manager.UpdateTab(4); });
	
	//////////////////////////////// PAGE
	
	pageField = AddElement(120+_notchSize,350, 120+120+_notchSize*2, 350+50);
	pageField.scale_rate = 4;
	pageField.position_rate = 4;
	SetElementFit(pageField, FIT_FULL);
	
	function UpdateTab(tab, onlyTab = false) {
		if (tab == tabNow && tab != 0)
			return;
		
		global.MainScreenPageData.tab = tab;
		if (tabNow == 5) { // 5 : 설정
			with (obj_page_setting) {
				if (isVariableChanged()) {
					applyVariables();
					global.UserDataManager.SetUserSetting_async(function(){});
					system.SaveLocalSetting(); //System에 저장.
				}
			}
		}
		
		tabNow = tab;
		
		for (var i = 0; i < array_length(tabButton); i ++) {
			tabButton[i].var1 = c_white;
			SetElementClear(tabButton[i]);
		}
		
		if (tab < array_length(tabButton)) {
			tabLine.goal_opacity = 1;
			tabLine.goal_x = profileArea.element_width + 50 + 250*tab;
			tabButton[tab].var1 = make_color_rgb(255, 222, 128)
			var gradation = AddElement(0,0,0,0,tabButton[tab]);
			SetElementFixDepth(gradation);
			SetElementFit(gradation, FIT_FULL);
			gradation.opacity = 1;
			gradation.goal_opacity = 0;
			gradation.opacity_rate = 3;
			SetElementDrawer(gradation, DRAWER{
				gpu_set_blendmode(bm_add);
				if (_alpha > 0.01) {
					for ( var i = 0; i < 5; i++ )
						draw_sprite_ext(sp_smoothGradation, 0, (_x1+_x2)/2, _y2, 1.3, (1+i*0.4),0,make_color_rgb(244,155,86), _alpha);
				}
				draw_sprite_ext(sp_smoothGradation, 0, (_x1+_x2)/2, _y2, 1.3, 1,0,make_color_rgb(244,155,86), 0.8);
				gpu_set_blendmode(bm_normal);
			});
		}
		else {
			tabLine.goal_opacity = 0;
		}
	
		
		if (!onlyTab) {
			switch(tab) {
				case 0:
					UpdatePage(obj_page_home);
					break;
				case 1:
					UpdatePage(obj_page_play);
					break;
				case 2:
					UpdatePage(obj_page_store);
					break;
				case 3:
					UpdatePage(obj_page_achievement);
					break;
				case 4:
					UpdatePageLate(obj_page_player);
					break;
				case 5:
					UpdatePage(obj_page_setting);
					break;
				/*case 6:
					UpdatePage(obj_page_mail);
					break;*/
			}
		}
		/*
		CO_SCOPE = id;
		CO_PARAMS.tab = tab;
		var _minimizeTopBar = CO_BEGIN
			if (CO_LOCAL.tab == 4 or CO_LOCAL.tab == 1 or CO_LOCAL.tab == 2) {
				obj_MainScreen_manager.MinimizeTopBar();
			}
			else {
				obj_MainScreen_manager.MaximizeTopBar();   
			}
		CO_END*/
	}
}

function UpdateTopBar() {
	if (!instance_exists(obj_MainScreen_manager)) return;
	with (obj_MainScreen_manager) {
		SetLabelText(profileNameLabel,NAME_LANG(global.team_name));
		var currencyFields = [ currencyField1, currencyField2, currencyField3 ];
		for(var i = 0; i < 3; i ++) {
			var newText = "???";
			switch (currencyFields[i].icon.iconSpr) {
				case sp_icon_currencyCoin:
					newText = format_currency(global.credit);
					break;
				case sp_icon_currencyVolleyball:
					newText = format_currency(global.vPoint);
					break;
				case sp_icon_currencyEXP:
					newText = format_currency(global.expPoint);
					break;
				case sp_icon_currencyBlueFlame:
					newText = format_currency(global.blueFlame);
					break;
				case sp_icon_currencyPeakPoint:
					newText = format_currency(global.ShopManager.peakPoint);
					break;
				case sp_icon_currencyDragonBall:
					newText = format_currency(global.ShopManager.masterCoin);
					break;
				case sp_icon_currencyEventPeakPoint:
					newText = format_currency(global.ShopManager.eventPeakPoint);
					break;
			}
			SetLabelText(currencyFields[i].label,newText);
		}
		
		var _totalTier = (global.tier div 3)*3; // 3단위로 나누기.
		var _tierColor;
		switch(_totalTier) {
			default : _tierColor = c_white;
			case TIER_BRONZE : _tierColor = COLOR_TIER_BRONZE break;
			case TIER_SILVER : _tierColor = COLOR_TIER_SILVER break;
			case TIER_GOLD   : _tierColor = COLOR_TIER_GOLD break;
				case TIER_DIAMOND: _tierColor = COLOR_TIER_DIAMOND break;
			case TIER_MASTER : _tierColor = COLOR_TIER_MASTER break;
			case TIER_WORLD : _tierColor = COLOR_TIER_WORLD break;
		}
	
	
		profileIcon.tierColor = _tierColor;
		profileIcon.tierIndex = _totalTier div 3;
		SetLabelText(profileTitleLabel, GetTierName(global.tier));
		SetLabel(profileTitleLabel, GetTierColor(global.tier), 0.9, 0.9, 1, 0, AL_LEFTTOP, global.FontDefault, true);
	UpdateCurrencyField(pageInstanceNow.object_index);
	}
}

/*
function GoToMainScreen(_tab = -1, _pageObject = -1) {
	if (_tab == -1) {
		_tab = global.MainScreenPageData.tab;
	}
	if (_pageObject == -1) {
		_pageObject = global.MainScreenPageData.pageObject;
	}
	r_change(r_MainScreen);
	global.MainScreenPageData = {
		tab        : _tab,
		pageObject : _pageObject,
	};
}*/