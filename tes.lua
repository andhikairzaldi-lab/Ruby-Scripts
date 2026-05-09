local ToggleGod = false
local ToggleAuto = false
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ButtonTP = Instance.new("TextButton")
local ButtonGod = Instance.new("TextButton")
local ButtonAuto = Instance.new("TextButton")

-- UI Setup
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 180)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true

-- Tombol-tombol
local function createBtn(text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Parent = Frame
    btn.Size = UDim2.new(0.9, 0, 0.25, 0)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = color
    btn.TextScaled = true
    btn.TextColor3 = Color3.new(1,1,1)
    return btn
end

ButtonTP = createBtn("TELEPORT KE KOORDINAT", UDim2.new(0.05, 0, 0.05, 0), Color3.fromRGB(0, 120, 255))
ButtonGod = createBtn("GOD MODE: OFF", UDim2.new(0.05, 0, 0.35, 0), Color3.fromRGB(150, 0, 0))
ButtonAuto = createBtn("AUTO PERFECT: OFF", UDim2.new(0.05, 0, 0.65, 0), Color3.fromRGB(150, 0, 0))

-- 1. TELEPORT MANUAL
ButtonTP.MouseButton1Click:Connect(function()
    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(690, 5, 232) end
end)

-- 2. GOD MODE (Agar Selamat dari Tsunami)
ButtonGod.MouseButton1Click:Connect(function()
    ToggleGod = not ToggleGod
    ButtonGod.Text = ToggleGod and "GOD MODE: ON" or "GOD MODE: OFF"
    ButtonGod.BackgroundColor3 = ToggleGod and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    
    task.spawn(function()
        while ToggleGod do
            local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then 
                hum.Health = hum.MaxHealth 
                -- Mencegah status mati agar tidak respawn saat kena tsunami
                hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            end
            task.wait(0.1)
        end
    end)
end)

-- 3. AUTO PERFECT (Passive Clicker)
ButtonAuto.MouseButton1Click:Connect(function()
    ToggleAuto = not ToggleAuto
    ButtonAuto.Text = ToggleAuto and "AUTO PERFECT: ON" or "AUTO PERFECT: OFF"
    ButtonAuto.BackgroundColor3 = ToggleAuto and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    
    local vim = game:GetService("VirtualInputManager")
    task.spawn(function()
        while ToggleAuto do
            task.wait()
            -- Skrip ini mencari bar meteran di PlayerGui
            -- Izar, pastikan nama objek meterannya benar di dalam PlayerGui
            local powerBar = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Bar", true) 
            if powerBar and powerBar.Visible then
                -- Jika bar sudah mencapai 90% ke atas
                if powerBar.Size.Y.Scale >= 0.9 then
                    vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    task.wait(0.05)
                    vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    task.wait(1.5) -- Jeda biar nggak spam klik
                end
            end
        end
    end)
end)
