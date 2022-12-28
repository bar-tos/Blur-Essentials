-- non-recursive table print
function es_printTable(tab, tableName)
	if (tableName ~= nil) then print(tableName.." {") end
	for key, value in pairs(tab) do
		print("    "..key..": "..tostring(value))
	end
	if (tableName ~= nil) then print ("}") end
end

-- recursive table print
function es_printTableRecursive(tab, tableName, indentation)
	if (indentation == nil) then indentation = 1 end
	local containerIndentation = ""
	local itemIndentation = ""
	for i = 1, indentation - 1, 1 do
		containerIndentation = containerIndentation.."    "
	end
	itemIndentation = containerIndentation.."    "
	
	if (tableName ~= nil) then print(containerIndentation..tableName.." {") end
	for key, value in pairs(tab) do
		-- draw the subtable with increased indentation
		if (es_type(value) == "table") then
			es_printTableRecursive(value, tostring(key), indentation + 1)
		else
			print(itemIndentation..key..": "..tostring(value))
		end
	end
	if (tableName ~= nil) then print(containerIndentation.."}") end
end

function es_tableCount(tab)
	local count = 0
	for i, v in pairs(tab) do
		count = count + 1
	end
	return count
end

-- finds a value in an array table
function es_arrayFind(arr, value)
	for i = 1, #arr, 1 do
		if (arr[i] == value) then
			return i
		end
	end
	
	return nil
end