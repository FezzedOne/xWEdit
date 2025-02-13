require("/scripts/wedit/scriptHooks.lua")
require("/scripts/wedit/controller.lua")

hook("init", function(...)
    self.xWEditErrored = false
    local status, errorStr = pcall(wedit.controller.init, ...)
    if not status then
        sb.logError("[xWEdit] Error during init: %s", errorStr)
        self.xWEditErrored = true
    end
end)
hook("update", function(...)
    if self.xWEditErrored then return end
    local status, errorStr = pcall(wedit.controller.update, ...)
    if not status then
        sb.logError("[xWEdit] Error during update: %s", errorStr)
        self.xWEditErrored = true
    end
end)
hook("uninit", function(...)
    if self.xWEditErrored then return end
    local status, errorStr = pcall(wedit.controller.uninit, ...)
    if not status then
        sb.logError("[xWEdit] Error during uninit: %s", errorStr)
        self.xWEditErrored = true
    end
end)
