EGUI.Slider = EGUI.Classlib.Inherit(EGUI.InputBase)
EGUI.Slider.Type = "Slider"

EGUI.Manager:Subscribe(EGUI.Slider.Type, "GUISliderChange")

function EGUI.Slider:Constructor(posX, posY, width, height, value, min, max, parent)
	EGUI.Utils.CheckArgs("EGUI.Slider:Constructor", "number", "number", "number", "number", "number", "number", "number", "?table")
    EGUI.InputBase.Constructor(self, posX, posY, width, height, parent)

    self.m_Type = type
	self.m_Value = value
	self.m_Min = min
	self.m_Max = max

    EGUI.Manager:CallEvent("GUISliderCreate", self:GetId(), self.m_PosX, self.m_PosY, self.m_Width, self.m_Height, self.m_Value, self.m_Min, self.m_Max, self.m_Parent and self.m_Parent:GetId() or nil)
end

function EGUI.Slider:SetValue(value)
	EGUI.Utils.CheckArgs("EGUI.Slider:SetValue", "number")
	self.m_Value = value
	EGUI.Manager:CallEvent("GUISliderSetValue", self:GetId(), self.m_Value)
	return self
end

function EGUI.Slider:GetValue()
	return self.m_Value
end

function EGUI.Slider:SetMinValue(min)
	EGUI.Utils.CheckArgs("EGUI.Slider:SetMinValue", "number")
	self.m_Min = min
	EGUI.Manager:CallEvent("GUISliderSetMin", self:GetId(), self.m_Min)
	return self
end

function EGUI.Slider:GetMinValue()
	return self.m_Min
end

function EGUI.Slider:SetMaxValue(max)
	EGUI.Utils.CheckArgs("EGUI.Slider:SetMaxValue", "number")
	self.m_Max = max
	EGUI.Manager:CallEvent("GUISliderSetMax", self:GetId(), self.m_Max)
	return self
end

function EGUI.Slider:GetMaxValue()
	return self.m_Max
end

function EGUI.Slider:HandleEvent(event, ...)
    if event == "GUISliderChange" then
		local params = {...}
		self.m_Value = params[1]

        self:Trigger("Change", ...)
    end
end
