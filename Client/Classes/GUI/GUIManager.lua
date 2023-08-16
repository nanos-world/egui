local Manager = EGUI.Classlib.Inherit(EGUI.Object)

function Manager:Constructor()
    self.m_Ready = EGUI.Classlib.Bind(Manager.Ready, self)
    self.m_Handler = EGUI.Classlib.Bind(Manager.Handler, self)

    self.m_WebUI = WebUI("GUI", "file:///UI/index.html", WidgetVisibility.Visible)
    self.m_WebUI:Subscribe("Ready", self.m_Ready)

    self.m_Id = 1
    self.m_Events = {}
    self.m_EventBuffer = {}
    self.m_Elements = {}
    self.m_ElementsByType = {}

	self.m_InputFocus = nil
	self.m_PreviousInputState = true

    self.m_IsReady = false
end

function Manager:Register(type, element)
    if not self.m_ElementsByType[type] then
        self.m_ElementsByType[type] = {}
    end
    local id = self:GetElementId()
    table.insert(self.m_ElementsByType[type], element)
    self.m_Elements[id] = element
    return id
end

function Manager:CallEvent(event, ...)
    if self.m_IsReady then
        self.m_WebUI:CallEvent(event, ...)
    else
        table.insert(self.m_EventBuffer, {event, ...})
    end
end

function Manager:Ready()
    self.m_IsReady = true
    for k, event in ipairs(self.m_EventBuffer) do
        -- TODO: Maybe pcall ??
        self.m_WebUI:CallEvent(table.unpack(event))
    end
    for event, type in pairs(self.m_Events) do
        self.m_WebUI:Subscribe(event, EGUI.Classlib.Bind(self.m_Handler, event))
    end
    self.m_EventBuffer = {}
end

function Manager:Handler(event, id, ...)
    if not self.m_Events[event] then
        return
    end

    local type = self.m_Events[event]

    if not self.m_ElementsByType[type] then
        return
    end

    for k, element in ipairs(self.m_ElementsByType[type]) do
        -- TODO: Maybe pcall?
        if element and element.HandleEvent and element:GetId() == id then
            element:HandleEvent(event, ...)
        end
    end
end

function Manager:GetElementId()
    local id = self.m_Id
    self.m_Id = self.m_Id + 1
    return id
end

function Manager:Subscribe(type, event)
    self.m_Events[event] = type

    if self.m_IsReady then
        self.m_WebUI:Subscribe(event, EGUI.Classlib.Bind(self.m_Handler, event))
    end
end

function Manager:InputFocusIn(element)
	if self.m_InputFocus == nil then
		self.m_PreviousInputState = Client.IsInputEnabled()
	end

	self.m_InputFocus = element
	Client.SetInputEnabled(false)
end

function Manager:InputFocusOut(element)
	if self.m_InputFocus == element then
		self.m_InputFocus = nil
		Client.SetInputEnabled(self.m_PreviousInputState)
	end
end

EGUI.Manager = Manager()
