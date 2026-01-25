--// Trongdz Hub
--// Pink Theme UI
--// Edited for Trongdz

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Trongdz Hub 💗",
    Icon = 4483362458,
    LoadingTitle = "Trongdz Hub",
    LoadingSubtitle = "Pink Edition",
    Theme = "Dark",

    ConfigurationSaving = {
        Enabled = true,
        FolderName = "TrongdzHub",
        FileName = "PinkConfig"
    }
})

--// CUSTOM PINK THEME
Rayfield:ChangeTheme({
    TextColor = Color3.fromRGB(255, 200, 220),
    Background = Color3.fromRGB(25, 20, 30),
    Topbar = Color3.fromRGB(255, 105, 180),
    Shadow = Color3.fromRGB(0, 0, 0),
    NotificationBackground = Color3.fromRGB(30, 25, 40),
    NotificationActionsBackground = Color3.fromRGB(255, 105, 180)
})

--// MAIN TAB
local MainTab = Window:CreateTab("Main 💗", 6034287594)

MainTab:CreateParagraph({
    Title = "Trongdz Hub",
    Content = "Welcome to Trongdz Hub – Pink UI Edition 🌸"
})

MainTab:CreateButton({
    Name = "Notify Test",
    Callback = function()
        Rayfield:Notify({
            Title = "Trongdz Hub",
            Content = "UI màu hồng đã hoạt động 💗",
            Duration = 5
        })
    end
})

--// FARM TAB
local FarmTab = Window:CreateTab("Auto Farm 🤖", 6031075938)

FarmTab:CreateToggle({
    Name = "Auto Farm (Demo)",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value)
        if Value then
            print("Auto Farm ON")
        else
            print("Auto Farm OFF")
        end
    end
})

--// PLAYER TAB
local PlayerTab = Window:CreateTab("Player 🎮", 6031280882)

PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

PlayerTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 200},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

--// CREDIT TAB
local CreditTab = Window:CreateTab("Credit ❤️", 6031763426)

CreditTab:CreateParagraph({
    Title = "Trongdz Hub",
    Content = "Pink UI • Edited by Trongdz\nEnjoy the script 💕"
})

Rayfield:Notify({
    Title = "Trongdz Hub Loaded",
    Content = "Chúc bạn chơi game vui vẻ 💗",
    Duration = 6
})

local FarmTab = Window:CreateTab("Auto Farm 🤖", 6031075938)
getgenv().AutoFarmQuest = false

FarmTab:CreateToggle({
    Name = "Auto Quest + Farm (First Sea)",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().AutoFarmQuest = Value
    end
})
-- AUTO QUEST LOOP
task.spawn(function()
    while task.wait(0.3) do
        if getgenv().AutoFarmQuest then
            pcall(function()
                local player = game.Players.LocalPlayer
                local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")

                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")

                local level = player.Data.Level.Value

                local questData = {
                    {1,9,"BanditQuest1","Bandit"},
                    {10,14,"BanditQuest1","Monkey"},
                    {15,29,"JungleQuest","Gorilla"},
                    {30,39,"BuggyQuest1","Pirate"},
                    {40,59,"BuggyQuest1","Brute"},
                }

                local quest
                for _,v in pairs(questData) do
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
                    if mob.Name:find(quest[4]) and mob:FindFirstChild("HumanoidRootPart") then
                        hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                        Remotes.CommF_:InvokeServer("Attack")
                        break
                    end
                end
            end)
        end
    end
end)
