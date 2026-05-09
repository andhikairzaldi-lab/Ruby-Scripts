local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 80)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.Active = true
Frame.Draggable = true

Button.Parent = Frame
Button.Size = UDim2.new(0.9, 0, 0.7, 0)
Button.Position = UDim2.new(0.05, 0, 0.15, 0)
Button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Button.Text = "TELEPORT KE FARM"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextScaled = true

-- FUNGSI TELEPORT
Button.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        -- Memasukkan koordinat yang kamu dapatkan tadi
        -- Saya tambah 3 biar kamu jatuhnya pas di atas lantai (nggak nyangkut)
        char.HumanoidRootPart.CFrame = CFrame.new(690, 5, 232) 
        Button.Text = "SAMPAI!"
        wait(1)
        Button.Text = "TELEPORT KE FARM"
    end
end)
