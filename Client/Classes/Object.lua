EGUI.Object = {}

setmetatable(EGUI.Object, {
    __call = function(self, ...)
        return self:New(...)
    end
})

function EGUI.Object:New(...)
	return EGUI.Classlib.New(self, ...)
end

function EGUI.Object:Delete(...)
	return EGUI.Classlib.Delete(self, ...)
end