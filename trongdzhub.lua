-- Trongdz Hub FIXED – Blox Fruits Full Auto Farm
-- Sea 1 → Sea 3 | Auto Quest | Auto Haki | Fly Above Mob | Fast Hit

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Trongdz Hub 💗",
    LoadingTitle = "Trongdz Hub",
    LoadingSubtitle = "Blox Fruits Farm FIX",
    Theme = "Dark"
})

local FarmTab = Window:CreateTab("Auto Farm 🤖", 6031075938)

getgenv().AutoFarm = false

FarmTab:CreateToggle({
    Name = "Auto Farm Level (All Sea)",
    CurrentValue = false,
    Callback = function(v)
        getgenv().AutoFarm = v
    end
})

-- SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local Remotes = ReplicatedStorage.Remotes

-- ANTI AFK
player.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- AUTO HAKI
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if player.Character and not player.Character:FindFirstChild("HasBuso") then
                Remotes.CommF_:InvokeServer("Buso")
            end
        end)
    end
end)

-- QUEST DATA (RÚT GỌN – CHẠY ỔN)
local QuestData = {
    {1,700,"BanditQuest1","Bandit",1},
    {700,1500,"Area1Quest","Raider",2},
    {1500,1799,"PiratePortQuest","Pirate Millionaire",3},
    {1800,2199,"ChocolateQuest1","Chocolate Bar Battler",3},
    {2200,2399,"CakeQuest1","Cake Guard",3},
    {2400,2800,"CakeQuest2","Head Baker",3},
}

local function GetSea()
    if game.PlaceId == 2753915549 then return 1 end
    if game.PlaceId == 4442272183 then return 2 end
    if game.PlaceId == 7449423635 then return 3 end
end

local function GetQuest()
    local lv = player.Data.Level.Value
    local sea = GetSea()
    for _,q in pairs(QuestData) do
        if q[5] == sea and lv >= q[1] and lv <= q[2] then
            return q
        end
    end
end

local function EquipWeapon()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if hum and not char:FindFirstChildOfClass("Tool") then
        for _,tool in pairs(player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                hum:EquipTool(tool)
                break
            end
        end
    end
end

-- FARM LOOP (FIX ĐÁNH THẬT)
task.spawn(function()
    while task.wait(0.25) do
        if getgenv().AutoFarm then
            pcall(function()
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")

                EquipWeapon()

                local quest = GetQuest()
                if not quest then return end

                if not player.PlayerGui.Main.Quest.Visible then
                    Remotes.CommF_:InvokeServer("StartQuest", quest[3], 1)
                    task.wait(1)
                end

                for _,mob in pairs(workspace.Enemies:GetChildren()) do
                    if mob.Name:find(quest[4])
                    and mob:FindFirstChild("HumanoidRootPart")
                    and mob.Humanoid.Health > 0 then

                        -- BAY TRÊN ĐẦU QUÁI
                        hrp.CFrame = CFrame.new(
                            mob.HumanoidRootPart.Position + Vector3.new(0,6,0),
                            mob.HumanoidRootPart.Position
                        )

                        -- ĐÁNH CHẮC
                        for i=1,3 do
                            Remotes.CommF_:InvokeServer("Attack")
                            task.wait(0.15)
                        end
                        break
                    end
                end
            end)
        end
    end
end)
