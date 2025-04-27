local ScreenGui = Instance.new("ScreenGui")
local BondLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
BondLabel.Parent = ScreenGui
BondLabel.Size = UDim2.new(0, 200, 0, 50)
BondLabel.Position = UDim2.new(0.5, -100, 0.1, 0)
BondLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BondLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BondLabel.TextScaled = true
BondLabel.Text = "Bond: 0"

local totalBond = 0

local function collectBond()
    totalBond = totalBond + 1
    BondLabel.Text = "Bond: " .. totalBond
end

local function startAutoFarm()
    while true do

        local farmLocation = workspace:WaitForChild("FarmPoint") 
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = farmLocation.CFrame
        
        collectBond()

        wait(1)  -- Tunggu 1 detik
    end
end

startAutoFarm()
