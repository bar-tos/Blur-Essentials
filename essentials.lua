function es_type(object)
	if type(object) ~= "userdata" then return type(object) end 
	name = tostring(object)
	print(name)
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
			parent:addObject(newGUI)
		else
			log("ESSENTIALS", "Couldn't find GUI of name: " .. parent, LOG_ERROR)
		return end
	end
	for k,v in pairs(settings) do
		if not (k == "Type" or k == "Visible") then
			newGUI[k] = v
		end
	end
	if not settings["Hidden"] then
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
	function(a, b, t) return es_lerp(a, b, t * t) end,
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

function es_tween(object, property, startPos, endPos, time, tweeningStyle, smoothness)
	local tweeningStyle = tweeningStyle or es_EASING_LINEAR
	local smoothness = smoothness or 0.001
	local style = nil
	for k,v in pairs(tweenStyles) do
		if tweeningStyle == k then style = v end
	end
	if style then
		if property == "Size" then -- Tile size is bottom left corner aligned, account for that with offset
			for i=0,1,smoothness do
				delay(i*time, function()
					object[property] = Vector(style(startPos.X, endPos.X, i), style(startPos.Y, endPos.Y, i))
					object.Position = Vector(startPos.X-style(startPos.X, endPos.X, i)/2, startPos.Y-style(startPos.Y, endPos.Y, i)/2)
				end)
			end
		else
			if es_type(object[property]) == "vector" then
				for i=0,1,smoothness do
					delay(i*time, function()
						object[property] = Vector(style(startPos.X, endPos.X, i), style(startPos.Y, endPos.Y, i))
					end)
				end
			else
				for i=0,1,smoothness do
					delay(i*time, function()
						object[property] = style(startPos, endPos, i)
					end)
				end
			end
		end
	else
		log("ESSENTIALS", "Invalid tweening style: " .. tweeningStyle, LOG_ERROR)
	end
end