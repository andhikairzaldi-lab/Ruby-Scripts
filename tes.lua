local ToggleFarm = false
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Button = Instance.new("TextButton")

-- Setup UI Dasar
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 220, 0, 100)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Active = true
Frame.Draggable = true

Button.Parent = Frame
Button.Size = UDim2.new(0.9, 0, 0.8, 0)
Button.Position = UDim2.new(0.05, 0, 0.1, 0)
Button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Button.Text = "START ALL (TP+GOD+PERFECT)"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextScaled = true

-- Fungsi Utama
Button.MouseButton1Click:Connect(function()
    ToggleFarm = not ToggleFarm
    Button.Text = ToggleFarm and "AUTO: ON" or "OFF (RESET CHARACTER)"
    Button.BackgroundColor3 = ToggleFarm and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    
    local player = game.Players.LocalPlayer
    local network = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network")
    local kickEvent = network:WaitForChild("rev_KickEvent")
    local kickCollect = network:WaitForChild("rev_KickCollect")

    if ToggleFarm then
        task.spawn(function()
            while ToggleFarm do
                local char = player.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                local root = char and char:FindFirstChild("HumanoidRootPart")

                if root and hum then
                    -- 1. KEBAL (God Mode dengan Lock Health)
                    hum.Health = hum.MaxHealth
                    
                    -- 2. TELEPORT (Ke koordinat yang kamu kasih: 690, 5, 232)
                    -- Gunakan lerp atau pindah langsung jika jarak terlalu jauh
                    if (root.Position - Vector3.new(690, 5, 232)).Magnitude > 5 then
                        root.CFrame = CFrame.new(690, 5, 232)
                    end

                    -- 3. PERFECT KICK & COLLECT (Berdasarkan hasil Spy kamu)
                    kickEvent:FireServer(1) -- Angka 1 dari hasil Spy
                    task.wait(0.3) -- Jeda agar server tidak mendeteksi spam
                    kickCollect:FireServer()
                end
                task.wait(0.7) -- Jeda antar putaran agar tidak Error 267
            end
        end)
    else
        -- Jika dimatikan, reset karakter agar status kebal/bug hilang
        player.Character:BreakJoints()
    end
end)
