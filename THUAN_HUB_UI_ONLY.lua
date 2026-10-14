-- THUAN HUB UI ONLY - Black Neon
-- Safe replacement UI for a Roblox experience you own or are authorized to edit.
-- This script intentionally does NOT implement anti-hit exploits, server hopping,
-- egg ESP/tracking in someone else's game, or other executor-only functions.
-- Put this LocalScript in StarterPlayer > StarterPlayerScripts in your own game.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local previous = playerGui:FindFirstChild("THUAN_HUB")
if previous then previous:Destroy() end

local C = {
    bg = Color3.fromRGB(8, 11, 16),
    panel = Color3.fromRGB(18, 24, 32),
    row = Color3.fromRGB(24, 32, 41),
    neon = Color3.fromRGB(0, 235, 200),
    blue = Color3.fromRGB(0, 170, 255),
    text = Color3.fromRGB(238, 248, 250),
    muted = Color3.fromRGB(145, 165, 173),
    green = Color3.fromRGB(0, 255, 145),
}

local gui = Instance.new("ScreenGui")
gui.Name = "THUAN_HUB"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false
gui.Parent = playerGui

local function round(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 10)
    c.Parent = obj
end

local function outline(obj, color)
    local s = Instance.new("UIStroke")
    s.Color = color or C.neon
    s.Thickness = 1.3
    s.Transparency = 0.12
    s.Parent = obj
end

local function make(className, props, parent)
    local obj = Instance.new(className)
    for key, value in pairs(props) do obj[key] = value end
    obj.Parent = parent
    return obj
end

local function label(parent, text, pos, size, textSize, color)
    return make("TextLabel", {
        BackgroundTransparency = 1,
        Position = pos,
        Size = size,
        Font = Enum.Font.GothamBold,
        Text = text,
        TextColor3 = color or C.text,
        TextSize = textSize or 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextWrapped = true,
    }, parent)
end

local function button(parent, text, pos, size)
    local b = make("TextButton", {
        Position = pos,
        Size = size,
        BackgroundColor3 = C.row,
        Text = text,
        TextColor3 = C.neon,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        AutoButtonColor = true,
    }, parent)
    round(b, 8)
    outline(b)
    return b
end

local main = make("Frame", {
    Name = "Main",
    Size = UDim2.new(0.86, 0, 0, 335),
    Position = UDim2.new(0.07, 0, 0.25, 0),
    BackgroundColor3 = C.bg,
}, gui)
main.ClipsDescendants = true
round(main, 12)
outline(main, C.blue)

local top = make("TextButton", {
    Name = "DragBar",
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = C.panel,
    Text = "THUAN HUB  |  BLACK NEON",
    TextColor3 = C.neon,
    Font = Enum.Font.GothamBlack,
    TextSize = 15,
    AutoButtonColor = false,
}, main)
round(top, 10)

local status = label(main, "● UI READY  |  SAFE DEMO", UDim2.new(0, 12, 0, 49),
    UDim2.new(1, -24, 0, 22), 10, C.muted)

local tabEgg = button(main, "EGG TRACKER", UDim2.new(0, 10, 0, 76),
    UDim2.new(0.49, -5, 0, 34))
local tabPlayer = button(main, "PLAYER INFO", UDim2.new(0.51, 0, 0, 76),
    UDim2.new(0.49, -10, 0, 34))
local tabSettings = button(main, "SETTINGS", UDim2.new(0, 10, 0, 118),
    UDim2.new(1, -20, 0, 32))

local page = make("Frame", {
    Name = "Page",
    Position = UDim2.new(0, 10, 0, 158),
    Size = UDim2.new(1, -20, 1, -168),
    BackgroundColor3 = C.panel,
}, main)
round(page, 9)

local function clearPage()
    for _, child in ipairs(page:GetChildren()) do child:Destroy() end
end

local function showEggPage()
    clearPage()
    label(page, "EGG TRACKER", UDim2.new(0, 10, 0, 6),
        UDim2.new(1, -20, 0, 26), 14, C.neon)
    label(page, "Demo list only — not connected to Steal an Egg.", 
        UDim2.new(0, 10, 0, 31), UDim2.new(1, -20, 0, 34), 10, C.muted)
    local names = {"Common Egg", "Rare Egg", "Epic Egg", "Legendary Egg"}
    for i, name in ipairs(names) do
        local y = 70 + (i - 1) * 29
        label(page, "🥚  " .. name .. "   |   SAMPLE",
            UDim2.new(0, 12, 0, y), UDim2.new(1, -22, 0, 25),
            11, i == 4 and C.neon or C.text)
    end
end

local function showPlayerPage()
    clearPage()
    label(page, "PLAYER INFO", UDim2.new(0, 10, 0, 6),
        UDim2.new(1, -20, 0, 26), 14, C.neon)
    label(page, "Name: " .. player.Name, UDim2.new(0, 12, 0, 42),
        UDim2.new(1, -22, 0, 25), 11, C.text)
    label(page, "Display name: " .. player.DisplayName,
        UDim2.new(0, 12, 0, 72), UDim2.new(1, -22, 0, 25), 11, C.text)
    label(page, "User ID: " .. tostring(player.UserId),
        UDim2.new(0, 12, 0, 102), UDim2.new(1, -22, 0, 25), 11, C.text)
    label(page, "Only public client-side player details are shown.",
        UDim2.new(0, 12, 0, 136), UDim2.new(1, -22, 0, 32), 10, C.muted)
end

local function showSettingsPage()
    clearPage()
    label(page, "SETTINGS", UDim2.new(0, 10, 0, 6),
        UDim2.new(1, -20, 0, 26), 14, C.neon)
    label(page, "ANTI-HIT: UI PLACEHOLDER (NO GAME EFFECT)",
        UDim2.new(0, 12, 0, 42), UDim2.new(1, -22, 0, 30), 10, C.text)
    local antiButton = button(page, "ANTI-HIT DEMO: OFF",
        UDim2.new(0, 12, 0, 78), UDim2.new(1, -24, 0, 34))
    local anti = false
    antiButton.Activated:Connect(function()
        anti = not anti
        antiButton.Text = anti and "ANTI-HIT DEMO: ON" or "ANTI-HIT DEMO: OFF"
        antiButton.TextColor3 = anti and C.green or C.neon
        status.Text = anti and "● DEMO SWITCH ON (NO DAMAGE PROTECTION)" or "● UI READY  |  SAFE DEMO"
    end)
    label(page, "This switch only changes the label. Real protection belongs in server code for a game you own.",
        UDim2.new(0, 12, 0, 121), UDim2.new(1, -22, 0, 48), 10, C.muted)
end

tabEgg.Activated:Connect(showEggPage)
tabPlayer.Activated:Connect(showPlayerPage)
tabSettings.Activated:Connect(showSettingsPage)
showEggPage()

local toggle = make("TextButton", {
    Name = "ToggleButton",
    Size = UDim2.fromOffset(46, 46),
    Position = UDim2.new(0, 12, 0.48, 0),
    BackgroundColor3 = C.bg,
    Text = "T",
    TextColor3 = C.neon,
    Font = Enum.Font.GothamBlack,
    TextSize = 22,
}, gui)
round(toggle, 23)
outline(toggle, C.blue)

toggle.Activated:Connect(function()
    main.Visible = not main.Visible
end)

-- Touch/mouse drag support for the title bar
local dragging = false
local dragStart, startPos

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
