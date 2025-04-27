-- Blox Fruits Auto Farm + Auto Quest + Weapon Use
-- ⚠️ Untuk private server/testing

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("HumanoidRootPart")

-- Config di sini 🔧
local mobName = "Bandit"           -- Nama musuh
local questName = "BanditQuest1"    -- Nama quest (lihat di server)
local questPart = "Bandit"          -- Nama target quest
local weaponName = "Combat"         -- Nama weapon kamu (ganti ke Sword/Fighting style yang kamu pakai)

-- Fungsi ambil quest
function getQuest()
    if not plr.PlayerGui:FindFirstChild("QuestTitle") then
        local questgiver = game.Workspace.NPCs:FindFirstChild(questName)
        if questgiver then
            hum.CFrame = questgiver.Head.CFrame + Vector3.new(0, 5, 0)
            task.wait(1)

            -- Simulasi klik dialog Quest
            local args = {
                [1] = questName,
                [2] = 1 -- biasanya 1 untuk misi pertama
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", unpack(args))
        end
    end
end

-- Fungsi cari musuh terdekat
function getNearestMob()
    local nearest
    local shortestDistance = math.huge

    for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
        if v.Name == mobName and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            local distance = (hum.Position - v.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearest = v
            end
        end
    end

    return nearest
end

-- Equip weapon sebelum farming
function equipWeapon()
    if plr.Backpack:FindFirstChild(weaponName) then
        local tool = plr.Backpack:FindFirstChild(weaponName)
        tool.Parent = char
    end
end

-- Main Auto Farm loop
while true do
    task.wait(0.5)

    -- Cek dan ambil Quest dulu
    getQuest()

    -- Equip weapon
    equipWeapon()

    -- Cari musuh
    local target = getNearestMob()

    if target then
        -- Pindah ke musuh
        hum.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)

        -- Serang musuh pakai basic attack
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:Button1Down(Vector2.new(0,0))
    end
end
