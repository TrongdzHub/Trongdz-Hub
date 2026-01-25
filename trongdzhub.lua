-- Trongdz Hub - Clean Version (Blox Fruits First Sea)

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Trongdz Hub 💗",
    LoadingTitle = "Trongdz Hub",
    LoadingSubtitle = "Blox Fruits",
    Theme = "Dark"
})


-- AUTO FARM LEVEL ALL SEA (SMOOTH)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

-- Anti AFK
player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- CHECK SEA
local function GetSea()
    if game.PlaceId == 2753915549 then
        return 1
    elseif game.PlaceId == 4442272183 then
        return 2
    elseif game.PlaceId == 7449423635 then
        return 3
    end
end

-- QUEST DATA (RÚT GỌN – FARM MƯỢT)
local QuestData = {
    -- SEA 1 (1–700)
    {Sea=1,Min=1,Max=700,Quest="BanditQuest1",Mob="Bandit"},

    -- SEA 2 (700–1500)
    {Sea=2,Min=700,Max=1500,Quest="Area1Quest",Mob="Raider"},

    -- SEA 3 (1500–2800)
    {Sea=3,Min=1500,Max=1799,Quest="PiratePortQuest",Mob="Pirate Millionaire"},
    {Sea=3,Min=1800,Max=2199,Quest="ChocolateQuest1",Mob="Chocolate Bar Battler"},
    {Sea=3,Min=2200,Max=2399,Quest="CakeQuest1",Mob="Cake Guard"},
    {Sea=3,Min=2400,Max=2800,Quest="CakeQuest2",Mob="Head Baker"},
}

-- GET QUEST
local function GetQuest()
    local sea = GetSea()
    local lv = player.Data.Level.Value
    for _,v in pairs(QuestData) do
        if v.Sea == sea and lv >= v.Min and lv <= v.Max then
            return v
        end
    end
end

-- AUTO EQUIP
local function EquipWeapon()
    local char = player.Character
    local hum = char:FindFirstChild("Humanoid")
    if not char:FindFirstChildOfClass("Tool") then
        for _,tool in pairs(player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                hum:EquipTool(tool)
                break
            end
        end
    end
end

-- FARM LOOP (SMOOTH – ĐÁNH GẦN)
task.spawn(function()
    while task.wait(0.35) do
        if getgenv().AutoFarmLevel then
            pcall(function()
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")

                local quest = GetQuest()
                if not quest then return end

                EquipWeapon()

                -- TAKE QUEST
                if not player.PlayerGui.Main.Quest.Visible then
                    Remotes.CommF_:InvokeServer("StartQuest", quest.Quest, 1)
                    task.wait(1)
                end

                -- FIND MOB NEAR
                for _,mob in pairs(workspace.Enemies:GetChildren()) do
                    if mob.Name:find(quest.Mob)
                    and mob:FindFirstChild("HumanoidRootPart")
                    and mob.Humanoid.Health > 0 then

                        -- ĐÁNH GẦN (KHÔNG TELE XA)
                        hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
                        Remotes.CommF_:InvokeServer("Attack")
                        break
                    end
                end
            end)
        end
    end
end)

