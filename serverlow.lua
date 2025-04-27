-- Server hop untuk Blox Fruits

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer

-- Fungsi untuk mendapatkan server yang memiliki sedikit pemain
function GetServerList()
    local url = "https://api.roblox.com/groups/29208285/servers"
    local response = HttpService:GetAsync(url)
    local data = HttpService:JSONDecode(response)
    local servers = data["data"]
    
    local lowPopServers = {}
    for _, server in ipairs(servers) do
        if server["players"] < 5 then  -- Misalnya, server dengan kurang dari 5 pemain dianggap sepi
            table.insert(lowPopServers, server["id"])
        end
    end
    
    return lowPopServers
end

-- Fungsi untuk server hop ke server sepi
function HopToLowPopServer()
    local lowPopServers = GetServerList()
    
    if #lowPopServers > 0 then
        local randomServer = lowPopServers[math.random(1, #lowPopServers)]
        TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer)
    else
        print("Tidak ada server sepi yang ditemukan!")
    end
end

-- Menjalankan server hop secara otomatis setiap beberapa detik
while true do
    HopToLowPopServer()
    wait(30) -- Tunggu 30 detik sebelum mencoba server hop lagi
end
