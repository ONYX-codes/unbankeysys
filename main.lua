-- Roblox Chat Command Script with Hardcoded Key Workaround
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

if not Player then
    print("Error: Player not found!")
    return
end

-- Hardcoded Key (no Pastebin fetch)
local VALID_KEY = "niggeria123"
print("Key hardcoded: '" .. VALID_KEY .. "'")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.Name = "KeySystemGUI"

-- Key Input Frame
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 400, 0, 300)
KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
KeyFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyFrame.Parent = ScreenGui

local KeyFrameCorner = Instance.new("UICorner")
KeyFrameCorner.CornerRadius = UDim.new(0, 15)
KeyFrameCorner.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(0, 300, 0, 50)
KeyTitle.Position = UDim2.new(0.5, -150, 0.1, 0)
KeyTitle.Text = "Enter Key to Unlock"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 30
KeyTitle.Font = Enum.Font.SourceSansBold
KeyTitle.BackgroundTransparency = 1
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0, 250, 0, 40)
KeyInput.Position = UDim2.new(0.5, -125, 0.4, 0)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
KeyInput.TextSize = 18
KeyInput.Parent = KeyFrame

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 8)
KeyInputCorner.Parent = KeyInput

local KeyButton = Instance.new("TextButton")
KeyButton.Size = UDim2.new(0, 200, 0, 50)
KeyButton.Position = UDim2.new(0.5, -100, 0.7, 0)
KeyButton.Text = "Submit"
KeyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
KeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyButton.Font = Enum.Font.SourceSans
KeyButton.TextSize = 20
KeyButton.Parent = KeyFrame

local KeyButtonCorner = Instance.new("UICorner")
KeyButtonCorner.CornerRadius = UDim.new(0, 10)
KeyButtonCorner.Parent = KeyButton

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0, 300, 0, 30)
StatusLabel.Position = UDim2.new(0.5, -150, 0.9, 0)
StatusLabel.Text = "Waiting for key..."
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 14
StatusLabel.BackgroundTransparency = 1
StatusLabel.Parent = KeyFrame

-- Chat Command Logic
local function checkChat(message)
    message = message:lower()
    if message == "./unban" then
        print("Command './unban' executed by " .. Player.Name)
        local success, error = pcall(function()
            game:GetService("VoiceChatService"):joinVoice()
            print("Custom action executed!")
        end)
        if not success then
            print("Action failed: " .. tostring(error))
        end
    end
end

-- Key Verification and Activation
local function activateChatListener()
    local success, error = pcall(function()
        Player.Chatted:Connect(checkChat)
    end)
    if success then
        print("Chat command script loaded successfully!")
    else
        print("Failed to connect chat event: " .. tostring(error))
    end
end

KeyButton.MouseButton1Click:Connect(function()
    local inputKey = KeyInput.Text
    if inputKey == VALID_KEY then
        StatusLabel.Text = "Key accepted! Loading..."
        KeyFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.5, true)
        wait(0.5)
        KeyFrame.Visible = false
        activateChatListener()
    else
        StatusLabel.Text = "Invalid key! Try again."
        KeyInput.Text = ""
    end
end)

-- Initial Print
print("Key system loaded. Enter the key to proceed.")
