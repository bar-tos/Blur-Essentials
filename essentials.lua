--[[
	BLUR ESSENTIALS LICENSE
	Blur Essentials is an open source project made by Bartos, it is available here: https://github.com/bar-tos/Blur-Essentials

	You are allowed to modify and redistribute this product as long as you include this license in your file.
	You are not allowed to claim this work as your own.
--]]

function es_type(object)
	if type(object) ~= "userdata" then return type(object) end 
	name = tostring(object)
	a,b = string.find(name, "Vector")
	if a and b then
		return string.lower(string.sub(name, a,b))
	end
	_,b = string.find(name, ":")
	if b then
		return string.lower(string.sub(name, 1,b-1))
	end
	return "none"
end

function es_makeGUI(parent, settings)
	local type = settings["Type"]
	local newGUI = nil
	if parent == "root" then -- GUI
		newGUI = gui.new(type)
	else -- GUIObject
		if parent and parent["addObject"] then
			newGUI = gui.newObject(type)
			if (settings["shown"] == nil or settings["shown"] == true) then
				parent:addObject(newGUI)
			end
		else
			log("ESSENTIALS", "Couldn't find GUI of name: " .. parent, LOG_ERROR)
		return end
	end
	for k,v in pairs(settings) do
		if k == "Font" then -- Fonts need to be set with a method
			newGUI:setFont(settings["Font"][1], settings["Font"][2])
		elseif not k == "Type" or k == "Visible" then
			newGUI[k] = v
		end
	end
	if settings["enabled"] ~= nil and settings["enabled"] == true then
		gui.register(newGUI)
	end
	return newGUI
end

es_lerp = function(a,b,t) return a * (1-t) + b * t end

-- ENUMS
es_EASING_LINEAR = 1
es_EASING_QUADIN = 2
es_EASING_COSINOUT = 3
es_EASING_INOUT = 4
es_EASING_INOUTFAST = 5
es_EASING_EXPONENTIAL = 6
es_EASING_BOUNCE = 7
es_EASING_OUTBACK = 8
es_EASING_INBACK = 9
es_EASING_ELASTIC = 10
local tweenStyles = {
	function(a,b,t) return a * (1-t) + b * t end,
	function(a,b,t) return es_lerp(a, b, t * t) end,
	function(a,b,t) return es_lerp(a,b,(1-math.cos(t*math.pi))/2) end,
	function(a,b,t) return es_lerp(a,b,t*t*(3-t*2)) end,
	function(a,b,t) return es_lerp(a,b,t^4*(35+t*(-84+t*(70+t*-20)))) end,
	function(a,b,t) return es_inoutfast(a,b,(1-math.exp(-8*t))/0.9996645373720975) end,
	function(a,b,t)
		t = (1-t*0.999999999)*0.5271666475893665
		return es_lerp(a,b,1-math.abs(math.cos(math.pi/t))*t^2*3.79559296602621)
	end,
	function(a,b,t)
		t = 1-t
		return es_lerp(a,b,1-t*t*(t+(t-1)*1.701540198866824))
	end,
	function(a,b,t) return es_lerp(a,b,1-(1-t)^2*(1+t*3.48050701420725)) end,
	function(a,b,t)
		return es_lerp(a,b,(1 - (math.exp(-12*t) + math.exp(-6*t) * math.cos(((6) + 0.5) * math.pi * t))/2)/0.99999692789382332858)
	end
}

local ongoingTweens = {}
local tweenIDCounter = 0

function es_tween(object, property, startPos, endPos, time, tweeningStyle, smoothness, completionCallback, startCallback)
	local tweeningStyle = tweeningStyle or es_EASING_LINEAR
	local smoothness = smoothness or 0.001
	local style = nil
	for k,v in pairs(tweenStyles) do
		if tweeningStyle == k then style = v end
	end
	
	if style then
		local tween =
		{
			ID = tweenIDCounter,
			Object = object,
			TweeningStyle = tweeningStyle,
			Smoothness = smoothness,
			Progress = 0,
			Property = property,
			StartPos = startPos,
			EndPos = endPos,
			CompletionCallback = completionCallback,
			StartCallback = startCallback
		}
		
		-- Used as a way to return the tween table without quitting the function
		if startCallback then
			startCallback(tween)
		end
		
		ongoingTweens[tweenIDCounter] = tween
		tweenIDCounter = tweenIDCounter + 1
	
		if property == "Size" then -- Tile size is bottom left corner aligned, account for that with offset
			
			for i=0,1,smoothness do
				delay(i*time, function()
					if ongoingTweens[tween["ID"]] == nil then return end
				
					tween["Progress"] = tween["Progress"] + i
				
					object[property] = Vector(style(startPos.X, endPos.X, i), style(startPos.Y, endPos.Y, i))
					object.Position = Vector(startPos.X-style(startPos.X, endPos.X, i)/2, startPos.Y-style(startPos.Y, endPos.Y, i)/2)
				
					-- Last step of the tween
					if i >= 1 - smoothness then
						ongoingTweens[tween["ID"]] = nil 
						if completionCallback then completionCallback() end
					end
				end)
			end
		else
			if es_type(object[property]) == "Vector" then
				for i=0,1,smoothness do
					delay(i*time, function()
						if ongoingTweens[tween["ID"]] == nil then return end
					
						tween["Progress"] = tween["Progress"] + i
						
						object[property] = Vector(style(startPos.X, endPos.X, i), style(startPos.Y, endPos.Y, i))
					
						-- Last step of the tween
						if i >= 1 - smoothness then
							ongoingTweens[tween["ID"]] = nil 
							if completionCallback then completionCallback() end
						end
					end)
				end
			else
				for i=0,1,smoothness do
					delay(i*time, function()
						if ongoingTweens[tween["ID"]] == nil then return end
					
						tween["Progress"] = tween["Progress"] + i
						
						object[property] = style(startPos, endPos, i)
						
						-- Last step of the tween
						if i >= 1 - smoothness then
							ongoingTweens[tween["ID"]] = nil 
							if completionCallback then completionCallback() end
						end
					end)
				end
			end
		end
	else
		log("ESSENTIALS", "Invalid tweening style: " .. tweeningStyle, LOG_ERROR)
	end
end

function es_cancelTween(id, revert)
	if ongoingTweens[id] == nil then return end

	-- Revert to the starting value if needed
	if revert then
		ongoingTweens[id].Object[ongoingTweens[id].Property] = ongoingTweens[id].StartPos
	end

	ongoingTweens[id] = nil
end