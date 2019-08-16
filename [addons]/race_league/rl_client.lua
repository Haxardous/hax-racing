--init
local s_x, s_y = guiGetScreenSize()
local text_offset = 20
local teams = {}
local c_round = 0
local m_round = 0
local f_round = false
local team_choosen = false
local isAdmin = false

-----------------
-- Call functions
-----------------
function serverCall(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do
            if (type(value) == "number") then arg[key] = tostring(value) end
        end
    end
    triggerServerEvent("onClientCallsServerFunction", resourceRoot , funcname, unpack(arg))
end

function clientCall(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do arg[key] = tonumber(value) or value end
    end
    loadstring("return "..funcname)()(unpack(arg))
end
addEvent("onServerCallsClientFunction", true)
addEventHandler("onServerCallsClientFunction", resourceRoot, clientCall)


------------------------
-- DISPLAY
------------------------
function updateDisplay()
	--score
	local fontda = dxCreateFont(":race/fonts/arialbold.ttf", 10)
	if isElement(teams[1]) and isElement(teams[2]) then
		if not f_round then
			local r1, g1, b1 = getTeamColor(teams[1])
			local r2, g2, b2 = getTeamColor(teams[2])
			dxDrawRectangle(s_x-187.5, 60, 122.5, 135, tocolor(0, 0, 0, 150))
			dxDrawText('Round ' ..c_round.. ' of ' ..m_round, s_x-127.5, 135, s_x-127.5, 135, tocolor ( 255, 255, 150, 255 ), 1, fontda, 'center', 'center')
			if tonumber(getElementData(teams[1], 'Score')) > tonumber(getElementData(teams[2], 'Score')) then
				dxDrawText(getTeamName(teams[1]).. ' - ' ..getElementData(teams[1], 'Score'), s_x-127.5, 140+text_offset, s_x-127.5, 140+text_offset, tocolor ( r1, g1, b1, 255 ), 1, fontda, 'center', 'center')
				dxDrawText(getTeamName(teams[2]).. ' - ' ..getElementData(teams[2], 'Score'), s_x-127.5, 140+text_offset*2, s_x-127.5, 140+text_offset*2, tocolor ( r2, g2, b2, 255 ), 1, fontda, 'center', 'center')
			elseif tonumber(getElementData(teams[1], 'Score')) < tonumber(getElementData(teams[2], 'Score')) then
				dxDrawText(getTeamName(teams[2]).. ' - ' ..getElementData(teams[2], 'Score'), s_x-127.5, 140+text_offset, s_x-127.5, 140+text_offset, tocolor ( r2, g2, b2, 255 ), 1, fontda, 'center', 'center')
				dxDrawText(getTeamName(teams[1]).. ' - ' ..getElementData(teams[1], 'Score'), s_x-127.5, 140+text_offset*2, s_x-127.5, 140+text_offset*2, tocolor ( r1, g1, b1, 255 ), 1, fontda, 'center', 'center')
			elseif tonumber(getElementData(teams[1], 'Score')) == tonumber(getElementData(teams[2], 'Score')) then
				dxDrawText(getTeamName(teams[1]).. ' - ' ..getElementData(teams[1], 'Score'), s_x-127.5, 140+text_offset, s_x-127.5, 140+text_offset, tocolor ( r1, g1, b1, 255 ), 1, fontda, 'center', 'center')
				dxDrawText(getTeamName(teams[2]).. ' - ' ..getElementData(teams[2], 'Score'), s_x-127.5, 140+text_offset*2, s_x-127.5, 140+text_offset*2, tocolor ( r2, g2, b2, 255 ), 1, fontda, 'center', 'center')
			end
		else
			dxDrawRectangle(s_x-187.5, 90, 122.5, 90, tocolor(0, 0, 0, 150))
			dxDrawText('Fun round', s_x-125, 140, s_x-127.5, 140, tocolor ( 255, 255, 255, 255 ), 0.6, fontda, 'center', 'center')
		end
	end
end

------------------------
--GUI
------------------------
local c_window

function createGUI(team1, team2) -- choose GUI
	if isElement(c_window) then
		destroyElement(c_window)
	end
	c_window = guiCreateWindow(s_x/2-150, s_y/2-75, 300, 140, 'team select', false)
	guiWindowSetMovable(c_window, false)
	guiWindowSetSizable(c_window, false)
	local t1_button = guiCreateButton(40, 35, 100, 30, team1, false, c_window)
	addEventHandler("onClientGUIClick", t1_button, team1Choosen, false)
	local t2_button = guiCreateButton(160, 35, 100, 30, team2, false, c_window)
	addEventHandler("onClientGUIClick", t2_button, team2Choosen, false)
	local t3_button = guiCreateButton(40, 85, 220, 30, 'Spectators', false, c_window)
	addEventHandler("onClientGUIClick", t3_button, team3Choosen, false)
	showCursor(true)
end

--admin GUI
local a_window

function createAdminGUI()
	if isElement(a_window) then
		destroyElement(a_window)
	end
	a_window = guiCreateWindow(s_x/2-150, s_y/2-75, 400, 250, 'Race League Admin Panel - v1.0b', false)
	guiWindowSetSizable(a_window, false)
	close_button = guiCreateButton(10, 220, 380, 30, 'C L O S E', false, a_window)
	addEventHandler("onClientGUIClick", close_button, function() guiSetVisible(a_window, false) showCursor(false) end, false)
	tab_panel = guiCreateTabPanel(0, 0.09, 1, 0.75, true, a_window)
	guiCreateLabel(270, 25, 150, 20, "Admin Panel by Vally", false, a_window)
		-- tab 1
		tab_general = guiCreateTab('General', tab_panel)
		guiCreateLabel(20, 20, 150, 20, "Team names:", false, tab_general)
		guiCreateLabel(20, 25, 150, 20, "______________", false, tab_general)
		if isElement(teams[1]) then
			t1name = getTeamName(teams[1])
		else
			t1name = 'team 1'
		end
		t1_field = guiCreateEdit(20, 45, 80, 20, t1name, false, tab_general)
		if isElement(teams[2]) then
			t2name = getTeamName(teams[1])
		else
			t2name = 'team 2'
		end
		t2_field = guiCreateEdit(20, 70, 80, 20, t2name, false, tab_general)
		guiCreateLabel(150, 20, 150, 20, "Team colors:", false, tab_general)
		guiCreateLabel(150, 25, 110, 20, "______________________", false, tab_general)
		if isElement(teams[1]) then
			t1color = getTeamColor(teams[1])
		else
			t1color = '255, 0, 0'
		end
		t1c_field = guiCreateEdit(150, 45, 110, 20, t1color, false, tab_general)
		if isElement(teams[2]) then
			t2color = getTeamColor(teams[2])
		else
			t2color = '0, 0, 255'
		end
		t2c_field = guiCreateEdit(150, 70, 110, 20, t2color, false, tab_general)
		zadat_button = guiCreateButton(280, 45, 80, 45, 'Apply', false, tab_general)
		addEventHandler("onClientGUIClick", zadat_button, zadatTeams, false)
		start_button = guiCreateButton(20, 120, 100, 25, 'Start CW', false, tab_general)
		addEventHandler("onClientGUIClick", start_button, startWar, false)
		stop_button = guiCreateButton(140, 120, 100, 25, 'Stop CW', false, tab_general)
		addEventHandler("onClientGUIClick", stop_button, function() serverCall('destroyTeams', localPlayer) end, false)
		fun_button = guiCreateButton(260, 120, 100, 25, 'Fun round', false, tab_general)
		addEventHandler("onClientGUIClick", fun_button, function() serverCall('funRound', localPlayer) end, false)
		-- tab 2
		tab_rounds = guiCreateTab('Rounds & Score', tab_panel)
		guiCreateLabel(20, 20, 150, 20, "Score:", false, tab_rounds)
		guiCreateLabel(20, 25, 150, 20, "________________", false, tab_rounds)
		tt1_name = guiCreateLabel(20, 47, 150, 20, "team 1:", false, tab_rounds)
		tt2_name = guiCreateLabel(20, 72, 150, 20, "team 2:", false, tab_rounds)
		local t1_score
		local t2_score
		if isElement(teams[1]) then t1_score = getElementData(teams[1], 'Score') else t1_score = '0' end
		if isElement(teams[2]) then t2_score = getElementData(teams[2], 'Score') else t2_score = '0' end
		t1cur_field = guiCreateEdit(85, 45, 50, 20, tostring(t1_score), false, tab_rounds)
		t2cur_field = guiCreateEdit(85, 70, 50, 20, tostring(t2_score), false, tab_rounds)
		guiCreateLabel(155, 20, 150, 20, "Rounds:", false, tab_rounds)
		guiCreateLabel(155, 25, 150, 20, "_______________", false, tab_rounds)
		guiCreateLabel(155, 47, 150, 20, "current:", false, tab_rounds)
		guiCreateLabel(155, 72, 150, 20, "total:", false, tab_rounds)
		cr_field = guiCreateEdit(220, 45, 40, 20, tostring(c_round), false, tab_rounds)
		ct_field = guiCreateEdit(220, 70, 40, 20, tostring(m_round), false, tab_rounds)
		zadat_button2 = guiCreateButton(280, 45, 80, 45, 'Apply', false, tab_rounds)
		addEventHandler("onClientGUIClick", zadat_button2, zadatScoreRounds, false)
	--	re_button = guiCreateButton(20, 120, 340, 25, 'Закончить текущий раунд', false, tab_rounds)
	--	addEventHandler('onClientGUIClick', re_button, function() triggerServerEvent('onPostFinish', getRootElement()) end, false)
	guiSetVisible(a_window, false)
end

function toogleGUI() -- choose GUI
	if isElement(c_window) then
		if guiGetVisible(c_window) then
			guiSetVisible(c_window, false)
			if not guiGetVisible(a_window) then
				showCursor(false)
			end
		elseif not guiGetVisible(c_window) then
			guiSetVisible(c_window, true)
			showCursor(true)
		end
	end
end

function toogleAdminGUI()
	if isAdmin then
		if isElement(a_window) then
			if guiGetVisible(a_window) then
				guiSetVisible(a_window, false)
				if isElement(c_window) then
					if not guiGetVisible(c_window) then
						showCursor(false)
					end
				else
					showCursor(false)
				end
			elseif not guiGetVisible(a_window) then
				updateAdminPanelText()
				guiSetVisible(a_window, true)
				showCursor(true)
			end
		end
	end
end

function updateAdminPanelText()
	if isElement(teams[1]) then
		local team1name = getTeamName(teams[1])
		local team2name = getTeamName(teams[2])
		guiSetText(t1_field, team1name)
		guiSetText(t2_field, team2name)
		local r1, g1, b1 = getTeamColor(teams[1])
		local r2, g2, b2 = getTeamColor(teams[2])
		guiSetText(t1c_field, r1.. ', ' ..g1.. ', ' ..b1)
		guiSetText(t2c_field, r2.. ', ' ..g2.. ', ' ..b2)
		local t1score = getElementData(teams[1], 'Score')
		local t2score = getElementData(teams[2], 'Score')
		guiSetText(tt1_name, team1name.. ':')
		guiSetText(tt2_name, team2name.. ':')
		guiSetText(t1cur_field, t1score)
		guiSetText(t2cur_field, t2score)
		guiSetText(cr_field, c_round)
		guiSetText(ct_field, m_round)
	end
end

------------------------
-- BUTTON FUNCTIONS
------------------------
function team1Choosen()
	serverCall('setPlayerTeam', localPlayer, teams[1])
	if not guiGetVisible(a_window) then
		showCursor(false)
	end
	guiSetVisible(c_window, false)
	outputChatBox('[Race League]: press F3 to select team again', 155, 155, 255, true)
end

function team2Choosen()
	serverCall('setPlayerTeam', localPlayer, teams[2])
	if not guiGetVisible(a_window) then
		showCursor(false)
	end
	guiSetVisible(c_window, false)
	outputChatBox('[Race League]: press F3 to select team again', 155, 155, 255, true)
end

function team3Choosen()
	serverCall('setPlayerTeam', localPlayer, teams[3])
	if not guiGetVisible(a_window) then
		showCursor(false)
	end
	guiSetVisible(c_window, false)
	outputChatBox('[Race League]: press F3 to select team again', 155, 155, 255, true)
end

function zadatScoreRounds()
	local t1score = guiGetText(t1cur_field)
	local t2score = guiGetText(t2cur_field)
	local cur_round = guiGetText(cr_field)
	local ma_round = guiGetText(ct_field)
	if isElement(teams[1]) and isElement(teams[2]) then
		setElementData(teams[1], 'Score', t1score)
		setElementData(teams[2], 'Score', t2score)
	end
	serverCall('updateRounds', cur_round, ma_round)
end

function zadatTeams()
	local t1name = guiGetText(t1_field)
	local t2name = guiGetText(t2_field)
	local t1color = guiGetText(t1c_field)
	local t2color = guiGetText(t2c_field)
	if isElement(teams[1]) and isElement(teams[2]) then
		local r1,g1,b1 = stringToNumber(t1color)
		local r2,g2,b2 = stringToNumber(t2color)
		serverCall('setTeamName', teams[1], t1name)
		serverCall('setTeamColor', teams[1], r1, g1, b1)
		serverCall('setTeamName', teams[2], t2name)
		serverCall('setTeamColor', teams[2], r2, g2, b2)
		serverCall('sincAP')
	end
end

function startWar()
	local t1name = guiGetText(t1_field)
	local t2name = guiGetText(t2_field)
	local t1color = guiGetText(t1c_field)
	local t2color = guiGetText(t2c_field)
	local r1,g1,b1 = stringToNumber(t1color)
	local r2,g2,b2 = stringToNumber(t2color)
	serverCall('startWar', t1name, t2name, r1, g1, b1, r2, g2, b2)
end

----------------------------
-- OTHER FUNCTIONS
----------------------------
function updateTeamData(team1, team2, team3)
	teams[1] = team1
	teams[2] = team2
	teams[3] = team3
	updateAdminPanelText()
end

function updateRoundData(c_r, max_r, f_r)
	if c_r == 0 then
		f_round = true
	else
		f_round = f_r
	end
	c_round = c_r
	m_round = max_r
	updateAdminPanelText()
end

function updateAdminInfo(obj)
	isAdmin = obj
	if isAdmin then
		createAdminGUI()
		outputChatBox('[Race League]: press F2 to open admin panel', 155, 155, 255, true)
	end
end

function onResStart()
	serverCall('isClientAdmin', localPlayer)
	createAdminGUI()
end

function stringToNumber(colorsString)
	local r = gettok(colorsString, 1, string.byte(','))
	local g = gettok(colorsString, 2, string.byte(','))
	local b = gettok(colorsString, 3, string.byte(','))
	if r == false or g == false or b == false then
		outputChatBox('[Race League]: use - [0-255], [0-255], [0-255]', 255, 155, 155, true)
		return 0, 255, 0
	else
		return r, g, b
	end
end
----------------------------
-- BINDS
----------------------------
createAdminGUI()
setTimer(function() if isElement(teams[1]) then createGUI(getTeamName(teams[1]), getTeamName(teams[2])) end end, 1000, 1)
bindKey('F3', 'down', toogleGUI)
bindKey('F2', 'down', toogleAdminGUI)
serverCall('playerJoin', localPlayer)

----------------------------
-- EVENT HANDLERS
----------------------------
addEventHandler('onClientRender', getRootElement(), updateDisplay)
addEventHandler('onClientResourceStart', getResourceRootElement(), onResStart)
--guiCreateLabel(30, 3, 200, 200, '*Race League script by [CsB]Vally', false)