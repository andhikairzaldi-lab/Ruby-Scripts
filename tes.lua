local Toggle = false
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Button = Instance.new("TextButton")

-- Setup UI
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 80)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true

Button.Parent = Frame
Button.Size = UDim2.new(0.9, 0, 0.7, 0)
Button.Position = UDim2.new(0.05, 0, 0.15, 0)
Button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Button.Text = "START AUTO FARM"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextScaled = true

-- Fungsi Utama
Button.MouseButton1Click:Connect(function()
    Toggle = not Toggle
    Button.Text = Toggle and "AUTO: ON" or "AUTO: OFF"
    Button.BackgroundColor3 = Toggle and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    
    -- Ambil referensi Network sekali saja agar lebih cepat
    local network = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network")
    local kickEvent = network:WaitForChild("rev_KickEvent")
    local kickCollect = network:WaitForChild("rev_KickCollect")

    task.spawn(function() -- Menggunakan spawn agar tidak menahan fungsi tombol
        while Toggle do
    local player = game.Players.LocalPlayer
    local char = player.Character
    
    if char and char:FindFirstChild("HumanoidRootPart") then
        -- 1. Teleport hanya sesekali (tidak setiap detik)
        local dist = (char.HumanoidRootPart.Position - Vector3.new(690, 5, 232)).Magnitude
        if dist > 10 then -- Hanya teleport kalau jaraknya lebih dari 10 stud
            char.HumanoidRootPart.CFrame = CFrame.new(690, 5, 232)
        end
        
        -- 2. Beri jeda acak (Randomize) agar tidak terlihat seperti robot
        task.wait(math.random(2, 4)) -- Jeda antara 2 sampai 4 detik
        
        -- 3. Kirim sinyal
        kickEvent:FireServer(1)
        task.wait(0.5) 
        kickCollect:FireServer()
    end
    
    task.wait(1) -- Jeda antar putaran lebih lama
                end
                
