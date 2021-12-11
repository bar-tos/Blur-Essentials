function es_makeGUI(parent, settings)
	local type = settings["Type"]
	local newGUI = nil
	if parent == "root" then -- GUI
		newGUI = GUI.new(type)
	else -- GUIObject
		if parent and parent["addObject"] then
			newGUI = GUI.newObject(type)
			if (settings["Shown"] == nil or settings["Shown"] == true) then
				parent:addObject(newGUI)
			end
		else
			log("ESSENTIALS", "Couldn't find GUI of name: " .. parent, LOG_ERROR)
		return end
	end
	for k,v in pairs(settings) do
		if k == "Font" then -- Fonts need to be set with a method
			newGUI:setFont(settings["Font"][1], settings["Font"][2])
		elseif not (k == "Type" or k == "Visible") then
			newGUI[k] = v
		end
	end
	if settings["Enabled"] ~= nil and settings["Enabled"] == true then
		GUI.register(newGUI)
	end
	return newGUI
end