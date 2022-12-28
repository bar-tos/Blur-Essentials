-- rounds the number to the given number of decimal places
function es_roundToPlace(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- returns values EXCLUDED from the clamp zone, going to the nearest minimum if it is inside the clamp zone
-- es_reverseClamp(0.5, -1, 2) = 2
-- es_reverseClamp(-1, 5, 10) = -1
-- es_reverseClamp(6, 10, 5) = 6
function es_reverseClamp(value, lowerThan, higherThan)
	lowerThan = math.min(lowerThan, higherThan)
	
	-- closer to lower minimum
	if (math.abs(value - lowerThan) < math.abs(value - higherThan)) then
		return math.min(value, lowerThan)
	-- closer to higher minimum
	elseif (math.abs(value - higherThan) <= math.abs(value - lowerThan)) then
		return math.max(value, higherThan)	
	end
end