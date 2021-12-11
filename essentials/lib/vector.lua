function es_distance(v1, v2)
	-- calculate the triangle's legs
	local x1, x2 = v1.X, v2.X
	local y1, y2 = v1.Y, v2.Y
	local distX = math.abs(x1-x2)
	local distY = math.abs(y1-y2)
	
	-- a^2 + b^2 = c^2
	return math.sqrt(distX^2 + distY^2)
end