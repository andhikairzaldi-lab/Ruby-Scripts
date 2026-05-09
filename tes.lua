local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Active = true
Frame.Draggable = true

Button.Parent = Frame
Button.Size = UDim2.new(0.8, 0, 0.4, 0)
Button.Position = UDim2.new(0.1, 0, 0.3, 0)
Button.Text = "Klik Aku, Izar!"
Button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Fungsi saat tombol diklik
Button.MouseButton1Click:Connect(function()
    Button.Text = "Berhasil diklik!"
    print("Izar baru saja menekan tombol.")
end)
