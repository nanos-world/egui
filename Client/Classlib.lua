EGUI.Classlib = {}

local asset = assert
local type = type
local setmetatable = setmetatable
local getmetatable = getmetatable
local rawget = rawget
local error = error
local pairs = pairs
local ipairs = ipairs
local table_insert = table.insert
local select = select
local table_unpack = table.unpack

local function super(self)
	if type(self) == "userdata" then
		return {}
	end

	local metatable = getmetatable(self)
	if metatable then return metatable.__super
	else
		return {}
	end
end

local function superMultiple(self)
	local metatable = getmetatable(self)
	if not metatable then
		return {}
	end

	if metatable.__class then -- we're dealing with a class object
		return superMultiple(metatable.__class)
	end

	if metatable.__super then -- we're dealing with a class
		return metatable.__super or {}
	end
end

local function superAll(self)
	local supers = {}
	local s = superMultiple(self)

	if s then
		for _, v in ipairs(s) do
			table_insert(supers, v)
		end

		for _, v in ipairs(s) do
			local hS = superAll(v)

			for _, v2 in ipairs(hS) do
				table_insert(supers, v2)
			end
		end
	end

	return supers
end

local function _inheritIndex(self, key)
	for k, v in pairs(super(self) or {}) do
		if v[key] then return v[key] end
	end
	return nil
end

function EGUI.Classlib.New(class, ...)
	assert(type(class) == "table", "first argument provided to new is not a table")

	local instance = setmetatable( { },
    {
        __index = class;
        __super = { class };
        __newindex = class.__newindex;
        __call = class.__call;
        __len = class.__len;
        __unm = class.__unm;
        __add = class.__add;
        __sub = class.__sub;
        __mul = class.__mul;
        __div = class.__div;
        __pow = class.__pow;
        __concat = class.__concat;
    })

	for k, v in EGUI.Utils.ripairs(superAll(instance)) do
		if rawget(v, "VirtualConstructor") then
			rawget(v, "VirtualConstructor")(instance, ...)
		end
	end

	if rawget(class, "Constructor") then
		rawget(class, "Constructor")(instance, ...)
	end
	instance.Constructor = false

	return instance
end

function EGUI.Classlib.Delete(self, ...)
	if not self then error("Called delete without object") end
	if self.Destructor then --if rawget(self, "destructor") then
		self:Destructor(...)
	end

	-- Prevent the destructor to be called twice
	self.Destructor = false

	local callDerivedDestructor;
	callDerivedDestructor = function(parentClasses, instance, ...)
		for k, v in pairs(parentClasses) do
			if rawget(v, "VirtualDestructor") then
				rawget(v, "VirtualDestructor")(instance, ...)
			end
			local s = super(v)
			if s then callDerivedDestructor(s, instance, ...) end
		end
	end
	callDerivedDestructor(super(self), self, ...)
end

function EGUI.Classlib.Inherit(from, what)
	assert(from, "Attempt to inherit a nil table value")
	if not what then
		local metatable = getmetatable(from) or {}
		local classt = setmetatable({}, { __index = _inheritIndex, __call = metatable.__call, __super = { from } })
		if from.onInherit then
			from.onInherit(classt)
		end
		return classt
	end

	local metatable = getmetatable(what) or {}
	local oldsuper = metatable and metatable.__super or {}
	table_insert(oldsuper, 1, from)
	metatable.__super = oldsuper
	metatable.__index = _inheritIndex

	-- Inherit __call
	for k, v in ipairs(metatable.__super) do
		if v.__call then
			metatable.__call = v.__call
			break
		end
	end

	return setmetatable(what, metatable)
end

function EGUI.Classlib.Bind(func, ...)
	if not func then
		error("Bad function pointer @ EGUI.Classlib.Bind. See console for more details")
	end

	local boundParams = {...}
	return
		function(...)
			local params = {}
			local boundParamSize = select("#", table_unpack(boundParams))
			for i = 1, boundParamSize do
				params[i] = boundParams[i]
			end

			local funcParams = {...}
			for i = 1, select("#", ...) do
				params[boundParamSize + i] = funcParams[i]
			end

            local retValue = func(table_unpack(params))

			return retValue
		end
end
