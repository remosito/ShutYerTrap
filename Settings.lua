local LAM = LibAddonMenu2

local entry
local entries


function SYT.CreateSettings()
	local panelName = "Shut Yer Trap"

	local panelData = {
	   type = "panel",
		name = panelName,
		displayName = "Shut Yer Trap",
		author = "remosito",
		registerForRefresh = true,
		registerForDefaults = false,
	}
	local panel = LAM:RegisterAddonPanel(panelName, panelData)
	entries = { 
		{ type = "header", name = SYT.S_SETTINGS_HEADER, },
		{ type = "description",	text = SYT.S_SETTINGS_DESC,},
	}
	entry = {}
	SYT.DropDown = { 
		type = "dropdown",  
		name = SYT.S_SETTINGS_DROPDOWN_NAME,  
		tooltip = SYT.S_SETTINGS_DROPDOWN_TOOLTIP,  
		choices = {},  
		choicesValues = {}, 
		getFunc = function() 
			SYTDropdown:UpdateChoices() 
			return 1 
		end,  
		setFunc = function(var) 
			SYT.CurrentChoice = var 
		end, 
		reference = "SYTDropdown",
	}	
	table.insert(entries, SYT.DropDown)
	entry = { 
		type = "button", 
		name = SYT.S_SETTINGS_MUTENPC_NAME, 
		tooltip = SYT.S_SETTINGS_MUTENPC_TOOLTIP, 
		func = function() 
			if not SYT.SV.Muted[SYT.Chatter[SYT.CurrentChoice][1]] then 
				SYT.SV.Muted[SYT.Chatter[SYT.CurrentChoice][1]] = {}
			end
			SYT.SV.Muted[SYT.Chatter[SYT.CurrentChoice][1]]["#@ALL@#"] = true
			table.remove(SYT.Chatter, SYT.CurrentChoice) 
			table.remove(SYT.DropDown.choices,SYT.CurrentChoice) 
			table.remove(SYT.DropDown.choicesValues,SYT.CurrentChoice) 
		end,  
		disabled = function() return #SYT.Chatter == 0 end,
		width = "half", 
	}
	table.insert(entries, entry)
	entry = { 
		type = "button", 
		name = SYT.S_SETTINGS_MUTEDIALOGUE_NAME, 
		tooltip = SYT.S_SETTINGS_MUTEDIALOGUE_TOOLTIP, 
		func = function() 
			if not SYT.SV.Muted[SYT.Chatter[SYT.CurrentChoice][1]] then 
				SYT.SV.Muted[SYT.Chatter[SYT.CurrentChoice][1]] = {}
			end
			SYT.SV.Muted[SYT.Chatter[SYT.CurrentChoice][1]][SYT.Chatter[SYT.CurrentChoice][2]] = true 
			table.remove(SYT.Chatter, SYT.CurrentChoice) 
			table.remove(SYT.DropDown.choices,SYT.CurrentChoice) 
			table.remove(SYT.DropDown.choicesValues,SYT.CurrentChoice) 
		end,  
		disabled = function() return #SYT.Chatter == 0 end,
		width = "half", 
	}
	table.insert(entries, entry)
	entry = { type = "header", name = SYT.S_SETTINGS_SAVEDVARS_HEADER, }
	table.insert(entries, entry)
	entry = { type = "description", text = SYT.S_SETTINGS_SAVEDVARS_DESCRIPTION, }
	table.insert(entries, entry)
	LAM:RegisterOptionControls(panelName, entries)
end