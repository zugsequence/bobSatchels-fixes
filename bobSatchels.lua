local eframe = CreateFrame("Frame");

eframe.version = "bobSatchels v1.35.2";	-- DEBUG_NOTE: version bump
eframe.lastupdate = GetTime();
eframe.lastpoll = 0;
eframe.lastreceive = 0;
eframe.incombat = false;
eframe:Show();
eframe:RegisterEvent("PLAYER_ENTERING_WORLD");
eframe:RegisterEvent("PLAYER_REGEN_ENABLED");
eframe:RegisterEvent("PLAYER_REGEN_DISABLED");

------------------------------------------------------------------------------------------------------------------------------------------------------------------

local cframe = CreateFrame("Frame", "bobSatchelsConfig", InterfaceOptionsFramePanelContainer)

cframe:Show();
cframe.name = "bobSatchels";
cframe.title = cframe:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
cframe.title:SetPoint("TOPLEFT", 16, -16)
cframe.title:SetText(eframe.version);
InterfaceOptions_AddCategory(cframe);

cframe.reward = CreateFrame("CheckButton", nil, cframe, "UICheckButtonTemplate");
cframe.reward:SetPoint("TOPLEFT", cframe.title, "BOTTOMLEFT", 0, -30);
cframe.reward:SetWidth(30);
cframe.reward:SetHeight(30);
cframe.reward:LockHighlight();
cframe.reward:SetAlpha(1);
cframe.reward:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
cframe.reward:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");

cframe.reward:HookScript("OnUpdate", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["rewards"] == true) then
		cframe.reward:SetChecked(true);
	else
		cframe.reward:SetChecked(false);
	end
end);

cframe.reward:HookScript("OnClick", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["rewards"] == true) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["rewards"] = false;
	else
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["rewards"] = true;
	end
end);

cframe.row = cframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
cframe.row:SetWidth(600);
cframe.row:SetHeight(30);
cframe.row:SetPoint("TOPLEFT", cframe.reward, "TOPRIGHT", 10, 0);
cframe.row:SetJustifyH("LEFT");
cframe.row:SetJustifyV("CENTER");
cframe.row:SetText("Rewards First - You must receive all weekly rewards before queueing extra satchels.");
cframe.row:SetVertexColor(ITEM_QUALITY_COLORS[2].r,ITEM_QUALITY_COLORS[2].g,ITEM_QUALITY_COLORS[2].b,1);

cframe.flashalert = CreateFrame("CheckButton", nil, cframe, "OptionsBaseCheckButtonTemplate");
cframe.flashalert:SetPoint("TOPLEFT", cframe.reward, "BOTTOMLEFT", 0, 0);
cframe.flashalert:SetWidth(30);
cframe.flashalert:SetHeight(30);
cframe.flashalert:LockHighlight();
cframe.flashalert:SetAlpha(1);
cframe.flashalert:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
cframe.flashalert:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");

cframe.flashalert:HookScript("OnUpdate", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["flashalert"] == true) then
		self:SetChecked(true);
	else
		self:SetChecked(false);
	end
end);

cframe.flashalert:HookScript("OnClick", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["flashalert"] == true) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["flashalert"] = false;
	else
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["flashalert"] = true;
	end
end);

cframe.row = cframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
cframe.row:SetWidth(600);
cframe.row:SetHeight(30);
cframe.row:SetPoint("TOPLEFT", cframe.flashalert, "TOPRIGHT", 10, 0);
cframe.row:SetJustifyH("LEFT");
cframe.row:SetJustifyV("CENTER");
cframe.row:SetText("Queue Alert: Flash - Flash WoW in taskbar when a queue is available.");
cframe.row:SetVertexColor(ITEM_QUALITY_COLORS[2].r,ITEM_QUALITY_COLORS[2].g,ITEM_QUALITY_COLORS[2].b,1);

cframe.alert = CreateFrame("CheckButton", nil, cframe, "UICheckButtonTemplate");
cframe.alert:SetPoint("TOPLEFT", cframe.flashalert, "BOTTOMLEFT", 0, 0);
cframe.alert:SetWidth(30);
cframe.alert:SetHeight(30);
cframe.alert:LockHighlight();
cframe.alert:SetAlpha(1);
cframe.alert:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
cframe.alert:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");

cframe.alert:HookScript("OnUpdate", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["alert"] == true) then
		self:SetChecked(true);
	else
		self:SetChecked(false);
	end
end);

cframe.alert:HookScript("OnClick", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["alert"] == true) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["alert"] = false;
	else
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["alert"] = true;
	end
end);

cframe.row = cframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
cframe.row:SetWidth(600);
cframe.row:SetHeight(30);
cframe.row:SetPoint("TOPLEFT", cframe.alert, "TOPRIGHT", 10, 0);
cframe.row:SetJustifyH("LEFT");
cframe.row:SetJustifyV("CENTER");
cframe.row:SetText("Queue Alert: MP3 - Play the bobSatchels.mp3 when a queue is available.");
cframe.row:SetVertexColor(ITEM_QUALITY_COLORS[2].r,ITEM_QUALITY_COLORS[2].g,ITEM_QUALITY_COLORS[2].b,1);

cframe.popup = CreateFrame("CheckButton", nil, cframe, "UICheckButtonTemplate");
cframe.popup:SetPoint("TOPLEFT", cframe.alert, "BOTTOMLEFT", 0, 0);
cframe.popup:SetWidth(30);
cframe.popup:SetHeight(30);
cframe.popup:LockHighlight();
cframe.popup:SetAlpha(1);
cframe.popup:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
cframe.popup:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");

cframe.popup:HookScript("OnUpdate", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popup"] == true) then
		self:SetChecked(true);
	else
		self:SetChecked(false);
	end
end);

cframe.popup:HookScript("OnClick", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popup"] == true) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popup"] = false;
	else
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popup"] = true;
	end
end);

cframe.row = cframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
cframe.row:SetWidth(600);
cframe.row:SetHeight(30);
cframe.row:SetPoint("TOPLEFT", cframe.popup, "TOPRIGHT", 10, 0);
cframe.row:SetJustifyH("LEFT");
cframe.row:SetJustifyV("CENTER");
cframe.row:SetText("Queue Popup - Place a minimized window in center of screen when queue available.");
cframe.row:SetVertexColor(ITEM_QUALITY_COLORS[2].r,ITEM_QUALITY_COLORS[2].g,ITEM_QUALITY_COLORS[2].b,1);

cframe.minimap = CreateFrame("CheckButton", nil, cframe, "UICheckButtonTemplate");
cframe.minimap:SetPoint("TOPLEFT", cframe.popup, "BOTTOMLEFT", 0, 0);
cframe.minimap:SetWidth(30);
cframe.minimap:SetHeight(30);
cframe.minimap:LockHighlight();
cframe.minimap:SetAlpha(1);
cframe.minimap:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
cframe.minimap:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");

cframe.minimap:HookScript("OnUpdate", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["minimap"] == true) then
		self:SetChecked(true);
	else
		self:SetChecked(false);
	end
end);

cframe.minimap:HookScript("OnClick", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["minimap"] == true) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["minimap"] = false;
	else
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["minimap"] = true;
	end
end);

cframe.row = cframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
cframe.row:SetWidth(600);
cframe.row:SetHeight(30);
cframe.row:SetPoint("TOPLEFT", cframe.minimap, "TOPRIGHT", 10, 0);
cframe.row:SetJustifyH("LEFT");
cframe.row:SetJustifyV("CENTER");
cframe.row:SetText("Minimap button - Shows you the minimap button.");
cframe.row:SetVertexColor(ITEM_QUALITY_COLORS[2].r,ITEM_QUALITY_COLORS[2].g,ITEM_QUALITY_COLORS[2].b,1);

cframe.autodock = CreateFrame("CheckButton", nil, cframe, "UICheckButtonTemplate");
cframe.autodock:SetPoint("TOPLEFT", cframe.minimap, "BOTTOMLEFT", 0, 0);
cframe.autodock:SetWidth(30);
cframe.autodock:SetHeight(30);
cframe.autodock:LockHighlight();
cframe.autodock:SetAlpha(1);
cframe.autodock:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
cframe.autodock:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");

cframe.autodock:HookScript("OnUpdate", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autodock"] == true) then
		self:SetChecked(true);
	else
		self:SetChecked(false);
	end
end);

cframe.autodock:HookScript("OnClick", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autodock"] == true) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autodock"] = false;
	else
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autodock"] = true;
	end
end);

cframe.row = cframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
cframe.row:SetWidth(600);
cframe.row:SetHeight(30);
cframe.row:SetPoint("TOPLEFT", cframe.autodock, "TOPRIGHT", 10, 0);
cframe.row:SetJustifyH("LEFT");
cframe.row:SetJustifyV("CENTER");
cframe.row:SetText("Auto Dock - Automatically docks and locks the GUI to your minimap button.");
cframe.row:SetVertexColor(ITEM_QUALITY_COLORS[2].r,ITEM_QUALITY_COLORS[2].g,ITEM_QUALITY_COLORS[2].b,1);

cframe.mbf = CreateFrame("CheckButton", nil, cframe, "UICheckButtonTemplate");
cframe.mbf:SetPoint("TOPLEFT", cframe.autodock, "BOTTOMLEFT", 0, 0);
cframe.mbf:SetWidth(30);
cframe.mbf:SetHeight(30);
cframe.mbf:LockHighlight();
cframe.mbf:SetAlpha(1);
cframe.mbf:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
cframe.mbf:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");

cframe.mbf:HookScript("OnUpdate", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mbf"] == true) then
		self:SetChecked(true);
	else
		self:SetChecked(false);
	end
end);

cframe.mbf:HookScript("OnClick", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mbf"] == true) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mbf"] = false;
	else
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mbf"] = true;
	end
	ReloadUI();
end);

cframe.row = cframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
cframe.row:SetWidth(600);
cframe.row:SetHeight(30);
cframe.row:SetPoint("TOPLEFT", cframe.mbf, "TOPRIGHT", 10, 0);
cframe.row:SetJustifyH("LEFT");
cframe.row:SetJustifyV("CENTER");
cframe.row:SetText("Minimap Button Addons - Create a button for Minimap addon button collectors.\n|cffFF0000WARNING - Clicking this will reload your UI.|r");
cframe.row:SetVertexColor(ITEM_QUALITY_COLORS[2].r,ITEM_QUALITY_COLORS[2].g,ITEM_QUALITY_COLORS[2].b,1);

cframe.flash = CreateFrame("CheckButton", nil, cframe, "UICheckButtonTemplate");
cframe.flash:SetPoint("TOPLEFT", cframe.mbf, "BOTTOMLEFT", 0, 0);
cframe.flash:SetWidth(30);
cframe.flash:SetHeight(30);
cframe.flash:LockHighlight();
cframe.flash:SetAlpha(1);
cframe.flash:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
cframe.flash:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");

cframe.flash:HookScript("OnUpdate", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["flash"] == true) then
		self:SetChecked(true);
	else
		self:SetChecked(false);
	end
end);

cframe.flash:HookScript("OnClick", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["flash"] == true) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["flash"] = false;
	else
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["flash"] = true;
	end
end);

cframe.row = cframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
cframe.row:SetWidth(600);
cframe.row:SetHeight(30);
cframe.row:SetPoint("TOPLEFT", cframe.flash, "TOPRIGHT", 10, 0);
cframe.row:SetJustifyH("LEFT");
cframe.row:SetJustifyV("CENTER");
cframe.row:SetText("Flash Minimap Button - Flash the Minimap button when the queue button is ready.");
cframe.row:SetVertexColor(ITEM_QUALITY_COLORS[2].r,ITEM_QUALITY_COLORS[2].g,ITEM_QUALITY_COLORS[2].b,1);

cframe.autoopen = CreateFrame("CheckButton", nil, cframe, "UICheckButtonTemplate");
cframe.autoopen:SetPoint("TOPLEFT", cframe.flash, "BOTTOMLEFT", 0, 0);
cframe.autoopen:SetWidth(30);
cframe.autoopen:SetHeight(30);
cframe.autoopen:LockHighlight();
cframe.autoopen:SetAlpha(1);
cframe.autoopen:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
cframe.autoopen:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");

cframe.autoopen:HookScript("OnUpdate", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autoopen"] == true) then
		self:SetChecked(true);
	else
		self:SetChecked(false);
	end
end);

cframe.autoopen:HookScript("OnClick", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autoopen"] == true) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autoopen"] = false;
	else
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autoopen"] = true;
	end
end);

cframe.row = cframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
cframe.row:SetWidth(600);
cframe.row:SetHeight(30);
cframe.row:SetPoint("TOPLEFT", cframe.autoopen, "TOPRIGHT", 10, 0);
cframe.row:SetJustifyH("LEFT");
cframe.row:SetJustifyV("CENTER");
cframe.row:SetText("Auto Open - Automatically opens satchels in your inventory.");
cframe.row:SetVertexColor(ITEM_QUALITY_COLORS[2].r,ITEM_QUALITY_COLORS[2].g,ITEM_QUALITY_COLORS[2].b,1);

cframe.showdone = CreateFrame("CheckButton", nil, cframe, "UICheckButtonTemplate");
cframe.showdone:SetPoint("TOPLEFT", cframe.autoopen, "BOTTOMLEFT", 0, 0);
cframe.showdone:SetWidth(30);
cframe.showdone:SetHeight(30);
cframe.showdone:LockHighlight();
cframe.showdone:SetAlpha(1);
cframe.showdone:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
cframe.showdone:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");

cframe.showdone:HookScript("OnUpdate", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["showdone"] == true) then
		self:SetChecked(true);
	else
		self:SetChecked(false);
	end
end);

cframe.showdone:HookScript("OnClick", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["showdone"] == true) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["showdone"] = false;
	else
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["showdone"] = true;
	end
end);

cframe.row = cframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
cframe.row:SetWidth(600);
cframe.row:SetHeight(30);
cframe.row:SetPoint("TOPLEFT", cframe.showdone, "TOPRIGHT", 10, 0);
cframe.row:SetJustifyH("LEFT");
cframe.row:SetJustifyV("CENTER");
cframe.row:SetText("Show Progress - Shows progress of how many bosses down in each LFR.");
cframe.row:SetVertexColor(ITEM_QUALITY_COLORS[2].r,ITEM_QUALITY_COLORS[2].g,ITEM_QUALITY_COLORS[2].b,1);

cframe.autohide = CreateFrame("CheckButton", nil, cframe, "UICheckButtonTemplate");
cframe.autohide:SetPoint("TOPLEFT", cframe.showdone, "BOTTOMLEFT", 0, 0);
cframe.autohide:SetWidth(30);
cframe.autohide:SetHeight(30);
cframe.autohide:LockHighlight();
cframe.autohide:SetAlpha(1);
cframe.autohide:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
cframe.autohide:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");

cframe.autohide:HookScript("OnUpdate", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autohide"] == true) then
		self:SetChecked(true);
	else
		self:SetChecked(false);
	end
end);

cframe.autohide:HookScript("OnClick", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autohide"] == true) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autohide"] = false;
	else
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autohide"] = true;
	end
end);

cframe.row = cframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
cframe.row:SetWidth(600);
cframe.row:SetHeight(30);
cframe.row:SetPoint("TOPLEFT", cframe.autohide, "TOPRIGHT", 10, 0);
cframe.row:SetJustifyH("LEFT");
cframe.row:SetJustifyV("CENTER");
cframe.row:SetText("Auto Hide - Auto hide GUI when you are in combat.");
cframe.row:SetVertexColor(ITEM_QUALITY_COLORS[2].r,ITEM_QUALITY_COLORS[2].g,ITEM_QUALITY_COLORS[2].b,1);

------------------------------------------------------------------------------------------------------------------------------------------------------------------

local oframe = CreateFrame("Frame", "bobSatchels", UIParent, "BackdropTemplate");

oframe:Hide();
oframe:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" });
oframe:SetBackdropColor(0, 0, 0, 1);
oframe.height = 30;
oframe.width = 330;
oframe:SetFrameStrata("TOOLTIP");
oframe:SetWidth(oframe.width);
oframe:SetHeight(oframe.height);
oframe:EnableMouse(true);
oframe:SetClampedToScreen(true);
oframe:SetMovable(true);
oframe:RegisterForDrag("");
oframe:SetPoint("CENTER", UIParent, "CENTER");

oframe.queues = {};
oframe.queuelastqueue = GetTime();
oframe.queuelastid = 0;
oframe.lastalert = 0;
oframe.skiprewards = false;
oframe.hasrewards = false;
oframe.dragging = false;
oframe.docked = false;
oframe.didfake = false;
oframe.bagtime = GetTime();
oframe.final = false;
oframe.rebuild = false;

------------------------------------------------------------------------------------------------------------------------------------------------------------------

function bobSatchelsHeader(myframe, toframe, mywidth, myheight, showeye, roletext)
	if (showeye == false) then
		mywidth = mywidth - 30;
	end
	myframe:Show();
	myframe:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" });
	myframe:SetBackdropColor(0, 0, 0, 1);
	myframe:SetFrameStrata("MEDIUM");
	myframe:SetWidth(mywidth);
	myframe:SetHeight(myheight);
	myframe:EnableMouse(false);
	myframe:SetClampedToScreen(true);
	myframe:SetMovable(false);
	myframe:SetPoint("TOPLEFT", toframe, "BOTTOMLEFT");

	toframe.valoricon = myframe:CreateTexture(nil, "OVERLAY");
	toframe.valoricon:SetSize(30, 30);
	toframe.valoricon:SetPoint("TOPLEFT", myframe, "TOPLEFT", 0, 0);
	toframe.valoricon:SetTexture("Interface\\Icons\\INV_Box_01");

	--DEBUG_NOTE: the Minimap.lua interface file that defined 'LFG_EYE_TEXTURES' has been
	--            rewritten in 10.0.0 (Dragonflight) and can no longer be referenced. The
	--            texture reference data is reproduced below as a local variable. Newer,
	--            higher resolution, eye textures are available. Check 'AtlasInfo.lua'...
	local LFG_EYE_TEXTURES = { };	-- DEBUG_NOTE:	LOWER_RES: comment this line if using new texture
	LFG_EYE_TEXTURES["default"] = { file = "Interface\\LFGFrame\\LFG-Eye", width = 512, height = 256, frames = 29, iconSize = 64, delay = 0.1 };	-- DEBUG_NOTE: LOWER_RES: comment this line if using new texture
	if (showeye == true) then
		toframe.eyeicon = myframe:CreateTexture(nil, "OVERLAY");
		toframe.eyeicon:SetSize(30, 30);
		toframe.eyeicon:SetPoint("TOPLEFT", toframe.valoricon, "TOPRIGHT", 0, 0);
		toframe.eyeicon:SetTexture(LFG_EYE_TEXTURES["default"].file);	-- DEBUG_NOTE: LOWER_RES: comment this line if using new texture
		toframe.eyeicon:SetTexCoord(0, LFG_EYE_TEXTURES["default"].iconSize / LFG_EYE_TEXTURES["default"].width, 0, LFG_EYE_TEXTURES["default"].iconSize / LFG_EYE_TEXTURES["default"].height);	-- DEBUG_NOTE: LOWER_RES: comment this line if using new texture
		--toframe.eyeicon:SetAtlas("groupfinder-eye-frame");	-- DEBUG_NOTE: HIGHER_RES: uncomment this line for new texture
	end

	toframe.roles = myframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	toframe.roles:SetWidth(175);
	toframe.roles:SetHeight(30);
	if (showeye == true) then
		toframe.roles:SetPoint("TOPLEFT", toframe.eyeicon, "TOPRIGHT", 0, 0);
	else
		toframe.roles:SetPoint("TOPLEFT", toframe.valoricon, "TOPRIGHT", 0, 0);
	end
	toframe.roles:SetJustifyH("RIGHT");
	toframe.roles:SetJustifyV("CENTER");
	toframe.roles:SetText(roletext);
	toframe.roles:SetVertexColor(ITEM_QUALITY_COLORS[5].r,ITEM_QUALITY_COLORS[5].g,ITEM_QUALITY_COLORS[5].b,1);

	toframe.spacer = myframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	toframe.spacer:SetWidth(5);
	toframe.spacer:SetHeight(30);
	toframe.spacer:SetPoint("TOPLEFT", toframe.roles, "TOPRIGHT", 0, 0);
	toframe.spacer:SetJustifyH("CENTER");
	toframe.spacer:SetJustifyV("CENTER");
	toframe.spacer:SetText("");

	toframe.tankicon = myframe:CreateTexture(nil, "ARTWORK");
	toframe.tankicon:SetSize(30, 30);
	toframe.tankicon:SetPoint("TOPLEFT", toframe.spacer, "TOPRIGHT", 0, 0);
	toframe.tankicon:SetAtlas("groupfinder-icon-role-large-tank");

	toframe.tankiconbutton = CreateFrame("Button", nil, toframe);
	toframe.tankiconbutton:SetSize(30, 30);
	toframe.tankiconbutton:Show();
	toframe.tankiconbutton:SetPoint("TOPLEFT", toframe.spacer, "TOPRIGHT", 0, 0);

--HERE
	toframe.tankiconbutton:RegisterForClicks("LeftButtonUp");
	toframe.tankiconbutton:HookScript("OnClick", function(self)
		self.setalltrue = true;
		for i, v in pairs(oframe.queues) do
			if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["tank"] == true) then
				self.setalltrue = false;
			end
		end
		for i, v in pairs(oframe.queues) do
			if (self.setalltrue == true) then
				bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["tank"] = true;
			else
				bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["tank"] = false;
			end
		end	
	end);

	toframe.healericon = myframe:CreateTexture(nil, "ARTWORK");
	toframe.healericon:SetSize(30, 30);
	toframe.healericon:SetPoint("TOPLEFT", toframe.tankicon, "TOPRIGHT", 0, 0);
	toframe.healericon:SetAtlas("groupfinder-icon-role-large-heal");

	toframe.healericonbutton = CreateFrame("Button", nil, toframe);
	toframe.healericonbutton:SetSize(30, 30);
	toframe.healericonbutton:Show();
	toframe.healericonbutton:SetPoint("TOPLEFT", toframe.tankicon, "TOPRIGHT", 0, 0);

	toframe.healericonbutton:RegisterForClicks("LeftButtonUp");
	toframe.healericonbutton:HookScript("OnClick", function(self)
		self.setalltrue = true;
		for i, v in pairs(oframe.queues) do
			if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["healer"] == true) then
				self.setalltrue = false;
			end
		end
		for i, v in pairs(oframe.queues) do
			if (self.setalltrue == true) then
				bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["healer"] = true;
			else
				bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["healer"] = false;
			end
		end	
	end);

	toframe.damageicon = myframe:CreateTexture(nil, "ARTWORK");
	toframe.damageicon:SetSize(30, 30);
	toframe.damageicon:SetPoint("TOPLEFT", toframe.healericon, "TOPRIGHT", 0, 0);
	toframe.damageicon:SetAtlas("groupfinder-icon-role-large-dps");

	toframe.damageiconbutton = CreateFrame("Button", nil, toframe);
	toframe.damageiconbutton:SetSize(30, 30);
	toframe.damageiconbutton:Show();
	toframe.damageiconbutton:SetPoint("TOPLEFT", toframe.healericon, "TOPRIGHT", 0, 0);

	toframe.damageiconbutton:RegisterForClicks("LeftButtonUp");
	toframe.damageiconbutton:HookScript("OnClick", function(self)
		self.setalltrue = true;
		for i, v in pairs(oframe.queues) do
			if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["damage"] == true) then
				self.setalltrue = false;
			end
		end
		for i, v in pairs(oframe.queues) do
			if (self.setalltrue == true) then
				bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["damage"] = true;
			else
				bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["damage"] = false;
			end
		end	
	end);

end

function bobSatchelsRow(myrow, myframe, mywidth, myheight, showeye)
	if (showeye == false) then
		mywidth = mywidth - 30;
	end
	myrow:Show();
	myrow:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" });
	myrow:SetBackdropColor(0, 0, 0, 1);
	myrow:SetFrameStrata("MEDIUM");
	myrow:SetWidth(mywidth);
	myrow:SetHeight(myheight);
	myrow:EnableMouse(false);
	myrow:SetClampedToScreen(true);
	myrow:SetMovable(false);
	myrow:SetPoint("TOPLEFT", myframe, "BOTTOMLEFT");

	myrow.ID = nil;

	myrow.currency = CreateFrame("CheckButton", nil, myrow, "UICheckButtonTemplate");
	myrow.currency:SetSize(30, 30);
	myrow.currency:Hide();
	myrow.currency.ID = nil;
	myrow.currency:SetPoint("TOPLEFT", myrow, "TOPLEFT", 0, 0);
	myrow.currency:SetButtonState("normal", true);
	myrow.currency:SetCheckedTexture("");	-- DEBUG_NOTE: this isn't making it into the `OnUpdate` HookScript for some reason?

	myrow.currency:HookScript("OnEnter", function(self)
		if (self.ID == nil) then return; end
		if (oframe.queues[self.ID] == nil) then return; end
		if (oframe.queues[self.ID]["currencyid"] ~= "") then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:ClearLines();
			GameTooltip:SetHyperlink(oframe.queues[self.ID]["currencyid"]);
			GameTooltip:Show();
		end
	end);

	myrow.currency:HookScript("OnLeave", function(self)
		if (self.ID == nil) then return; end
		GameTooltip:Hide();
	end);

	myrow.currency:HookScript("OnUpdate", function(self)
		if (self.ID == nil) then return; end
		if (oframe.queues[self.ID] == nil) then return; end

		if (self:GetChecked() == true) then
			self:ClearNormalTexture();
			self:SetNormalTexture("");
		else
			self:ClearNormalTexture();
			self:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");
		end
		if (oframe.queues[self.ID]["currency"] ~= "") then
			self:ClearNormalTexture();
			self:SetNormalTexture( tonumber(oframe.queues[self.ID]["currency"]) );	-- DEBUG_NOTE: passing string value confusing `SetNormalTexture` so convert to number
			self:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
			self:SetAlpha(1);
			self:SetCheckedTexture("");	-- DEBUG_NOTE: why is this needed? the `myrow.currency:SetCheckedTexture("")` call doesn't seem to be propagating?
			self:SetChecked(true);
			self:LockHighlight();
		else
			self:SetAlpha(0.50);
			self:SetChecked(false);
			self:UnlockHighlight();
		end
	end);

	myrow.eye = CreateFrame("CheckButton", nil, myrow, "UICheckButtonTemplate");
	if (showeye == true) then
		myrow.eye:SetSize(30, 30);
	else
		myrow.eye:SetSize(0, 0);
	end
	myrow.eye:Hide();
	myrow.eye:SetPoint("TOPLEFT", myrow.currency, "TOPRIGHT", 0, 0);
	myrow.eye:SetCheckedTexture("");	-- DEBUG_NOTE: this isn't making it into the `OnUpdate` HookScript for some reason?
	myrow.eye:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");

	myrow.eye:HookScript("OnClick", function(self)
		if (self.ID == nil) then return; end
		if (oframe.queues[self.ID] == nil) then return; end

		if (oframe.queues[self.ID]["queued"] == true) then
			LeaveSingleLFG(oframe.queues[self.ID]["cat"], self.ID);
		else
			oframe.queues[self.ID]["qforced"] = true;
			oframe.qtank = bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][self.ID]["tank"]
			oframe.qhealer = bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][self.ID]["healer"]
			oframe.qdamage = bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][self.ID]["damage"]
			ClearAllLFGDungeons(oframe.queues[self.ID]["cat"]);
			SetLFGDungeon(oframe.queues[self.ID]["cat"], self.ID);
			SetLFGRoles(true, oframe.qtank, oframe.qhealer, oframe.qdamage);
			if (oframe.queues[self.ID]["cat"] == LE_LFG_CATEGORY_LFD) then
				LFDFrame_DisplayDungeonByID(self.ID);
			elseif (oframe.queues[self.ID]["cat"] == LE_LFG_CATEGORY_RF) then
				LFG_UpdateQueuedList();
				LFG_UpdateAllRoleCheckboxes();
			end
			SetLFGRoles(true, oframe.qtank, oframe.qhealer, oframe.qdamage);
			JoinLFG(oframe.queues[self.ID]["cat"], self.ID);
			oframe.queuelastid = self.ID;
			oframe.lastalert = 0;
			oframe.queuelastqueue = GetTime();
			oframe.queue.wait = oframe.queue.wait + 1;
			oframe.queue.lastcount = oframe.queue.count;	
		end
	end);

	myrow.eye:HookScript("OnUpdate", function(self)
		if (self.ID == nil) then return; end
		if (oframe.queues[self.ID] == nil) then return; end
		
		self:SetCheckedTexture("");	-- DEBUG_NOTE: this fixes the overlapping READY_CHECK_READY_TEXTURE and READY_CHECK_NOT_READY_TEXTURE. NOTE: Why is this needed when there was already a call to `myrow.eye:SetCheckedTexture("");` -- why isn't the original call propagating???
		self:UnlockHighlight();
		if (oframe.queues[self.ID]["queued"] == true) then
			self:SetAlpha(1);
			self:SetChecked(true);
			self:ClearNormalTexture();
			self:SetNormalTexture(READY_CHECK_WAITING_TEXTURE);
		else
			self:SetAlpha(0.50);
			self:SetChecked(false);
			self:ClearNormalTexture();
			self:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");
		end
		if (oframe.queues[self.ID]["stank"] == true or oframe.queues[self.ID]["shealer"] == true or oframe.queues[self.ID]["sdamage"] == true) then
			self:LockHighlight();
			self:ClearNormalTexture();
			self:SetNormalTexture( tonumber(oframe.queues[self.ID]["reward"]) );	-- DEBUG_NOTE: passing string value confusing `SetNormalTexture` so convert to number
		elseif (oframe.queues[self.ID]["queued"] == true) then
			if (oframe.queues[self.ID]["qtank"] == true or oframe.queues[self.ID]["qhealer"] == true or oframe.queues[self.ID]["qdamage"] == true) then
				self:SetCheckedTexture("");	-- DEBUG_NOTE: this fixes the overlapping READY_CHECK_READY_TEXTURE and READY_CHECK_NOT_READY_TEXTURE. NOTE: unsure why this is needed when `myrow.eye:SetCheckedTexture("")` is the default. This reduces texture lag for w/e reason so keeping it here as well...
				self:ClearNormalTexture();
				self:SetNormalTexture(READY_CHECK_NOT_READY_TEXTURE);
			end
		end
	end);

	myrow.name = myframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	myrow.name:Hide();
	myrow.name:SetWidth(175);
	myrow.name:SetHeight(30);
	if (showeye == true) then
		myrow.name:SetPoint("TOPLEFT", myrow.eye, "TOPRIGHT", 0, 0);
	else
		myrow.name:SetPoint("TOPLEFT", myrow.currency, "TOPRIGHT", 0, 0);
	end
	myrow.name:SetJustifyH("RIGHT");
	myrow.name:SetJustifyV("CENTER");

	myrow.namelooted = CreateFrame("CheckButton", nil, myrow, "UICheckButtonTemplate");
	myrow.namelooted:SetSize(175, 30);
	myrow.namelooted:SetPoint("TOPLEFT", myrow.name, "TOPRIGHT", -175, 0);
	myrow.namelooted:SetNormalTexture("");
	myrow.namelooted:SetCheckedTexture("");
	myrow.namelooted:SetHighlightTexture("");
	myrow.namelooted:SetButtonState("normal", true);
	myrow.namelooted:ClearNormalTexture();	-- DEBUG_NOTE: this removes the blue ring on instance name
	myrow.namelooted:ClearHighlightTexture();	-- DEBUG_NOTE: this removes strange glow on instance name

	myrow.namelooted:HookScript("OnEnter", function(self)
		if (self.ID == nil) then return; end
		if (oframe.queues[self.ID] == nil) then return; end

		local numEncounters, numCompleted = GetLFGDungeonNumEncounters(self.ID);

		if ( numEncounters > 0 ) then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:ClearLines();
			GameTooltip:AddLine("Already looted ("..numCompleted.."/"..numEncounters..")");
			for i=1, numEncounters do
				local bossName, texture, isKilled = GetLFGDungeonEncounterInfo(self.ID, i);
				if ( isKilled ) then
					GameTooltip:AddLine(bossName, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				else
					GameTooltip:AddLine(bossName, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
				end
			end
			GameTooltip:Show();
		end
	end);

	myrow.namelooted:HookScript("OnLeave", function(self)
		if (self.ID == nil) then return; end
		GameTooltip:Hide();
	end);

	myrow.spacer = myframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	myrow.spacer:Show();
	myrow.spacer:SetWidth(5);
	myrow.spacer:SetHeight(30);
	myrow.spacer:SetPoint("TOPLEFT", myrow.name, "TOPRIGHT", 0, 0);
	myrow.spacer:SetJustifyH("CENTER");
	myrow.spacer:SetJustifyV("CENTER");
	myrow.spacer:SetText("");

	myrow.tank = CreateFrame("CheckButton", nil, myframe, "UICheckButtonTemplate");
	myrow.tank:Hide();
	myrow.tank:SetSize(30, 30);
	myrow.tank:SetPoint("TOPLEFT", myrow.spacer, "TOPRIGHT", 0, 0);
	myrow.tank:SetCheckedTexture(READY_CHECK_READY_TEXTURE);
	myrow.tank:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
	myrow.tank:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");

	myrow.tank:HookScript("OnClick", function(self)
		if (self.ID == nil) then return; end
		bobSatchelsRoleButtonOnClick(self, 1, "tank");
	end);

	myrow.tank:HookScript("OnUpdate", function(self)
		if (self.ID == nil) then return; end
		self:SetChecked(bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][self.ID]["tank"]);
		bobSatchelsRoleButtonOnUpdate(self, 1, "tank");
	end);

	myrow.healer = CreateFrame("CheckButton", nil, myframe, "UICheckButtonTemplate");
	myrow.healer:Hide();
	myrow.healer:SetSize(30, 30);
	myrow.healer:SetPoint("TOPLEFT", myrow.tank, "TOPRIGHT", 0, 0);
	myrow.healer:SetCheckedTexture(READY_CHECK_READY_TEXTURE);
	myrow.healer:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
	myrow.healer:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");

	myrow.healer:HookScript("OnClick", function(self)
		if (self.ID == nil) then return; end
		bobSatchelsRoleButtonOnClick(self, 2, "healer");
	end);

	myrow.healer:HookScript("OnUpdate", function(self)
		if (self.ID == nil) then return; end
		self:SetChecked(bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][self.ID]["healer"]);
		bobSatchelsRoleButtonOnUpdate(self, 2, "healer");
	end);

	myrow.damage = CreateFrame("CheckButton", nil, myframe, "UICheckButtonTemplate");
	myrow.damage:Hide();
	myrow.damage:SetSize(30, 30);
	myrow.damage:SetPoint("TOPLEFT", myrow.healer, "TOPRIGHT", 0, 0);
	myrow.damage:SetCheckedTexture(READY_CHECK_READY_TEXTURE);
	myrow.damage:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
	myrow.damage:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");

	myrow.damage:HookScript("OnClick", function(self)
		if (self.ID == nil) then return; end
		bobSatchelsRoleButtonOnClick(self, 3, "damage");
	end);

	myrow.damage:HookScript("OnUpdate", function(self)
		if (self.ID == nil) then return; end
		self:SetChecked(bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][self.ID]["damage"]);
		bobSatchelsRoleButtonOnUpdate(self, 3, "damage");
	end);

	myrow:HookScript("OnUpdate", function(self)
		myrow.currency.ID = self.ID;
		myrow.eye.ID = self.ID;
		myrow.name.ID = self.ID;
		myrow.namelooted.ID = self.ID;
		myrow.tank.ID = self.ID;
		myrow.healer.ID = self.ID;
		myrow.damage.ID = self.ID;
		if (self.ID == nil) then
			myrow.currency:Hide();
			myrow.eye:Hide();
			myrow.name:Hide();
			myrow.namelooted:Hide();
			myrow.tank:Hide();
			myrow.healer:Hide();
			myrow.damage:Hide();
			return;
		else
			myrow.currency:Show();
			myrow.eye:Show();
			myrow.name:Show();
			myrow.namelooted:Show();
			myrow.tank:Show();
			myrow.healer:Show();
			myrow.damage:Show();
		end
		if (oframe.queues[self.ID] == nil) then return; end

		if (oframe.queues[self.ID]["cat"] == LE_LFG_CATEGORY_LFD) then
			self.name:SetVertexColor(ITEM_QUALITY_COLORS[3].r,ITEM_QUALITY_COLORS[3].g,ITEM_QUALITY_COLORS[3].b,1);
		else
			self.name:SetVertexColor(ITEM_QUALITY_COLORS[4].r,ITEM_QUALITY_COLORS[4].g,ITEM_QUALITY_COLORS[4].b,1);
		end
		if (oframe.queues[self.ID]["active"] == true) then
			self.name:SetText("|cffFFFFFF"..oframe.queues[self.ID]["name"].."|r");
		else
			self.name:SetText(oframe.queues[self.ID]["name"]);
		end
	end);
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------

local qframe = CreateFrame("Frame", "bobSatchelsQueue", UIParent, "BackdropTemplate");
qframe:Show();
qframe:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" });
qframe:SetBackdropColor(0, 0, 0, 1);
qframe:SetFrameStrata("TOOLTIP");
qframe:SetWidth(oframe.width - 30);
qframe:SetHeight(oframe.height);
qframe:EnableMouse(true);
qframe:SetClampedToScreen(true);
qframe:SetMovable(true);
qframe:RegisterForDrag("LeftButton");
qframe:SetPoint("CENTER", UIParent, "CENTER");
qframe.dragging = false;

qframe:SetScript("OnDragStart", function(self)
	qframe.dragging = true;
	self:StartMoving();
end);

qframe:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing();
	qframe.dragging = false;
	self:ClearAllPoints();
	self:SetPoint("CENTER", bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popframe"]["x"], bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popframe"]["y"]);
end);

qframe:SetScript("OnUpdate", function(self, elapsed)
	if (qframe.dragging == true) then
		local centerX, centerY = UIParent:GetCenter();
		local x, y = GetCursorPosition();
		x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY;
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popframe"] = {};
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popframe"]["x"] = x;
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popframe"]["y"] = y;
		self:ClearAllPoints();
		self:SetPoint("CENTER", UIParent, "CENTER", bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popframe"]["x"], bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popframe"]["y"]);
	end
end);

qframe.about = qframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
qframe.about:SetWidth(120);
qframe.about:SetHeight(30);
qframe.about:SetPoint("TOPLEFT", qframe, "TOPLEFT", 0, 0);
qframe.about:SetJustifyH("CENTER");
qframe.about:SetJustifyV("CENTER");
qframe.about:SetText(eframe.version);
qframe.about:SetVertexColor(ITEM_QUALITY_COLORS[6].r,ITEM_QUALITY_COLORS[6].g,ITEM_QUALITY_COLORS[6].b,1);

qframe.options = CreateFrame("Button", nil, qframe, "UIPanelButtonTemplate");
qframe.options:SetPoint("TOPLEFT", qframe.about, "TOPRIGHT", 0, 0);
qframe.options:SetWidth(80);
qframe.options:SetHeight(30);
qframe.options:SetText("Options");

qframe.options:HookScript("OnClick", function(self)
	Settings.OpenToCategory("bobSatchels");	-- DEBUG_NOTE: `InterfaceOptionsFrame_OpenToCategory` was deprecated in 10.0.0.
	Settings.OpenToCategory("bobSatchels");	-- DEBUG_NOTE: `InterfaceOptionsFrame_OpenToCategory` was deprecated in 10.0.0.
end);

qframe.queue = CreateFrame("Button", nil, qframe, "UIPanelButtonTemplate");
qframe.queue:SetPoint("TOPLEFT", qframe.options, "TOPRIGHT", 0, 0);
qframe.queue:SetWidth(100);
qframe.queue:SetHeight(30);
qframe.queue:SetText("Queue!");

qframe.queue:HookScript("OnClick", function(self)
	oframe.refresh(true);
end);

qframe.header = CreateFrame("Frame", nil, qframe, "BackdropTemplate");
qframe.header:SetFrameStrata("TOOLTIP");
qframe.queue1 = CreateFrame("Frame", nil, qframe, "BackdropTemplate");
qframe.queue1:SetFrameStrata("TOOLTIP");
qframe.queue2 = CreateFrame("Frame", nil, qframe, "BackdropTemplate");
qframe.queue2:SetFrameStrata("TOOLTIP");
qframe.queue3 = CreateFrame("Frame", nil, qframe, "BackdropTemplate");
qframe.queue3:SetFrameStrata("TOOLTIP");

bobSatchelsHeader(qframe.header, qframe, oframe.width, oframe.height, false, "Uncheck any roles you are not willing to queue for...");
bobSatchelsRow(qframe.queue1, qframe.header, oframe.width, oframe.height, false);
bobSatchelsRow(qframe.queue2, qframe.queue1, oframe.width, oframe.height, false);
bobSatchelsRow(qframe.queue3, qframe.queue2, oframe.width, oframe.height, false);

------------------------------------------------------------------------------------------------------------------------------------------------------------------

local fakemapframe = CreateFrame("Button", "bobSatchelsMinimapButton", Minimap);

fakemapframe.backupHide = fakemapframe.Hide;
fakemapframe.backupShow = fakemapframe.Show;

fakemapframe:Hide();
fakemapframe:SetSize(31, 31);
fakemapframe:SetFrameStrata("MEDIUM");
fakemapframe:SetFrameLevel(8);
fakemapframe:SetMovable(false);
fakemapframe:RegisterForClicks('LeftButtonUp', "RightButtonUp");
fakemapframe:SetHighlightTexture('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight');
fakemapframe:ClearAllPoints();
fakemapframe:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -50000, -50000);
fakemapframe:LockHighlight();

fakemapframe:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(fakemapframe, "ANCHOR_TOPLEFT");
	oframe.buildtooltip(GameTooltip);
	GameTooltip:Show();
end);

fakemapframe:SetScript("OnLeave", function(self)
	GameTooltip:Hide();
end);

fakemapframe:SetScript("OnClick", function(self, button)
	oframe.onclick("Minimap", button);
end);

fakemapframe.overlay = fakemapframe:CreateTexture(nil, "OVERLAY");
fakemapframe.overlay:SetSize(53, 53);
fakemapframe.overlay:SetTexture('Interface\\Minimap\\MiniMap-TrackingBorder');
fakemapframe.overlay:SetPoint("TOPLEFT");

fakemapframe.bg = fakemapframe:CreateTexture(nil, "BACKGROUND");
fakemapframe.bg:SetSize(20, 20);
fakemapframe.bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background");
fakemapframe.bg:SetPoint("TOPLEFT", 7, -5)

fakemapframe.icon = fakemapframe:CreateTexture(nil, "ARTWORK");
fakemapframe.icon:SetSize(20, 20);
fakemapframe.icon:SetTexture("133658");
fakemapframe.icon:SetPoint("TOPLEFT", 7, -6)

------------------------------------------------------------------------------------------------------------------------------------------------------------------

local mapframe = CreateFrame("Button", nil, Minimap);
mapframe:Hide();
mapframe:SetSize(31, 31);
mapframe:SetFrameStrata("MEDIUM");
mapframe:SetFrameLevel(8);
mapframe:SetMovable(true);
mapframe:RegisterForDrag("LeftButton");
mapframe:RegisterForClicks('LeftButtonUp', "RightButtonUp");
mapframe:SetHighlightTexture('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight');
mapframe.dragging = false;
mapframe.lastflash = GetTime();

mapframe:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(mapframe, "ANCHOR_TOPLEFT");
	oframe.buildtooltip(GameTooltip);
	GameTooltip:Show();
end);

mapframe:SetScript("OnLeave", function(self)
	GameTooltip:Hide();
end);

mapframe:SetScript("OnClick", function(self, button)
	oframe.onclick("Minimap", button);
end);

mapframe:SetScript("OnDragStart", function(self)
	self:LockHighlight();
	mapframe.dragging = true;
	GameTooltip:Hide();
	self:StartMoving();
end);

mapframe:SetScript("OnDragStop", function(self)
	self:UnlockHighlight();
	self:StopMovingOrSizing();
	mapframe.dragging = false;
	self:ClearAllPoints();
	self:SetPoint("CENTER", bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mapframe"]["x"], bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mapframe"]["y"]);
	oframe.docked = false;
end);

mapframe:SetScript("OnUpdate", function(self, elapsed)
	if (mapframe.dragging == true) then
		local width = (Minimap:GetWidth() / 2) + 5;	-- DEBUG_NOTE: this fixes the minimap button position
		local centerX, centerY = Minimap:GetCenter();
		local x, y = GetCursorPosition();
		x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY;
		centerX, centerY = abs(x), abs(y);
		centerX, centerY = (centerX / sqrt(centerX^2 + centerY^2)) * width, (centerY / sqrt(centerX^2 + centerY^2)) * width;	-- DEBUG_NOTE: this fixes the minimap button position
		centerX = x < 0 and -centerX or centerX;
		centerY = y < 0 and -centerY or centerY;
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mapframe"] = {};
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mapframe"]["x"] = centerX;
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mapframe"]["y"] = centerY;
		self:ClearAllPoints();
		self:SetPoint("CENTER", bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mapframe"]["x"], bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mapframe"]["y"]);
	end
end);

mapframe.overlay = mapframe:CreateTexture(nil, "OVERLAY");
mapframe.overlay:SetSize(53, 53);
mapframe.overlay:SetTexture('Interface\\Minimap\\MiniMap-TrackingBorder');
mapframe.overlay:SetPoint("TOPLEFT");

mapframe.bg = mapframe:CreateTexture(nil, "BACKGROUND");
mapframe.bg:SetSize(20, 20);
mapframe.bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background");
mapframe.bg:SetPoint("TOPLEFT", 7, -5)

mapframe.icon = mapframe:CreateTexture(nil, "ARTWORK");
mapframe.icon:SetSize(20, 20);
mapframe.icon:SetTexture("133658");
mapframe.icon:SetPoint("TOPLEFT", 7, -6)

------------------------------------------------------------------------------------------------------------------------------------------------------------------

local aframe = CreateFrame("Frame", nil, oframe, "BackdropTemplate");
aframe:Show();
aframe:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" });
aframe:SetBackdropColor(0, 0, 0, 1);
aframe.height = oframe.height;
aframe.width = oframe.width;
aframe:SetFrameStrata("MEDIUM");
aframe:SetWidth(aframe.width);
aframe:SetHeight(aframe.height);
aframe:EnableMouse(false);
aframe:SetClampedToScreen(true);
aframe:SetMovable(true);
aframe:SetPoint("TOPLEFT", oframe, "TOPLEFT");

aframe.rows = {};

------------------------------------------------------------------------------------------------------------------------------------------------------------------

eframe:HookScript("OnEvent", function(self, event, arg1, arg2)
	if (event == "PLAYER_ENTERING_WORLD") then
		oframe.docked = false;
		if ( bobSatchelsSaved == nil ) then
			bobSatchelsSaved = {};
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()] = {};
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["rewards"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["rewards"] = false;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["alert"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["alert"] = true;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["flashalert"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["flashalert"] = true;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["show"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["show"] = true;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["minimize"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["minimize"] = false;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popup"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popup"] = true;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"] = {};
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["p"] = "CENTER";
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["rP"] = "CENTER";
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["x"] = 0;
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["y"] = 0;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["minimap"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["minimap"] = true;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mapframe"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mapframe"] = {};
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mapframe"]["x"] = -78;
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mapframe"]["y"] = -18;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autodock"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autodock"] = true;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mbf"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mbf"] = true;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mbf"] == true) then
			fakemapframe:Show();
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["flash"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["flash"] = true;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autoopen"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autoopen"] = false;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["showdone"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["showdone"] = true;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popframe"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popframe"] = {};
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popframe"]["x"] = 0;
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popframe"]["y"] = 0;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autohide"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autohide"] = false;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["disable"] == nil) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["disable"] = false;
		end
	elseif (event == "PLAYER_REGEN_ENABLED") then
		eframe.incombat = false;
	elseif (event == "PLAYER_REGEN_DISABLED") then
		eframe.incombat = true;
	end
end);

eframe:HookScript("OnUpdate", function(self, event, arg1, arg2)
	if (GetTime() - eframe.lastupdate < .250) then
		return;
	end
	eframe.lastupdate = GetTime();
	oframe.refresh(false);
end);

------------------------------------------------------------------------------------------------------------------------------------------------------------------

function oframe.buildtooltip(tooltip)
	tooltip:SetFrameStrata("TOOLTIP");
	tooltip:SetToplevel(true);
	tooltip:SetText("|cff00FF00"..eframe.version.."|r");
	tooltip:AddLine("|cffFF0000Click: |cffFFFFFFQueue\n|cffFF0000Shift+Click: |cffFFFFFFUnqueue All\n|cffFF0000Right Click: |cffFFFFFFToggle GUI\n|cffFF0000Shift+Right Click: |cffFFFFFFOpen Options\n|cffFF0000Alt+Click: |cffFFFFFFDisable|r");
end

function oframe.onclick(which, button)
	if (button == "LeftButton" and IsShiftKeyDown() == true) then
		LeaveLFG(LE_LFG_CATEGORY_LFD);
		LeaveLFG(LE_LFG_CATEGORY_RF);
		oframe.refresh(false);
	elseif (button == "LeftButton" and IsAltKeyDown() == true) then
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["disable"] == true) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["disable"] = false;
		else
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["disable"] = true;
		end
		oframe.refresh(false);
	elseif (button == "LeftButton") then
		oframe.refresh(true);
	elseif (button == "RightButton" and IsShiftKeyDown() == true) then
		Settings.OpenToCategory("bobSatchels");	-- DEBUG_NOTE: `InterfaceOptionsFrame_OpenToCategory` was deprecated in 10.0.0.
		Settings.OpenToCategory("bobSatchels");	-- DEBUG_NOTE: `InterfaceOptionsFrame_OpenToCategory` was deprecated in 10.0.0.
		oframe.refresh(false);
	elseif (button == "RightButton") then
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["show"] == true) then
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["show"] = false;
		else
			bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["show"] = true;
		end
		oframe.refresh(false);
	end
end

function bobSatchelsQueueLogic(doqueue, rewards)
	for i, v in pairs(oframe.queues) do
		oframe.buildqueue = false;
		if (oframe.queues[i]["queued"] == false and oframe.queues[i]["cat"] == LE_LFG_CATEGORY_LFD and GetLFGDeserterExpiration() == nil and oframe.queue.lfd < 1 and oframe.queue.count <= 5) then
			oframe.buildqueue = true;
		elseif (oframe.queues[i]["queued"] == false and oframe.queues[i]["cat"] == LE_LFG_CATEGORY_RF and GetLFGDeserterExpiration() == nil and oframe.queue.count <= 5) then
			oframe.buildqueue = true;
		end
		oframe.qtank = false;
		oframe.qhealer = false;
		oframe.qdamage = false;

		oframe.dothisqueue = false;
		if (oframe.buildqueue == true) then
			if (not IsLFGDungeonJoinable(i)) then
			elseif ( oframe.queues[i]["cat"] == LE_LFG_CATEGORY_LFD and not LFD_IsEmpowered()) then
			elseif ( oframe.queues[i]["cat"] == LE_LFG_CATEGORY_RF and not RaidBrowser_IsEmpowered()) then
			elseif (rewards == true and not GetLFGDungeonRewardInfo(i, 1)) then
			else
				if (oframe.queues[i]["showtank"] == true and bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["tank"] == true) then
					oframe.doanyqueue = true;
				end
				if (oframe.queues[i]["tank"] == true and bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["tank"] == true) then
					oframe.doqueuealert = true;
					oframe.qtank = true;
					oframe.dothisqueue = true;
				end
				if (oframe.queues[i]["showhealer"] == true and bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["healer"] == true) then
					oframe.doanyqueue = true;
				end
				if (oframe.queues[i]["healer"] == true and bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["healer"] == true) then
					oframe.doqueuealert = true;
					oframe.qhealer = true;
					oframe.dothisqueue = true;
				end
				if (oframe.queues[i]["showdamage"] == true and bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["damage"] == true) then
					oframe.doanyqueue = true;
				end
				if (oframe.queues[i]["damage"] == true and bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["damage"] == true) then
					oframe.doqueuealert = true;
					oframe.dothisqueue = true;
					oframe.qdamage = true;
				end
			end
			if (oframe.dothisqueue == true and doqueue == false) then
				if (oframe.nqueue == 1 and qframe.queue1.ID ~= i and qframe.queue2.ID ~= i and qframe.queue3.ID ~= i) then
					qframe.queue1.ID = i;
					oframe.nqueue = 2;
				elseif (oframe.nqueue == 2 and qframe.queue1.ID ~= i and qframe.queue2.ID ~= i and qframe.queue3.ID ~= i) then
					qframe.queue2.ID = i;
					oframe.nqueue = 3;
				elseif (oframe.nqueue == 3 and qframe.queue1.ID ~= i and qframe.queue2.ID ~= i and qframe.queue3.ID ~= i) then
					qframe.queue3.ID = i;
					oframe.nqueue = 4;
				end
			end
			if (oframe.dothisqueue == true and doqueue == true) then
				oframe.maxqueue = oframe.maxqueue - 1;
				if (oframe.maxqueue > 0 ) then
					ClearAllLFGDungeons(oframe.queues[i]["cat"]);
					SetLFGDungeon(oframe.queues[i]["cat"], i);

					-- force queue for all roles that are checked, will give a satchel
					oframe.queues[i]["qforced"] = true;
					oframe.qtank = bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["tank"];
					oframe.qhealer = bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["healer"];
					oframe.qdamage = bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["damage"];


					SetLFGRoles(true, oframe.qtank, oframe.qhealer, oframe.qdamage);
					if (oframe.queues[i]["cat"] == LE_LFG_CATEGORY_LFD) then
						LFDFrame_DisplayDungeonByID(i);
					elseif (oframe.queues[i]["cat"] == LE_LFG_CATEGORY_RF) then
						LFG_UpdateQueuedList();
						LFG_UpdateAllRoleCheckboxes();
					end
					SetLFGRoles(true, oframe.qtank, oframe.qhealer, oframe.qdamage);
					JoinLFG(oframe.queues[i]["cat"], i);
					oframe.queuelastid = i;
					oframe.lastalert = 0;
					oframe.queuelastqueue = GetTime();
					oframe.queue.wait = oframe.queue.wait + 1;
					oframe.queue.lastcount = oframe.queue.count;
				end
			end
		end
	end
end

function oframe.refresh(doqueue)
	oframe.ldb.text = oframe.queue:GetText();
	if (doqueue == false and GetTime() - eframe.lastpoll > LFD_STATISTIC_CHANGE_TIME and eframe.incombat == false) then
		RequestLFDPlayerLockInfo();
		eframe.lastpoll = GetTime();
		return;
	end

	mapframe:UnlockHighlight();
	fakemapframe:UnlockHighlight();

	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popup"] == false) then
		qframe:Hide();
	end

	if (doqueue == false and (GetTime() - oframe.bagtime) > 3 and bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autoopen"] == true) then
		oframe.bagdone = false;
		for i = 0, NUM_BAG_SLOTS, 1 do	-- DEBUG_NOTE: prefer `NUM_BAG_SLOTS` over `4`
			for j = 0, C_Container.GetContainerNumSlots(i), 1 do	-- DEBUG_NOTE: `GetContainerNumSlots` deprecated in 10.0.0
				if (oframe.bagdone == false and C_Container.GetContainerItemID(i, j)) then	-- DEBUG_NOTE: `GetContainerItemID` deprecated in 10.0.0
					for k, l in pairs (oframe.queues) do
						if (oframe.queues[k]["rewardid"] and oframe.queues[k]["rewardid"] ~= "") then
							if (tostring(C_Container.GetContainerItemID(i, j)) == tostring(oframe.queues[k]["rewardid"])) then	-- DEBUG_NOTE: `GetContainerItemID` deprecated in 10.0.0
								C_Container.UseContainerItem(i, j);	-- DEBUG_NOTE: `UseContainerItem` deprecated in 10.0.0
								oframe.bagdone = true;
							end
						end
					end
				end
			end
		end
		oframe.bagtime = GetTime();
	end
	oframe.queue:Enable();
	oframe.skiprewards = false;
	oframe.hasrewards = false;
	if (oframe.rebuild == true) then
		for i, v in pairs (aframe.rows) do
			v.ID = nil;
			v:SetBackdropColor(0, 0, 0, 0);
		end
		aframe.height = 30;
		aframe:SetHeight(aframe.height);
		oframe.height = 30;
		oframe:SetHeight(oframe.height);
		oframe.rebuild = false;
		aframe.lastrow = aframe.header;
		oframe.final = false;
		oframe.queues = {};
	end
	if (GetNumRandomDungeons() > 0) then
		for i = 1, GetNumRandomDungeons(), 1 do
			oframe.instanceID, oframe.instanceName, _, _, _, _, _, oframe.expansionLevel = GetLFGRandomDungeonInfo(i);
			oframe.BuildOptions(LE_LFG_CATEGORY_LFD);
		end
	end
	if (GetNumRFDungeons() > 0) then
		for i = 1, GetNumRFDungeons(), 1 do
			oframe.instanceID, oframe.instanceName = GetRFDungeonInfo(i);
			oframe.BuildOptions(LE_LFG_CATEGORY_RF);
		end
	end
	oframe.final = true;
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["rewards"] == true and oframe.hasrewards == false) then
		oframe.skiprewards = true;
	end
	oframe.queue.count = 0;
	oframe.queue.lfd = 0;
	oframe.queue.rf = 0;
	for i, v in pairs(oframe.queues) do
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["rewards"] == true and oframe.skiprewards == true) then
			_, oframe.tank, oframe.healer, oframe.damage = GetLFGRoleShortageRewards(i, 1);
			oframe.queues[i]["tank"] = oframe.tank;
			oframe.queues[i]["healer"] = oframe.healer;
			oframe.queues[i]["damage"] = oframe.damage;
			if (not GetLFGDungeonShortageRewardInfo(i, 1, 1)) then
				oframe.queues[i]["tank"] = false;
				oframe.queues[i]["healer"] = false;
				oframe.queues[i]["damage"] = false;
			end
		end
		if (oframe.queues[i]["cat"] == LE_LFG_CATEGORY_LFD and oframe.queues[i]["queued"] == true) then
			oframe.queue.count = oframe.queue.count + 1;
			oframe.queue.lfd = oframe.queue.lfd + 1;		
		elseif (oframe.queues[i]["cat"] == LE_LFG_CATEGORY_RF and oframe.queues[i]["queued"] == true) then
			oframe.queue.count = oframe.queue.count + 1;
			oframe.queue.rf = oframe.queue.rf + 1;
		end
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][i]["qdata"] = oframe.queues[i];
	end
	if (oframe.dragging == false and mapframe.dragging == false and qframe.dragging == false) then
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["minimap"] == true) then
			mapframe:Show();
		else
			mapframe:Hide();
		end
		mapframe:ClearAllPoints();
		mapframe:SetPoint("CENTER", bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mapframe"]["x"], bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["mapframe"]["y"]);
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autodock"] == true) then
			if (oframe.docked == false) then
				GameTooltip:SetOwner(mapframe, "ANCHOR_BOTTOMLEFT");
				oframe.buildtooltip(GameTooltip);
				local p, rT, rP, x, y = GameTooltip:GetPoint();
				oframe:ClearAllPoints();
				oframe:SetPoint(p, rT, rP, x, y);
				oframe:StartMoving();
				oframe:StopMovingOrSizing();
				oframe.dragging = false;
				p, rT, rP, x, y = oframe:GetPoint();
				bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"] = {};
				bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["p"] = p;
				bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["rP"] = rP;
				bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["x"] = x;
				bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["y"] = y;
				GameTooltip:Hide();
			end
			oframe.docked = true;
			oframe:RegisterForDrag("");
		else
			oframe.docked = false;
			oframe:RegisterForDrag("LeftButton");
		end
		oframe:ClearAllPoints();
		oframe:SetPoint(bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["p"], UIParent, bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["rP"], bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["x"], bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["y"]);
		qframe:ClearAllPoints();
		qframe:SetPoint("CENTER", UIParent, "CENTER", bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popframe"]["x"], bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popframe"]["y"]);
	end
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["show"] == true) then
		if (oframe:IsShown() == false and eframe.incombat == false) then
			PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN);
		end
		oframe:Show();
	end
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["show"] == false) then
		if (oframe:IsShown() == true and eframe.incombat == false) then
			PlaySound(SOUNDKIT.IG_CHARACTER_INFO_CLOSE);
		end
		oframe:Hide();
	end
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["minimize"] == true) then
		if (aframe:IsShown() == true) then
			aframe:Hide();
		end
		oframe.minimize:SetText("+");
	end
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["minimize"] == false) then
		if (aframe:IsShown() == false) then
			aframe:Show();
		end
		oframe.minimize:SetText("-");
	end
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autohide"] == true and eframe.incombat == true) then
		oframe.queue:SetText("Combat...");
		oframe.queue:Disable();
		qframe:Hide();
		oframe:Hide();
		aframe:Hide();
	end
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["disable"] == true) then
		oframe.queue:SetText("Disabled...");
		oframe.queue:Disable();
		qframe:Hide();
		return;
	end
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["autohide"] == true and eframe.incombat == true) then
		return;
	end
	if (IsInLFGDungeon() == true and IsLFGComplete() == false) then
		oframe.queue:SetText("Paused...");
		oframe.queue:Disable();
		qframe:Hide();
		return;
	end
	if (oframe.queues[oframe.queuelastid] and oframe.queues[oframe.queuelastid]["queued"] == true) then
		if (GetTime() - oframe.queuelastqueue > oframe.queue.wait) then
			oframe.queuelastid = 0;
		end
	end
	if (oframe.queue.count ~= oframe.queue.lastcount) then
		oframe.queue.lastcount = oframe.queue.count;
		oframe.queue.wait = 0;
	end
	if (GetTime() - oframe.queuelastqueue < oframe.queue.wait and oframe.queuelastid ~= 0) then
		oframe.queue:SetText("Wait "..tostring(ceil(oframe.queue.wait - tonumber(GetTime() - oframe.queuelastqueue))).."...");
		oframe.queue:Disable();
		qframe:Hide();
		return;
	end

	oframe.queuelastqueue = GetTime();
	oframe.queuelastid = 0;
	oframe.doqueuealert = false;
	oframe.maxqueue = 2;
	oframe.nqueue = 1;
	qframe.queue1.ID = nil;
	qframe.queue2.ID = nil;
	qframe.queue3.ID = nil;
	oframe.doanyqueue = false;
	bobSatchelsQueueLogic(doqueue, true);
	bobSatchelsQueueLogic(doqueue, false);
	if (oframe.doqueuealert == true) then
		oframe.queue:SetText("Queue!");
		oframe.queue:Enable();

		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["flash"] == true) then
			if ((GetTime() - mapframe.lastflash) > 2) then
				mapframe.lastflash = GetTime();
			elseif ((GetTime() - mapframe.lastflash) > 1) then
				mapframe:LockHighlight();
				fakemapframe:LockHighlight();
			end
		end

		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["popup"] == true) then
			qframe:Show();
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["alert"] == true or bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["flashalert"] == true) then
			if (GetTime() - oframe.lastalert < 15) then
				return;
			end
			oframe.lastalert = GetTime();
			if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["flashalert"] == true) then
				FlashClientIcon();
			end
			if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["alert"] == true) then
				PlaySoundFile("Interface\\Addons\\bobSatchels\\bobSatchels.mp3", "Master");
			end
		end
		return;
	end
	oframe.lastalert = 0;
	if (oframe.queue.count == 6) then
		oframe.queue:SetText("Max Queued!");
		oframe.queue:Disable();
		qframe:Hide();
	else
		oframe.queue:SetText("Done!");
		oframe.queue:Disable();
		qframe:Hide();
	end
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["rewards"] == true and oframe.queue.count <= 5 and oframe.queue.lfd <= 1) then
		if (oframe.skiprewards == false and oframe.doanyqueue == true) then
			oframe.queue:SetText("Rewards...");
			oframe.queue:Disable();
			qframe:Hide();
		end
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------

oframe:HookScript("OnDragStart", function(self)
	oframe.dragging = true;
	self:StartMoving();
end);

oframe:HookScript("OnDragStop", function(self)
	self:StopMovingOrSizing();
	oframe.dragging = false;
	local p, rT, rP, x, y = self:GetPoint();
	bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"] = {};
	bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["p"] = p;
	bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["rP"] = rP;
	bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["x"] = x;
	bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["oframe"]["y"] = y;
	self:ClearAllPoints();
	self:SetPoint(p, UIParent, rP, x, y);
end);

------------------------------------------------------------------------------------------------------------------------------------------------------------------

oframe.close = CreateFrame("Button", nil, oframe, "UIPanelButtonTemplate");
oframe.close:SetPoint("TOPLEFT", oframe, "TOPLEFT", 0, 0);
oframe.close:SetWidth(30);
oframe.close:SetHeight(30);
oframe.close:SetText("X");

oframe.close:HookScript("OnClick", function(self)
	bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["show"] = false;
	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_CLOSE);
	oframe:Hide();
end);

oframe.about = oframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
oframe.about:SetWidth(100);
oframe.about:SetHeight(30);
oframe.about:SetPoint("TOPLEFT", oframe.close, "TOPRIGHT", 0, 0);
oframe.about:SetJustifyH("CENTER");
oframe.about:SetJustifyV("CENTER");
oframe.about:SetText(eframe.version);
oframe.about:SetVertexColor(ITEM_QUALITY_COLORS[6].r,ITEM_QUALITY_COLORS[6].g,ITEM_QUALITY_COLORS[6].b,1);

oframe.options = CreateFrame("Button", nil, oframe, "UIPanelButtonTemplate");
oframe.options:SetPoint("TOPLEFT", oframe.about, "TOPRIGHT", 0, 0);
oframe.options:SetWidth(80);
oframe.options:SetHeight(30);
oframe.options:SetText("Options");

oframe.options:HookScript("OnClick", function(self)
	Settings.OpenToCategory("bobSatchels");	-- DEBUG_NOTE: `InterfaceOptionsFrame_OpenToCategory` was deprecated in 10.0.0.
	Settings.OpenToCategory("bobSatchels");	-- DEBUG_NOTE: `InterfaceOptionsFrame_OpenToCategory` was deprecated in 10.0.0.
end);

oframe.queue = CreateFrame("Button", "bobSatchelsQueue", oframe, "UIPanelButtonTemplate");
oframe.queue:SetPoint("TOPLEFT", oframe.options, "TOPRIGHT", 0, 0);
oframe.queue:SetWidth(80);
oframe.queue:SetHeight(30);
oframe.queue:SetText("Loading...");
oframe.queue.wait = 0;
oframe.queue.count = 0;
oframe.queue.lastcount = 0;

oframe.queue:HookScript("OnClick", function(self)
	oframe.refresh(true);
end);

oframe.minimize = CreateFrame("Button", nil, oframe, "UIPanelButtonTemplate");
oframe.minimize:SetPoint("TOPLEFT", oframe.queue, "TOPRIGHT", 10, 0);
oframe.minimize:SetWidth(30);
oframe.minimize:SetHeight(30);
oframe.minimize:SetText("-");

oframe.minimize:HookScript("OnClick", function(self)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["minimize"] == true) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["minimize"] = false;
	else
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["minimize"] = true;
	end
	oframe.refresh(false);
end);

------------------------------------------------------------------------------------------------------------------------------------------------------------------

aframe.header = CreateFrame("Frame", nil, aframe, "BackdropTemplate");
bobSatchelsHeader(aframe.header, aframe, aframe.width, aframe.height, true, "Check every role that you are willing to queue for...");
aframe.lastrow = aframe.header;

------------------------------------------------------------------------------------------------------------------------------------------------------------------

function bobSatchelsRoleButtonOnClick(self, rolenum, role)
	if (self.ID == nil) then return; end
	if (oframe.queues[self.ID] == nil) then return; end

	if (select(rolenum, UnitGetAvailableRoles("player")) == false) then
		self:SetChecked(false);
		return;
	end
	if (oframe.queues[self.ID]["queued"] == true) then
		if (self:GetChecked() == true) then
			self:SetChecked(false);
		else
			self:SetChecked(true);
		end
		return;
	end
	if (self:GetChecked()) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][self.ID][role] = true;
	else
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][self.ID][role] = false;
	end
	oframe.refresh(false);
end

function bobSatchelsRoleButtonOnUpdate(self, rolenum, role)
	if (self.ID == nil) then return; end
	if (oframe.queues[self.ID] == nil) then return; end

	if (oframe.queues[self.ID]["show"..role] == true) then
		self:LockHighlight();
		self:SetAlpha(1);
	else
		self:UnlockHighlight();
		self:SetAlpha(0.50);
	end
	if (select(rolenum, UnitGetAvailableRoles("player")) == false) then
		self:SetCheckedTexture("");
		self:ClearNormalTexture();
		self:SetNormalTexture(READY_CHECK_NOT_READY_TEXTURE);
		return;
	end
	
	-- DEBUG_NOTE: CheckButton textures were broken. Toggling checked state
	--             on/off or off/on depending on their state "fixes" the
	--             problem... it works now but investigation needed?
	self:SetCheckedTexture(READY_CHECK_READY_TEXTURE);
	if (self:GetChecked() == true) then
		self:SetChecked(false);
		self:SetChecked(true);
	elseif (self:GetChecked() == false) then
		self:SetChecked(true);
		self:SetChecked(false);
	end
	-- -- -- -- --
	
	self:ClearNormalTexture();
	self:SetNormalTexture("Interface\\Buttons\\UI-Button-Outline");
	reward = false;
	if (oframe.queues[self.ID]["stank"] == true or oframe.queues[self.ID]["shealer"] == true or oframe.queues[self.ID]["sdamage"] == true) then
		reward = true;
	end

	if (oframe.queues[self.ID]["queued"] == true and oframe.queues[self.ID]["q"..role] == true and reward == true) then
		self:LockHighlight();
		self:SetAlpha(1);
		self:SetCheckedTexture("");
		self:ClearNormalTexture();
		self:SetNormalTexture( tonumber(oframe.queues[self.ID]["reward"]) ); -- DEBUG_NOTE: passing string value confusing `SetNormalTexture` so convert to number
	elseif (oframe.queues[self.ID]["queued"] == true and oframe.queues[self.ID]["q"..role] == true and reward == false) then
		self:SetCheckedTexture("");
		self:ClearNormalTexture();
		self:SetNormalTexture(READY_CHECK_NOT_READY_TEXTURE);
	end

end

------------------------------------------------------------------------------------------------------------------------------------------------------------------

function oframe.LFG_IsRandomDungeonDisplayable(id)
	local name, typeID, subtypeID, minLevel, maxLevel, _, _, _, expansionLevel, _, _, _, _, _, _, _, _, isTimewalker = GetLFGDungeonInfo(id);
	local myLevel = UnitEffectiveLevel("player");
	return ((myLevel >= minLevel and myLevel <= maxLevel and EXPANSION_LEVEL >= expansionLevel) or isTimewalker);
end

function oframe.BuildOptions(category)
	oframe.isAvailable, oframe.isAvailableToPlayer, oframe.hideIfUnmet = IsLFGDungeonJoinable(oframe.instanceID);
	if (((oframe.hideIfUnmet or not oframe.isAvailable) and (not oframe.isAvailable or not oframe.isAvailableToPlayer)) or (not oframe.LFG_IsRandomDungeonDisplayable(oframe.instanceID))) then
		for i, v in pairs (aframe.rows) do
			if (v.ID == oframe.instanceID) then
				if (v:IsVisible()) then
					oframe.rebuild = true;
				end
	
			end
		end
		return;
	end

	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][oframe.instanceID] == nil) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][oframe.instanceID] = {};
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][oframe.instanceID]["tank"] = false;
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][oframe.instanceID]["healer"] = false;
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][oframe.instanceID]["damage"] = false;
	end
	if (select(1, UnitGetAvailableRoles("player")) == false) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][oframe.instanceID]["tank"] = false;
	end
	if (select(2, UnitGetAvailableRoles("player")) == false) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][oframe.instanceID]["healer"] = false;
	end
	if (select(3, UnitGetAvailableRoles("player")) == false) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][oframe.instanceID]["damage"] = false;
	end
	oframe.showtank = false;
	oframe.showhealer = false;
	oframe.showdamage = false;
	oframe.rewardtexture = "";
	oframe.rewardid = "";
	oframe.currencyname = "";
	oframe.currency = "";
	oframe.currencyid = "";
	_, oframe.tank, oframe.healer, oframe.damage, oframe.items = GetLFGRoleShortageRewards(oframe.instanceID, 1);
	for i = 1, select(6, GetLFGDungeonRewards(oframe.instanceID)), 1 do
		if (select(1, GetLFGDungeonRewardInfo(oframe.instanceID, i)) ~= "" and select(2, GetLFGDungeonRewardInfo(oframe.instanceID, i)) ~= "Interface\\Icons\\inv_garrison_resource") then
			oframe.currencyname = tostring(select(1, GetLFGDungeonRewardInfo(oframe.instanceID, i)));
			oframe.currency = tostring(select(2, GetLFGDungeonRewardInfo(oframe.instanceID, i)));
			if (oframe.currency ~= "") then
				oframe.currencyid = GetLFGDungeonRewardLink(oframe.instanceID, i);
			end
		end
	end
	if (not GetLFGDungeonShortageRewardInfo(oframe.instanceID, 1, 1)) then
		oframe.tank = false;
		oframe.healer = false;
		oframe.damage = false;
	else
		oframe.rewardtexture = select(2, GetLFGDungeonShortageRewardInfo(oframe.instanceID, 1, 1));
		if (oframe.rewardtexture ~= "") then
			oframe.rewardid = GetLFGDungeonShortageRewardLink(oframe.instanceID, 1, 1);
		end
	end
	oframe.showtank = oframe.tank;
	oframe.showhealer = oframe.healer;
	oframe.showdamage = oframe.damage;
	if (category == LE_LFG_CATEGORY_RF and GetLFGDungeonRewardInfo(oframe.instanceID, 1)) then
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][oframe.instanceID]["tank"] == true) then
			oframe.hasrewards = true;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][oframe.instanceID]["healer"] == true) then
			oframe.hasrewards = true;
		end
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][oframe.instanceID]["damage"] == true) then
			oframe.hasrewards = true;
		end
	end
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["rewards"] == true and (not GetLFGDungeonRewardInfo(oframe.instanceID, 1))) then
		oframe.tank = false;
		oframe.healer = false;
		oframe.damage = false;
	end

	if (not oframe.queues[oframe.instanceID] and oframe.final == true) then
		oframe.rebuild = true;
		return;
	end

	if (not oframe.queues[oframe.instanceID]) then
		aframe.row = CreateFrame("Frame", nil, aframe, "BackdropTemplate");
		bobSatchelsRow(aframe.row, aframe.lastrow, aframe.width, aframe.height, true);
		aframe.lastrow = aframe.row;
		aframe.row.ID = oframe.instanceID;
		aframe.rows[oframe.instanceID] = aframe.row;
	end

	if (oframe.queues[oframe.instanceID] == nil) then
		if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][oframe.instanceID]["qdata"]) then
			oframe.queues[oframe.instanceID] = bobSatchelsSaved[UnitName("player").."-"..GetRealmName()][oframe.instanceID]["qdata"];
		else
			oframe.queues[oframe.instanceID] = {};
			oframe.queues[oframe.instanceID]["reward"] = "";		
			oframe.queues[oframe.instanceID]["rewardid"] = "";
			oframe.queues[oframe.instanceID]["qforced"] = false;
			oframe.queues[oframe.instanceID]["qtank"] = false;
			oframe.queues[oframe.instanceID]["qhealer"] = false;
			oframe.queues[oframe.instanceID]["qdamage"] = false;
			oframe.queues[oframe.instanceID]["stank"] = false;
			oframe.queues[oframe.instanceID]["shealer"] = false;
			oframe.queues[oframe.instanceID]["sdamage"] = false;
			oframe.queues[oframe.instanceID]["active"] = false;
		end
	end

	oframe.queues[oframe.instanceID]["cat"] = category;
	oframe.queues[oframe.instanceID]["name"] = oframe.instanceName;
	if (category == LE_LFG_CATEGORY_RF and bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["showdone"] == true) then
		local numEncounters, numCompleted = GetLFGDungeonNumEncounters(oframe.instanceID);
		oframe.queues[oframe.instanceID]["name"] = oframe.instanceName.." ("..numCompleted.."/"..numEncounters..")";
	end

	oframe.queues[oframe.instanceID]["tank"] = oframe.tank;
	oframe.queues[oframe.instanceID]["healer"] = oframe.healer;
	oframe.queues[oframe.instanceID]["damage"] = oframe.damage;

	oframe.queues[oframe.instanceID]["showtank"] = oframe.showtank;
	oframe.queues[oframe.instanceID]["showhealer"] = oframe.showhealer;
	oframe.queues[oframe.instanceID]["showdamage"] = oframe.showdamage;

	if (oframe.rewardtexture ~= "") then
		oframe.queues[oframe.instanceID]["reward"] = tostring(oframe.rewardtexture);
		if (oframe.rewardid and oframe.rewardid ~= "") then
			local _, _, _, _, itemid = string.find(tostring(oframe.rewardid),"|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?");
			if (itemid and tonumber(itemid) > 0) then
				oframe.queues[oframe.instanceID]["rewardid"] = tostring(itemid);
			end
		end
	end
	oframe.queues[oframe.instanceID]["currencyname"] = oframe.currencyname;
	oframe.queues[oframe.instanceID]["currency"] = tostring(oframe.currency);
	oframe.queues[oframe.instanceID]["currencyid"] = tostring(oframe.currencyid);
	_, oframe.joined, oframe.queued, _, _, _, _, _, _, oframe.qtank, oframe.qhealer, oframe.qdamage = GetLFGInfoServer(category, oframe.instanceID);
	oframe.queues[oframe.instanceID]["queued"] = false;

	if (oframe.joined == true or oframe.queued == true) then
		oframe.queues[oframe.instanceID]["queued"] = true;
		oframe.queues[oframe.instanceID]["qtank"] = oframe.qtank;
		oframe.queues[oframe.instanceID]["qhealer"] = oframe.qhealer;
		oframe.queues[oframe.instanceID]["qdamage"] = oframe.qdamage;
	end
	oframe.queues[oframe.instanceID]["active"] = false;
	if (GetPartyLFGID() ~= nil and IsLFGComplete() == false) then
		if (select(1, GetPartyLFGID()) == oframe.instanceID) then
			oframe.queues[oframe.instanceID]["qforced"] = false;
			oframe.queues[oframe.instanceID]["queued"] = true;
			oframe.queues[oframe.instanceID]["active"] = true;
		elseif (select(2, GetPartyLFGID()) == oframe.instanceID) then
			oframe.queues[oframe.instanceID]["qforced"] = false;
			oframe.queues[oframe.instanceID]["queued"] = true;
			oframe.queues[oframe.instanceID]["active"] = true;
		end
	end
	if (oframe.queues[oframe.instanceID]["queued"] == true) then
		if (oframe.queues[oframe.instanceID]["qtank"] == true and oframe.queues[oframe.instanceID]["showtank"] == true) then
			oframe.queues[oframe.instanceID]["stank"] = true;
		end
		if (oframe.queues[oframe.instanceID]["qhealer"] == true and oframe.queues[oframe.instanceID]["showhealer"] == true) then
			oframe.queues[oframe.instanceID]["shealer"] = true;
		end
		if (oframe.queues[oframe.instanceID]["qdamage"] == true and oframe.queues[oframe.instanceID]["showdamage"] == true) then
			oframe.queues[oframe.instanceID]["sdamage"] = true;
		end
	else
		oframe.queues[oframe.instanceID]["stank"] = false;
		oframe.queues[oframe.instanceID]["shealer"] = false;
		oframe.queues[oframe.instanceID]["sdamage"] = false;
		oframe.queues[oframe.instanceID]["active"] = false;
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------

if (LibStub and LibStub:GetLibrary("LibDataBroker-1.1")) then
	oframe.ldb = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("bobSatchels", {
		type	= "data source",
		icon	= "133658",
		label	= "bobSatchels",
		text	= "Loading..."
	});
	oframe.ldb.OnClick = function(self, button)
		oframe.onclick("LDB", button);
	end
	oframe.ldb.OnTooltipShow = function(tooltip)
		oframe.buildtooltip(tooltip);
		tooltip:Show();
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------

SLASH_BOBSATCHELS1 = "/bs"
SLASH_BOBSATCHELS2 = "/bobs"
SLASH_BOBSATCHELS3 = "/bobsatchels"
SlashCmdList["BOBSATCHELS"] = function(msg)
	if (bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["show"] == true) then
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["show"] = false;
	else
		bobSatchelsSaved[UnitName("player").."-"..GetRealmName()]["show"] = true;
	end
end
