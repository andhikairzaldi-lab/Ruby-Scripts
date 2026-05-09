local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ButtonTP = Instance.new("TextButton")
local ButtonPerfect = Instance.new("TextButton")
local TogglePerfect = false

-- UI Setup (Minimalis agar tidak lag)
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 180, 0, 100)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true
Frame.Draggable = true

ButtonTP.Parent = Frame
ButtonTP.Size = UDim2.new(0.9, 0, 0.4, 0)
ButtonTP.Position = UDim2.new(0.05, 0, 0.05, 0)
ButtonTP.Text = "TP KE FARM"
ButtonTP.TextScaled = true

ButtonPerfect.Parent = Frame
ButtonPerfect.Size = UDim2.new(0.9, 0, 0.4, 0)
ButtonPerfect.Position = UDim2.new(0.05, 0, 0.55, 0)
ButtonPerfect.Text = "AUTO PERFECT: OFF"
ButtonPerfect.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ButtonPerfect.TextScaled = true

-- 1. TELEPORT MANUAL
ButtonTP.MouseButton1Click:Connect(function()
    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(690, 5, 232) end
end)

-- 2. LOGIKA AUTO PERFECT (SABOTASE REMOTE)
local network = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network")
local kickEvent = network:WaitForChild("rev_KickEvent")

ButtonPerfect.MouseButton1Click:Connect(function()
    TogglePerfect = not TogglePerfect
    ButtonPerfect.Text = TogglePerfect and "AUTO PERFECT: ON" or "AUTO PERFECT: OFF"
    ButtonPerfect.BackgroundColor3 = TogglePerfect and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

-- Metatable Hooking: Mengganti isi tendangan menjadi Perfect secara otomatis
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod()

    -- Jika game mencoba mengirim 'rev_KickEvent'
    if TogglePerfect and self == kickEvent and method == "FireServer" then
        -- Kita paksa isinya jadi Perfect (misal angka 1 atau 100)
        -- Kamu bisa ganti angka [1] di bawah ini sesuai hasil eksperimen
        args[1] = 1 
        return oldNamecall(self, unpack(args))
    end

    return oldNamecall(self, ...)
end)
