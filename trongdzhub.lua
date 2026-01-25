-- Trongdz Hub 2.0 – Full Blox Fruits Auto Farm
-- Auto Quest All Sea | Fast Attack | Bring Mob | Auto Boss

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- WINDOW
local Window = Rayfield:CreateWindow({
    Name = "Trongdz Hub 💗",
    LoadingTitle = "Trongdz Hub",
    LoadingSubtitle = "Blox Fruits Full Farm",
    Theme = "Dark"
})

-- FARM TAB
local FarmTab = Window:CreateTab("Auto Farm 🤖", 6031075938)

-- TOGGLES
getgenv().AutoFarmLevel = false
getgenv().FastAttack = false
getgenv().BringMob = false
getgenv().AutoBoss = false

FarmTab:CreateToggle({
    Name = "Auto Farm Level (All Sea)",
    CurrentValue = false,
    Callback = function(v) getgenv().AutoFarmLevel = v end
})

FarmTab:CreateToggle({
    Name = "Fast Attack ⚡",
    CurrentValue = false,
    Callback = function(v) getgenv().FastAttack = v end
})

FarmTab:CreateToggle({
    Name = "Bring Mob 🧲",
    CurrentValue = false,
    Callback = function(v) getgenv().BringMob = v end
})

FarmTab:CreateToggle({
    Name = "Auto Boss 👑",
    CurrentValue = false,
    Callback = function(v) getgenv().AutoBoss = v end
})

-- SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

-- ANTI AFK
player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- QUEST DATA (ALL SEA)
local QuestData = {
    {1,700,"BanditQuest1","Bandit",1},
    {700,1500,"Area1Quest","Raider",2},
    {1500,1799,"PiratePortQuest","Pirate Millionaire",3},
    {1800,2199,"ChocolateQuest1","Chocolate Bar Battler",3},
    {2200,2399,"CakeQuest1","Cake Guard",3},
    {2400,2800,"CakeQuest2","Head Baker",3},
}

-- GET QUEST BASED ON SEA + LEVEL
local function GetSea()
    if game.PlaceId == 2753915549 then return 1
    elseif game.PlaceId == 4442272183 then return 2
    elseif game.PlaceId == 7449423635 then return 3 end
end

local function GetQuest()
    local sea = GetSea()
    local lv = player.Data.Level.Value
    for _,v in pairs(QuestData) do
        if v[5] == sea and lv >= v[1] and lv <= v[2] then
            return v
        end
    end
end

-- AUTO EQUIP
local function EquipWeapon()
    local char = player.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum and not char:FindFirstChildOfClass("Tool") then
        for _,tool in pairs(player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                hum:EquipTool(tool)
                break
            end
        end
    end
end

-- FAST ATTACK
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().FastAttack then
            pcall(function()
                Remotes.CommF_:InvokeServer("Attack")
            end)
        end
    end
end)

-- BRING MOB
task.spawn(function()
    while task.wait(0.4) do
        if getgenv().BringMob then
            pcall(function()
                local char = player.Character
                if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                for _,mob in pairs(workspace.Enemies:GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart")
                    and mob:FindFirstChild("Humanoid")
                    and mob.Humanoid.Health > 0 then
                        mob.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(math.random(-4,4),0,math.random(-4,4))
                    end
                end
            end)
        end
    end
end)

-- AUTO FARM LEVEL + BOSS
task.spawn(function()
    while task.wait(0.3) do
        if getgenv().AutoFarmLevel or getgenv().AutoBoss then
            pcall(function()
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")

                EquipWeapon()

                if getgenv().AutoBoss then
                    for _,boss in pairs(workspace.Enemies:GetChildren()) do
                        if boss:FindFirstChild("Humanoid")
                        and boss.Humanoid.Health > 0
                        and (boss.Name:find("Boss") or boss.Name:find("Elite") or boss.Name:find("Dough")) then
                            
                            hrp.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0,0,6)
                            Remotes.CommF_:InvokeServer("Attack")
                            return
                        end
                    end
                end

                if getgenv().AutoFarmLevel then
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
                            hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,0,4)
                            Remotes.CommF_:InvokeServer("Attack")
                            break
                        end
                    end
                end
            end)
        end
    end
end)
