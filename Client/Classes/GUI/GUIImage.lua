EGUI.Image = EGUI.Classlib.Inherit(EGUI.Element)
EGUI.Image.Type = "Image"

EGUI.Image.Fit = {
    None		= "none",
    Contain		= "contain",
    Cover		= "cover",
    Fill		= "fill",
    ScaleDown	= "scale-down"
}

function EGUI.Image:Constructor(posX, posY, width, height, path, parent)
	EGUI.Utils.CheckArgs("EGUI.Image:Constructor", "number", "number", "number", "number", "string", "?table")
    EGUI.Element.Constructor(self, posX, posY, width, height, parent)

    self.m_Path = path
	self.m_Fit = EGUI.Image.Fit.None

    EGUI.Manager:CallEvent("GUIImageCreate", self:GetId(), self.m_PosX, self.m_PosY, self.m_Width, self.m_Height, self.m_Path, self.m_Parent and self.m_Parent:GetId() or nil)
end

function EGUI.Image:SetImage(path)
	EGUI.Utils.CheckArgs("EGUI.Image:SetImage", "string")
    self.m_Path = path
    EGUI.Manager:CallEvent("GUIImageSetImage", self:GetId(), self.m_Path)
    return self
end

function EGUI.Image:GetImage()
    return self.m_Path
end

function EGUI.Image:SetFit(fit)
	EGUI.Utils.CheckArgs("EGUI.Image:SetFit", "string")
    self.m_Fit = fit
    EGUI.Manager:CallEvent("GUIImageSetFit", self:GetId(), self.m_Fit)
    return self
end

function EGUI.Image:GetFit()
    return self.m_Fit
end
