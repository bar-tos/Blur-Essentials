-- creates a unique number from a vector
function es_vecToNum(vector)
	return (2 ^ vector.X) * (3 ^ vector.Y)
end

function es_squareDistance(v1, v2)
	-- calculate the triangle's legs
	local x1, x2 = v1.X, v2.X
	local y1, y2 = v1.Y, v2.Y
	local distX = math.abs(x1-x2)
	local distY = math.abs(y1-y2)
	
	-- a^2 + b^2 = c^2
	return distX^2 + distY^2
end

function es_squareDistance_num(x1, y1, x2, y2)
	local distX = math.abs(x1-x2)
	local distY = math.abs(y1-y2)
	
	-- a^2 + b^2 = c^2
	return distX^2 + distY^2
end

function es_distance(v1, v2)
	return math.sqrt(es_squareDistance(v1, v2))
end

function es_distance_num(x1, y1, x2, y2)
	return math.sqrt(es_squareDistance_num(x1, y1, x2, y2))
end

function es_normalize(vector)
    local magnitude = math.sqrt((vector.X ^ 2) + (vector.Y ^ 2))
	if (magnitude == 0) then return Vector(0, 0) end
    local unitVector = vector / Vector(magnitude, magnitude, magnitude)
    return unitVector
end