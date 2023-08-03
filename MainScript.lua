if not game:IsLoaded() then
    repeat task.wait() until game:IsLoaded()
end

local function displayErrorPopup(text, funclist)
	local oldidentity = getidentity()
	setidentity(8)
	local ErrorPrompt = getrenv().require(game:GetService("CoreGui").RobloxGui.Modules.ErrorPrompt)
	local prompt = ErrorPrompt.new("Default")
	prompt._hideErrorCode = true
	local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
	prompt:setErrorTitle("Sonicware")
	local funcs
	if funclist then 
		funcs = {}
		local num = 0
		for i,v in pairs(funclist) do 
			num = num + 1
			table.insert(funcs, {
				Text = i,
				Callback = function() 
					prompt:_close() 
					v()
				end,
				Primary = num == #funclist
			})
		end
	end
	prompt:updateButtons(funcs or {{
		Text = "OK",
		Callback = function() 
			prompt:_close() 
		end,
		Primary = true
	}}, 'Default')
	prompt:setParent(gui)
	prompt:_open(text)
	setidentity(oldidentity)
end
if not isfolder("sonicware") then makefolder("sonicware") end
local services = {
    ["players"] = game:GetService("Players"),
    ["core"] = game:GetService("CoreGui"),
    ["workspace"] = game:GetService("Workspace"),
    ["userinput"] = game:GetService("UserInputService"),
    ["text"] = game:GetService("TextService"),
    ["chat"] = game:GetService("TextChatService"),
    ["storage"] = game:GetService("ReplicatedStorage"),
    ["file"] = {
        ["exists"] = isfile or function(x)
            local suc, res = pcall(function() return readfile(x) end)
            return suc and res ~= nil
        end,
        ["read"] = readfile,
        ["write"] = writefile,
        ["delete"] = delfile or function(x)
            return writefile(x, "")
        end,
        ["df"] = delfolder,
        ["mf"] = makefolder,
    },
    ["setIdentity"] = syn and syn.set_thread_identity or set_thread_identity or setidentity or setthreadidentity or function() end,
    ["getIdentity"] = syn and syn.get_thread_identity or get_thread_identity or getidentity or getthreadidentity or function() return 0 end,
    ["qot"] = syn and syn.queue_on_teleport or queue_on_teleport or function() end,
    ["popup"] = displayErrorPopup,
}
shared.services = services

if services.userinput:GetPlatform() ~= Enum.Platform.Windows then 
	getgenv().getsynasset = nil
	getgenv().getcustomasset = nil
	getsynasset = nil
	getcustomasset = nil
end

assert(not shared.SnwExe, "Sonicware Already Executed")
shared.SnwExe = true

