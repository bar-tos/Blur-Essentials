--[[
	BLUR ESSENTIALS LICENSE
	Blur Essentials is an open source project made by Bartos, it is available here: https://github.com/bar-tos/Blur-Essentials
	
	You are allowed to modify and redistribute this product as long as you include this license in your file.
	You are not allowed to claim this work as your own.
--]]

for _,v in pairs(
	{"gui", "tween", "vector", "math", "files", "tables"}) 
do
	include("libs/essentials/lib/" .. v .. ".lua")
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

function es_copy(orig)
    local origType = es_type(orig)
    local copy
    if origType == 'table' then
        copy = {}
        for origKey, origValue in pairs(orig) do
			if (origType == "Vector") then
				copy[origKey] = Vector(origValue.X, origValue.Y, origValue.Z)
			elseif (origType == "Color") then
				copy[origKey] = Color.fromRGB(origValue.R, origValue.G, origValue.B)
			else
				copy[origKey] = origValue
			end
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function es_deepCopy(orig, copies)
    copies = copies or {}
    local origType = es_type(orig)
    local copy
    if origType == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            for origKey, origValue in next, orig, nil do
                copy[es_deepCopy(origKey, copies)] = es_deepCopy(origValue, copies)
            end
            setmetatable(copy, es_deepCopy(getmetatable(orig), copies))
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end