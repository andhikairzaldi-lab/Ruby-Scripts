local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 250, 0, 100)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true
Frame.Draggable = true

Button.Parent = Frame
Button.Size = UDim2.new(0.9, 0, 0.6, 0)
Button.Position = UDim2.new(0.05, 0, 0.2, 0)
Button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
Button.Text = "KLIK UNTUK CEK KOORDINAT"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextScaled = true

-- FUNGSI CEK KOORDINAT
Button.MouseButton1Click:Connect(function()
    local pos = root.Position
    -- Membulatkan angka biar gak kepanjangan
    local x = math.floor(pos.X)
    local y = math.floor(pos.Y)
    local z = math.floor(pos.Z)
    
    -- Menampilkan koordinat di tombol
    Button.Text = "X:"..x.." Y:"..y.." Z:"..z
    print("Koordinat Izar: " .. x .. ", " .. y .. ", " .. z)
end)
