--[[
	BLUR ESSENTIALS LICENSE
	Blur Essentials is an open source project made by Bartos, it is available here: https://github.com/bar-tos/Blur-Essentials

	You are allowed to modify and redistribute this product as long as you include this license in your file.
	You are not allowed to claim this work as your own.
--]]

for _,v in pairs(
	{"gui", "tween", "vector"}) 
do
	include("essentials/lib/" .. v .. ".lua")
end
	
	
function es_wait(seconds)
	print("Started wait")
    local start = os.time()
    repeat 
		print(os.time())
	until os.time() - start > seconds
	print("Ended wait")
end

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
