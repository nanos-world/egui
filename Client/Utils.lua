EGUI.Utils = {}

function EGUI.Utils.ripairs(t)
	local max = 1
	while t[max] ~= nil do
		max = max + 1
	end
	local function ripairs_it(t, i)
		i = i-1
		local v = t[i]
		if v ~= nil then
			return i,v
		else
			return nil
		end
	end
	return ripairs_it, t, max
end

function EGUI.Utils.CheckArgs(funcName, ...)
	local validations = {...}
    for i = 2, 10 do
        local name, value = debug.getlocal(2, i)
		local validation = validations[i - 1] or ""
		local allowNil = false

		if validation == "" then
			return true
		end

        if name == "(*temporary)" then
            return true
        end

		if validation:sub(1, 1) == "?" then
			allowNil = true
			validation = validation:sub(2, -1)
		end

		if type(value) ~= "nil" then
			if type(value) ~= validation then
				error(string.format("%s - Expected type %s for parameter %s got %s.", funcName, validations[i - 1] or "", name, type(value)))
			end
		elseif not allowNil then
			error(string.format("%s - Expected type %s for parameter %s got %s.", funcName, validation, name, type(value)))
		end
    end
end
