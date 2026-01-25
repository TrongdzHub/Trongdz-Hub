-- Trongdz Hub - Clean Version (Blox Fruits First Sea)

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Trongdz Hub 💗",
    LoadingTitle = "Trongdz Hub",
    LoadingSubtitle = "Blox Fruits",
    Theme = "Dark"
})

-- FARM TAB (CHỈ 1 LẦN)
local FarmTab = Window:CreateTab("Auto Farm 🤖", 6031075938)

getgenv().AutoFarmQuest = false

FarmTab:CreateToggle({
    Name = "Auto Quest + Farm (First Sea)",
    CurrentValue = false,
    Callback = function(v)
        getgenv().AutoFarmQuest = v
    end
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

-- QUEST TABLE (FIRST SEA)
local QuestTable = {
    {1,9,"BanditQuest1","Bandit"},
    {10,14,"BanditQuest1","Monkey"},
    {15,29,"JungleQuest","Gorilla"},
    {30,39,"BuggyQuest1","Pirate"},
    {40,59,"BuggyQuest1","Brute"},
}

-- FARM LOOP
task.spawn(function()
    while task.wait(0.3) do
        if getgenv().AutoFarmQuest then
            pcall(function()
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")
                local level = player.Data.Level.Value

                local quest
                for _,v in pairs(QuestTable) do
                    if level >= v[1] and level <= v[2] then
                        quest = v
                    end
                end
                if not quest then return end

                if not player.PlayerGui.Main.Quest.Visible then
                    Remotes.CommF_:InvokeServer("StartQuest", quest[3], 1)
                    task.wait(1)
                end

                for _,mob in pairs(workspace.Enemies:GetChildren()) do
                    if mob.Name:find(quest[4])
                    and mob:FindFirstChild("HumanoidRootPart")
                    and mob.Humanoid.Health > 0 then
                        hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                        Remotes.CommF_:InvokeServer("Attack")
                        break
                    end
                end
            end)
        end
    end
end)
