--- Functions to debug Lualine GPS configuration

local pkg = {}

function pkg.GetLocation()
	local gps, gps_present = pcall(require, "nvim-gps")
	if gps_present and gps.is_available() then
		local location = gps.get_location()
		print("Returning location: " .. vim.inspect(location))
		return location
	else
		print("ERROR: Attempted to get location from GPS when unavailable")
		return ""
	end
end

function pkg.IsAvailable()
	local gps_present, gps = pcall(require, "nvim-gps")
	local available = gps_present and gps.is_available()
	print("GPS availability: " .. vim.inspect(available))
	return available
end

function pkg.GetLocationIfAvailable()
	print("INFO: Calling gps.GetLocationIfAvailable...")
	local gps, gps_present = pcall(require, "nvim-gps")
	if gps_present and gps.is_available() then
		local location = gps.get_location()
		print("INFO: Returning location: " .. vim.inspect(location))
		return location
	else
		print("ERROR: Attempted to get location from GPS when unavailable")
		return ""
	end
	print("INFO: Returning from gps.GetLocationIfAvailable...")
end

return pkg
