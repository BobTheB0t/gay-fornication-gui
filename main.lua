-- main.lua
-- GUI for Roblox - Gay Fornication GUI
-- This script initializes and manages the main GUI elements.

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Constants
local GUI_FOLDER = script.Parent.GUI -- Folder containing GUI elements
local MAIN_FRAME = GUI_FOLDER:WaitForChild("MainFrame") -- Main GUI frame
local TOGGLE_KEY = Enum.KeyCode.RightShift -- Key to toggle the GUI

-- Variables
local localPlayer = Players.LocalPlayer
local isGuiVisible = false

-- Helper Functions
local function showGui()
    if not isGuiVisible then
        MAIN_FRAME.Visible = true
        isGuiVisible = true
    end
end

local function hideGui()
    if isGuiVisible then
        MAIN_FRAME.Visible = false
        isGuiVisible = false
    end
end

local function toggleGui()
    if isGuiVisible then
        hideGui()
    else
        showGui()
    end
end

-- Input Handling
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == TOGGLE_KEY then
        toggleGui()
    end
end)

-- Initialize GUI
MAIN_FRAME.Visible = false
MAIN_FRAME.Parent = localPlayer:WaitForChild("PlayerGui")

-- Error Handling
local function onChildAdded(child)
    if child:IsA("GuiObject") then
        local success, err = pcall(function()
            child.Visible = false
        end)
        if not success then
            warn("Failed to initialize GUI element: " .. err)
        end
    end
end

GUI_FOLDER.ChildAdded:Connect(onChildAdded)

-- Remote Event Handling (Example)
local function onRemoteEventFired(player, message)
    if player == localPlayer then
        local notification = Instance.new("TextLabel")
        notification.Text = message
        notification.Parent = MAIN_FRAME
        notification.Visible = true

        -- Auto-remove notification after 5 seconds
        delay(5, function()
            if notification and notification.Parent then
                notification:Destroy()
            end
        end)
    end
end

local remoteEvent = ReplicatedStorage:WaitForChild("NotificationEvent")
remoteEvent.OnClientEvent:Connect(onRemoteEventFired)

-- Main Script Execution
print("Gay Fornication GUI loaded successfully.")