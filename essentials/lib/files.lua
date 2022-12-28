-- returns a table of paths to all .blf files in some subdirectory of saves
function es_getSavesInDirectory(dir)
	local allBlfSaves = BLF.findSaves()
	local savesInFolder = {}
	
	for i = 1, #allBlfSaves, 1 do
		if (es_isInDirectory(allBlfSaves[i], dir) and es_isBlfFilePath(allBlfSaves[i])) then
			savesInFolder[#savesInFolder + 1] = allBlfSaves[i]
		end		
	end
	
	return savesInFolder
end

-- returns the filename of a path (saves/test/level.blf-> level)
function es_getFileName(path)
	local reversed = string.reverse(path)
	local lastPeriodIndex = string.len(reversed) - string.find(reversed, "%.")

	local backSlashIndex = string.find(reversed, [[/]])
	
	-- only a file name with no directories was given
	if (backSlashIndex == nil) then backSlashIndex = string.len(reversed) + 2 end
	
	local lastBackslashIndex = string.len(reversed) - backSlashIndex
	local fileName = string.sub(path, lastBackslashIndex + 2, lastPeriodIndex)
	
	return fileName
end

-- checks if a given path is contained in a folder / directory
function es_isInDirectory(path, dir)
	return string.find(path, dir..[[/]]) ~= nil
end

-- checks if a given path has the BLF file extension
function es_isBlfFilePath(path)
	local reversed = string.reverse(path)
	local lastPeriodIndex = string.len(reversed) - string.find(reversed, ".")
	local extension = string.sub(path, lastPeriodIndex - 1, string.len(reversed))

	return extension == "blf"
end

-- checks if a given path exists as a BLF save
function es_isExistingSave(path)
	-- add the saves directory ourselves
	if (string.find(path, "/saves") == nil) then
		path = "./saves"..[[/]]..path
	end

	local saves = BLF.findSaves()

	for i = 1, #saves, 1 do
		if (es_isBlfFilePath(saves[i]) and saves[i] == path) then
			return true
		end
	end
	
	return false
end