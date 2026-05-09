local ToggleGod = false
local TogglePerfect = false
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")

-- UI Setup
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true

local function createBtn(text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Parent = Frame
    btn.Size = UDim2.new(0.9, 0, 0.4, 0)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    return btn
end

local ButtonTP = createBtn("TELEPORT", UDim2.new(0.05, 0, 0.05, 0), Color3.fromRGB(0, 120, 255))
local ButtonFarm = createBtn("AUTO PERFECT: OFF", UDim2.new(0.05, 0, 0.5, 0), Color3.fromRGB(150, 0, 0))

-- 1. TELEPORT KE KOORDINAT (690, 5, 232)
ButtonTP.MouseButton1Click:Connect(function()
    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(690, 5, 232) end
end)

-- 2. AUTO PERFECT + GOD MODE (GABUNGAN)
ButtonFarm.MouseButton1Click:Connect(function()
    TogglePerfect = not TogglePerfect
    ButtonFarm.Text = TogglePerfect and "AUTO PERFECT: ON" or "AUTO PERFECT: OFF"
    ButtonFarm.BackgroundColor3 = TogglePerfect and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    
    local network = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network")
    local kickEvent = network:WaitForChild("rev_KickEvent")
    local kickCollect = network:WaitForChild("rev_KickCollect")

    task.spawn(function()
        while TogglePerfect do
            local char = game.Players.LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            if hum then
                -- GOD MODE PASSIVE
                hum.Health = hum.MaxHealth
                hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                
                -- TEMBAK PERFECT (Angka 1 atau 100 coba tes mana yang paling jauh)
                -- Gunakan pcall supaya kalau error tidak bikin script mati
                pcall(function()
                    kickEvent:FireServer(1) 
                    task.wait(0.5) -- JEDA WAJIB: Biar gak kena kick Suspicious Activity
                    kickCollect:FireServer()
                end)
            end
            task.wait(1.5) -- JEDA ANTAR TENDANGAN: Harus cukup lama biar aman
        end
    end)
end)
