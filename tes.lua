local ToggleGod = false
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ButtonTP = Instance.new("TextButton")
local ButtonGod = Instance.new("TextButton")

-- UI Setup
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true

ButtonTP.Parent = Frame
ButtonTP.Size = UDim2.new(0.9, 0, 0.4, 0)
ButtonTP.Position = UDim2.new(0.05, 0, 0.05, 0)
ButtonTP.Text = "TELEPORT KE FARM"
ButtonTP.TextScaled = true

ButtonGod.Parent = Frame
ButtonGod.Size = UDim2.new(0.9, 0, 0.4, 0)
ButtonGod.Position = UDim2.new(0.05, 0, 0.5, 0)
ButtonGod.Text = "GOD MODE: OFF"
ButtonGod.TextScaled = true

-- 1. TELEPORT MANUAL (Sekali Klik)
ButtonTP.MouseButton1Click:Connect(function()
    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame = CFrame.new(690, 5, 232)
    end
end)

-- 2. GOD MODE (Lock Health Passive)
ButtonGod.MouseButton1Click:Connect(function()
    ToggleGod = not ToggleGod
    ButtonGod.Text = ToggleGod and "GOD MODE: ON" or "GOD MODE: OFF"
    ButtonGod.BackgroundColor3 = ToggleGod and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    
    task.spawn(function()
        while ToggleGod do
            local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.Health = hum.MaxHealth end
            task.wait(0.1)
        end
    end)
end)

-- 3. AUTO PERFECT PASSIVE (Membaca UI Meteran)
-- Skrip ini akan menunggu bar muncul dan mengkliknya saat penuh
task.spawn(function()
    local vim = game:GetService("VirtualInputManager")
    while true do
        task.wait()
        -- Cari UI meteran di PlayerGui (nama Bar biasanya 'PowerBar' atau 'Bar')
        -- Ganti "PowerBar" dengan nama asli objek meteran di game tersebut
        local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("PowerBar", true) 
        if gui and gui.Visible then
            -- Logika: Jika besar Bar sudah mencapai > 95%
            if gui.Size.X.Scale >= 0.95 then
                vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                task.wait(0.01)
                vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                task.wait(1) -- Jeda agar tidak klik berkali-kali
            end
        end
    end
end)
