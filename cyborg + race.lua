getgenv().Weapon = "Melee"
getgenv().Team = "Pirates"
_G.AutoCyborg = true

local a = CFrame.new(0, 20, 0)
PosY = 35
TweenSpeed = 300
if game.PlaceId == 2753915549 then
    World1 = true
elseif game.PlaceId == 4442272183 then
    World2 = true
elseif game.PlaceId == 7449423635 then
    World3 = true
else
    game:GetService("Players").LocalPlayer:Kick("This Game Is Not Support [ Hub ]")
end
if getgenv().Team == "Marines" then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
elseif getgenv().Team == "Pirates" then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
end
local function s2() 
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    wait(2)
end
s2()
repeat
    task.wait(1)
    if
        game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("ChooseTeam", true) and
            game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("ChooseTeam", true).Visible and
            game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("UIController", true)
     then
        for b, c in pairs(getgc(true)) do
            if
                type(c) == "function" and
                    getfenv(c).script ==
                        game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild(
                            "UIController",
                            true
                        )
             then
                local d = getconstants(c)
                pcall(
                    function()
                        if (d[1] == "Pirates" or d[1] == "Marines") and #d == 1 then
                            if d[1] == getgenv().Team then
                                c(getgenv().Team)
                            end
                        end
                    end
                )
            end
        end
    end
until game:GetService("Players").LocalPlayer.Team
function CheckQuest()
    MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
    if World1 then
        if MyLevel == 1 or MyLevel <= 9 then
            Mon = "Bandit"
            LevelQuest = 1
            NameQuest = "BanditQuest1"
            NameMon = "Bandit"
            CFrameQuest =
                CFrame.new(
                1059.37195,
                15.4495068,
                1550.4231,
                0.939700544,
                -0,
                -0.341998369,
                0,
                1,
                -0,
                0.341998369,
                0,
                0.939700544
            )
            CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
        elseif MyLevel == 10 or MyLevel <= 14 then
            Mon = "Monkey"
            LevelQuest = 1
            NameQuest = "JungleQuest"
            NameMon = "Monkey"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)
        elseif MyLevel == 15 or MyLevel <= 29 then
            Mon = "Gorilla"
            LevelQuest = 2
            NameQuest = "JungleQuest"
            NameMon = "Gorilla"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875)
        elseif MyLevel == 30 or MyLevel <= 39 then
            Mon = "Pirate"
            LevelQuest = 1
            NameQuest = "BuggyQuest1"
            NameMon = "Pirate"
            CFrameQuest =
                CFrame.new(
                -1141.07483,
                4.10001802,
                3831.5498,
                0.965929627,
                -0,
                -0.258804798,
                0,
                1,
                -0,
                0.258804798,
                0,
                0.965929627
            )
            CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)
        elseif MyLevel == 40 or MyLevel <= 59 then
            Mon = "Brute"
            LevelQuest = 2
            NameQuest = "BuggyQuest1"
            NameMon = "Brute"
            CFrameQuest =
                CFrame.new(
                -1141.07483,
                4.10001802,
                3831.5498,
                0.965929627,
                -0,
                -0.258804798,
                0,
                1,
                -0,
                0.258804798,
                0,
                0.965929627
            )
            CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
        elseif MyLevel == 60 or MyLevel <= 74 then
            Mon = "Desert Bandit"
            LevelQuest = 1
            NameQuest = "DesertQuest"
            NameMon = "Desert Bandit"
            CFrameQuest =
                CFrame.new(
                894.488647,
                5.14000702,
                4392.43359,
                0.819155693,
                -0,
                -0.573571265,
                0,
                1,
                -0,
                0.573571265,
                0,
                0.819155693
            )
            CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
        elseif MyLevel == 75 or MyLevel <= 89 then
            Mon = "Desert Officer"
            LevelQuest = 2
            NameQuest = "DesertQuest"
            NameMon = "Desert Officer"
            CFrameQuest =
                CFrame.new(
                894.488647,
                5.14000702,
                4392.43359,
                0.819155693,
                -0,
                -0.573571265,
                0,
                1,
                -0,
                0.573571265,
                0,
                0.819155693
            )
            CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)
        elseif MyLevel == 90 or MyLevel <= 99 then
            Mon = "Snow Bandit"
            LevelQuest = 1
            NameQuest = "SnowQuest"
            NameMon = "Snow Bandit"
            CFrameQuest =
                CFrame.new(
                1389.74451,
                88.1519318,
                -1298.90796,
                -0.342042685,
                0,
                0.939684391,
                0,
                1,
                0,
                -0.939684391,
                0,
                -0.342042685
            )
            CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125)
        elseif MyLevel == 100 or MyLevel <= 119 then
            Mon = "Snowman"
            LevelQuest = 2
            NameQuest = "SnowQuest"
            NameMon = "Snowman"
            CFrameQuest =
                CFrame.new(
                1389.74451,
                88.1519318,
                -1298.90796,
                -0.342042685,
                0,
                0.939684391,
                0,
                1,
                0,
                -0.939684391,
                0,
                -0.342042685
            )
            CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625)
        elseif MyLevel == 120 or MyLevel <= 149 then
            Mon = "Chief Petty Officer"
            LevelQuest = 1
            NameQuest = "MarineQuest2"
            NameMon = "Chief Petty Officer"
            CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625)
        elseif MyLevel == 150 or MyLevel <= 174 then
            Mon = "Sky Bandit"
            LevelQuest = 1
            NameQuest = "SkyQuest"
            NameMon = "Sky Bandit"
            CFrameQuest =
                CFrame.new(
                -4839.53027,
                716.368591,
                -2619.44165,
                0.866007268,
                0,
                0.500031412,
                0,
                1,
                0,
                -0.500031412,
                0,
                0.866007268
            )
            CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)
        elseif MyLevel == 175 or MyLevel <= 189 then
            Mon = "Dark Master"
            LevelQuest = 2
            NameQuest = "SkyQuest"
            NameMon = "Dark Master"
            CFrameQuest =
                CFrame.new(
                -4839.53027,
                716.368591,
                -2619.44165,
                0.866007268,
                0,
                0.500031412,
                0,
                1,
                0,
                -0.500031412,
                0,
                0.866007268
            )
            CFrameMon = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625)
        elseif MyLevel == 190 or MyLevel <= 209 then
            Mon = "Prisoner"
            LevelQuest = 1
            NameQuest = "PrisonerQuest"
            NameMon = "Prisoner"
            CFrameQuest =
                CFrame.new(
                5308.93115,
                1.65517521,
                475.120514,
                -0.0894274712,
                -5.00292918e-09,
                -0.995993316,
                1.60817859e-09,
                1,
                -5.16744869e-09,
                0.995993316,
                -2.06384709e-09,
                -0.0894274712
            )
            CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
        elseif MyLevel == 210 or MyLevel <= 249 then
            Mon = "Dangerous Prisoner"
            LevelQuest = 2
            NameQuest = "PrisonerQuest"
            NameMon = "Dangerous Prisoner"
            CFrameQuest =
                CFrame.new(
                5308.93115,
                1.65517521,
                475.120514,
                -0.0894274712,
                -5.00292918e-09,
                -0.995993316,
                1.60817859e-09,
                1,
                -5.16744869e-09,
                0.995993316,
                -2.06384709e-09,
                -0.0894274712
            )
            CFrameMon = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375)
        elseif MyLevel == 250 or MyLevel <= 274 then
            Mon = "Toga Warrior"
            LevelQuest = 1
            NameQuest = "ColosseumQuest"
            NameMon = "Toga Warrior"
            CFrameQuest =
                CFrame.new(
                -1580.04663,
                6.35000277,
                -2986.47534,
                -0.515037298,
                0,
                -0.857167721,
                0,
                1,
                0,
                0.857167721,
                0,
                -0.515037298
            )
            CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
        elseif MyLevel == 275 or MyLevel <= 299 then
            Mon = "Gladiator"
            LevelQuest = 2
            NameQuest = "ColosseumQuest"
            NameMon = "Gladiator"
            CFrameQuest =
                CFrame.new(
                -1580.04663,
                6.35000277,
                -2986.47534,
                -0.515037298,
                0,
                -0.857167721,
                0,
                1,
                0,
                0.857167721,
                0,
                -0.515037298
            )
            CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
        elseif MyLevel == 300 or MyLevel <= 324 then
            Mon = "Military Soldier"
            LevelQuest = 1
            NameQuest = "MagmaQuest"
            NameMon = "Military Soldier"
            CFrameQuest =
                CFrame.new(
                -5313.37012,
                10.9500084,
                8515.29395,
                -0.499959469,
                0,
                0.866048813,
                0,
                1,
                0,
                -0.866048813,
                0,
                -0.499959469
            )
            CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
        elseif MyLevel == 325 or MyLevel <= 374 then
            Mon = "Military Spy"
            LevelQuest = 2
            NameQuest = "MagmaQuest"
            NameMon = "Military Spy"
            CFrameQuest =
                CFrame.new(
                -5313.37012,
                10.9500084,
                8515.29395,
                -0.499959469,
                0,
                0.866048813,
                0,
                1,
                0,
                -0.866048813,
                0,
                -0.499959469
            )
            CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
        elseif MyLevel == 375 or MyLevel <= 399 then
            Mon = "Fishman Warrior"
            LevelQuest = 1
            NameQuest = "FishmanQuest"
            NameMon = "Fishman Warrior"
            CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
            if
                _G.AutoFarm and
                    (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >
                        10000
             then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                    "requestEntrance",
                    Vector3.new(61163.8515625, 11.6796875, 1819.7841796875)
                )
            end
        elseif MyLevel == 400 or MyLevel <= 449 then
            Mon = "Fishman Commando"
            LevelQuest = 2
            NameQuest = "FishmanQuest"
            NameMon = "Fishman Commando"
            CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
            if
                _G.AutoFarm and
                    (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >
                        10000
             then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                    "requestEntrance",
                    Vector3.new(61163.8515625, 11.6796875, 1819.7841796875)
                )
            end
        elseif MyLevel == 450 or MyLevel <= 474 then
            Mon = "God's Guard"
            LevelQuest = 1
            NameQuest = "SkyExp1Quest"
            NameMon = "God's Guard"
            CFrameQuest =
                CFrame.new(
                -4721.88867,
                843.874695,
                -1949.96643,
                0.996191859,
                -0,
                -0.0871884301,
                0,
                1,
                -0,
                0.0871884301,
                0,
                0.996191859
            )
            CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
            if
                _G.AutoFarm and
                    (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >
                        10000
             then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                    "requestEntrance",
                    Vector3.new(-4607.82275, 872.54248, -1667.55688)
                )
            end
        elseif MyLevel == 475 or MyLevel <= 524 then
            Mon = "Shanda"
            LevelQuest = 2
            NameQuest = "SkyExp1Quest"
            NameMon = "Shanda"
            CFrameQuest =
                CFrame.new(
                -7859.09814,
                5544.19043,
                -381.476196,
                -0.422592998,
                0,
                0.906319618,
                0,
                1,
                0,
                -0.906319618,
                0,
                -0.422592998
            )
            CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
            if
                _G.AutoFarm and
                    (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >
                        10000
             then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                    "requestEntrance",
                    Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047)
                )
            end
        elseif MyLevel == 525 or MyLevel <= 549 then
            Mon = "Royal Squad"
            LevelQuest = 1
            NameQuest = "SkyExp2Quest"
            NameMon = "Royal Squad"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
        elseif MyLevel == 550 or MyLevel <= 624 then
            Mon = "Royal Soldier"
            LevelQuest = 2
            NameQuest = "SkyExp2Quest"
            NameMon = "Royal Soldier"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
        elseif MyLevel == 625 or MyLevel <= 649 then
            Mon = "Galley Pirate"
            LevelQuest = 1
            NameQuest = "FountainQuest"
            NameMon = "Galley Pirate"
            CFrameQuest =
                CFrame.new(
                5259.81982,
                37.3500175,
                4050.0293,
                0.087131381,
                0,
                0.996196866,
                0,
                1,
                0,
                -0.996196866,
                0,
                0.087131381
            )
            CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
        elseif MyLevel >= 650 then
            Mon = "Galley Captain"
            LevelQuest = 2
            NameQuest = "FountainQuest"
            NameMon = "Galley Captain"
            CFrameQuest =
                CFrame.new(
                5259.81982,
                37.3500175,
                4050.0293,
                0.087131381,
                0,
                0.996196866,
                0,
                1,
                0,
                -0.996196866,
                0,
                0.087131381
            )
            CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
        end
    elseif World2 then
        if MyLevel == 700 or MyLevel <= 724 then
            Mon = "Raider"
            LevelQuest = 1
            NameQuest = "Area1Quest"
            NameMon = "Raider"
            CFrameQuest =
                CFrame.new(
                -429.543518,
                71.7699966,
                1836.18188,
                -0.22495985,
                0,
                -0.974368095,
                0,
                1,
                0,
                0.974368095,
                0,
                -0.22495985
            )
            CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)
        elseif MyLevel == 725 or MyLevel <= 774 then
            Mon = "Mercenary"
            LevelQuest = 2
            NameQuest = "Area1Quest"
            NameMon = "Mercenary"
            CFrameQuest =
                CFrame.new(
                -429.543518,
                71.7699966,
                1836.18188,
                -0.22495985,
                0,
                -0.974368095,
                0,
                1,
                0,
                0.974368095,
                0,
                -0.22495985
            )
            CFrameMon = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625)
        elseif MyLevel == 775 or MyLevel <= 799 then
            Mon = "Swan Pirate"
            LevelQuest = 1
            NameQuest = "Area2Quest"
            NameMon = "Swan Pirate"
            CFrameQuest =
                CFrame.new(
                638.43811,
                71.769989,
                918.282898,
                0.139203906,
                0,
                0.99026376,
                0,
                1,
                0,
                -0.99026376,
                0,
                0.139203906
            )
            CFrameMon = CFrame.new(1068.664306640625, 137.61428833007812, 1322.1060791015625)
        elseif MyLevel == 800 or MyLevel <= 874 then
            Mon = "Factory Staff"
            NameQuest = "Area2Quest"
            LevelQuest = 2
            NameMon = "Factory Staff"
            CFrameQuest =
                CFrame.new(
                632.698608,
                73.1055908,
                918.666321,
                -0.0319722369,
                8.96074881e-10,
                -0.999488771,
                1.36326533e-10,
                1,
                8.92172336e-10,
                0.999488771,
                -1.07732087e-10,
                -0.0319722369
            )
            CFrameMon = CFrame.new(73.07867431640625, 81.86344146728516, -27.470672607421875)
        elseif MyLevel == 875 or MyLevel <= 899 then
            Mon = "Marine Lieutenant"
            LevelQuest = 1
            NameQuest = "MarineQuest3"
            NameMon = "Marine Lieutenant"
            CFrameQuest =
                CFrame.new(
                -2440.79639,
                71.7140732,
                -3216.06812,
                0.866007268,
                0,
                0.500031412,
                0,
                1,
                0,
                -0.500031412,
                0,
                0.866007268
            )
            CFrameMon = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
        elseif MyLevel == 900 or MyLevel <= 949 then
            Mon = "Marine Captain"
            LevelQuest = 2
            NameQuest = "MarineQuest3"
            NameMon = "Marine Captain"
            CFrameQuest =
                CFrame.new(
                -2440.79639,
                71.7140732,
                -3216.06812,
                0.866007268,
                0,
                0.500031412,
                0,
                1,
                0,
                -0.500031412,
                0,
                0.866007268
            )
            CFrameMon = CFrame.new(-1861.2310791015625, 80.17658233642578, -3254.697509765625)
        elseif MyLevel == 950 or MyLevel <= 974 then
            Mon = "Zombie"
            LevelQuest = 1
            NameQuest = "ZombieQuest"
            NameMon = "Zombie"
            CFrameQuest =
                CFrame.new(
                -5497.06152,
                47.5923004,
                -795.237061,
                -0.29242146,
                0,
                -0.95628953,
                0,
                1,
                0,
                0.95628953,
                0,
                -0.29242146
            )
            CFrameMon = CFrame.new(-5657.77685546875, 78.96973419189453, -928.68701171875)
        elseif MyLevel == 975 or MyLevel <= 999 then
            Mon = "Vampire"
            LevelQuest = 2
            NameQuest = "ZombieQuest"
            NameMon = "Vampire"
            CFrameQuest =
                CFrame.new(
                -5497.06152,
                47.5923004,
                -795.237061,
                -0.29242146,
                0,
                -0.95628953,
                0,
                1,
                0,
                0.95628953,
                0,
                -0.29242146
            )
            CFrameMon = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625)
        elseif MyLevel == 1000 or MyLevel <= 1049 then
            Mon = "Snow Trooper"
            LevelQuest = 1
            NameQuest = "SnowMountainQuest"
            NameMon = "Snow Trooper"
            CFrameQuest =
                CFrame.new(
                609.858826,
                400.119904,
                -5372.25928,
                -0.374604106,
                0,
                0.92718488,
                0,
                1,
                0,
                -0.92718488,
                0,
                -0.374604106
            )
            CFrameMon = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875)
        elseif MyLevel == 1050 or MyLevel <= 1099 then
            Mon = "Winter Warrior"
            LevelQuest = 2
            NameQuest = "SnowMountainQuest"
            NameMon = "Winter Warrior"
            CFrameQuest =
                CFrame.new(
                609.858826,
                400.119904,
                -5372.25928,
                -0.374604106,
                0,
                0.92718488,
                0,
                1,
                0,
                -0.92718488,
                0,
                -0.374604106
            )
            CFrameMon = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625)
        elseif MyLevel == 1100 or MyLevel <= 1124 then
            Mon = "Lab Subordinate"
            LevelQuest = 1
            NameQuest = "IceSideQuest"
            NameMon = "Lab Subordinate"
            CFrameQuest =
                CFrame.new(
                -6064.06885,
                15.2422857,
                -4902.97852,
                0.453972578,
                -0,
                -0.891015649,
                0,
                1,
                -0,
                0.891015649,
                0,
                0.453972578
            )
            CFrameMon = CFrame.new(-5707.4716796875, 15.951709747314453, -4513.39208984375)
        elseif MyLevel == 1125 or MyLevel <= 1174 then
            Mon = "Horned Warrior"
            LevelQuest = 2
            NameQuest = "IceSideQuest"
            NameMon = "Horned Warrior"
            CFrameQuest =
                CFrame.new(
                -6064.06885,
                15.2422857,
                -4902.97852,
                0.453972578,
                -0,
                -0.891015649,
                0,
                1,
                -0,
                0.891015649,
                0,
                0.453972578
            )
            CFrameMon = CFrame.new(-6341.36669921875, 15.951770782470703, -5723.162109375)
        elseif MyLevel == 1175 or MyLevel <= 1199 then
            Mon = "Magma Ninja"
            LevelQuest = 1
            NameQuest = "FireSideQuest"
            NameMon = "Magma Ninja"
            CFrameQuest =
                CFrame.new(
                -5428.03174,
                15.0622921,
                -5299.43457,
                -0.882952213,
                0,
                0.469463557,
                0,
                1,
                0,
                -0.469463557,
                0,
                -0.882952213
            )
            CFrameMon = CFrame.new(-5449.6728515625, 76.65874481201172, -5808.20068359375)
        elseif MyLevel == 1200 or MyLevel <= 1249 then
            Mon = "Lava Pirate"
            LevelQuest = 2
            NameQuest = "FireSideQuest"
            NameMon = "Lava Pirate"
            CFrameQuest =
                CFrame.new(
                -5428.03174,
                15.0622921,
                -5299.43457,
                -0.882952213,
                0,
                0.469463557,
                0,
                1,
                0,
                -0.469463557,
                0,
                -0.882952213
            )
            CFrameMon = CFrame.new(-5213.33154296875, 49.73788070678711, -4701.451171875)
        elseif MyLevel == 1250 or MyLevel <= 1274 then
            Mon = "Ship Deckhand"
            LevelQuest = 1
            NameQuest = "ShipQuest1"
            NameMon = "Ship Deckhand"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
            CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375)
            if
                _G.AutoFarm and
                    (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >
                        10000
             then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                    "requestEntrance",
                    Vector3.new(923.21252441406, 126.9760055542, 32852.83203125)
                )
            end
        elseif MyLevel == 1275 or MyLevel <= 1299 then
            Mon = "Ship Engineer"
            LevelQuest = 2
            NameQuest = "ShipQuest1"
            NameMon = "Ship Engineer"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
            CFrameMon = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875)
            if
                _G.AutoFarm and
                    (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >
                        10000
             then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                    "requestEntrance",
                    Vector3.new(923.21252441406, 126.9760055542, 32852.83203125)
                )
            end
        elseif MyLevel == 1300 or MyLevel <= 1324 then
            Mon = "Ship Steward"
            LevelQuest = 1
            NameQuest = "ShipQuest2"
            NameMon = "Ship Steward"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
            CFrameMon = CFrame.new(919.4385375976562, 129.55599975585938, 33436.03515625)
            if
                _G.AutoFarm and
                    (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >
                        10000
             then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                    "requestEntrance",
                    Vector3.new(923.21252441406, 126.9760055542, 32852.83203125)
                )
            end
        elseif MyLevel == 1325 or MyLevel <= 1349 then
            Mon = "Ship Officer"
            LevelQuest = 2
            NameQuest = "ShipQuest2"
            NameMon = "Ship Officer"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
            CFrameMon = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625)
            if
                _G.AutoFarm and
                    (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >
                        10000
             then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                    "requestEntrance",
                    Vector3.new(923.21252441406, 126.9760055542, 32852.83203125)
                )
            end
        elseif MyLevel == 1350 or MyLevel <= 1374 then
            Mon = "Arctic Warrior"
            LevelQuest = 1
            NameQuest = "FrostQuest"
            NameMon = "Arctic Warrior"
            CFrameQuest =
                CFrame.new(
                5667.6582,
                26.7997818,
                -6486.08984,
                -0.933587909,
                0,
                -0.358349502,
                0,
                1,
                0,
                0.358349502,
                0,
                -0.933587909
            )
            CFrameMon = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125)
            if
                _G.AutoFarm and
                    (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >
                        10000
             then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                    "requestEntrance",
                    Vector3.new(-6508.5581054688, 5000.034996032715, -132.83953857422)
                )
            end
        elseif MyLevel == 1375 or MyLevel <= 1424 then
            Mon = "Snow Lurker"
            LevelQuest = 2
            NameQuest = "FrostQuest"
            NameMon = "Snow Lurker"
            CFrameQuest =
                CFrame.new(
                5667.6582,
                26.7997818,
                -6486.08984,
                -0.933587909,
                0,
                -0.358349502,
                0,
                1,
                0,
                0.358349502,
                0,
                -0.933587909
            )
            CFrameMon = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375)
        elseif MyLevel == 1425 or MyLevel <= 1449 then
            Mon = "Sea Soldier"
            LevelQuest = 1
            NameQuest = "ForgottenQuest"
            NameMon = "Sea Soldier"
            CFrameQuest =
                CFrame.new(
                -3054.44458,
                235.544281,
                -10142.8193,
                0.990270376,
                -0,
                -0.13915664,
                0,
                1,
                -0,
                0.13915664,
                0,
                0.990270376
            )
            CFrameMon = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
        elseif MyLevel >= 1450 then
            Mon = "Water Fighter"
            LevelQuest = 2
            NameQuest = "ForgottenQuest"
            NameMon = "Water Fighter"
            CFrameQuest =
                CFrame.new(
                -3054.44458,
                235.544281,
                -10142.8193,
                0.990270376,
                -0,
                -0.13915664,
                0,
                1,
                -0,
                0.13915664,
                0,
                0.990270376
            )
            CFrameMon = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875)
        end
    elseif World3 then
        if MyLevel == 1500 or MyLevel <= 1524 then
            Mon = "Pirate Millionaire"
            LevelQuest = 1
            NameQuest = "PiratePortQuest"
            NameMon = "Pirate Millionaire"
            CFrameQuest =
                CFrame.new(
                -450.104645,
                107.681458,
                5950.72607,
                0.957107544,
                -0,
                -0.289732844,
                0,
                1,
                -0,
                0.289732844,
                0,
                0.957107544
            )
            CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)
        elseif MyLevel == 1525 or MyLevel <= 1574 then
            Mon = "Pistol Billionaire"
            LevelQuest = 2
            NameQuest = "PiratePortQuest"
            NameMon = "Pistol Billionaire"
            CFrameQuest =
                CFrame.new(
                -450.104645,
                107.681458,
                5950.72607,
                0.957107544,
                -0,
                -0.289732844,
                0,
                1,
                -0,
                0.289732844,
                0,
                0.957107544
            )
            CFrameMon =
                CFrame.new(
                -54.8110352,
                83.7698746,
                5947.84082,
                -0.965929747,
                0,
                0.258804798,
                0,
                1,
                0,
                -0.258804798,
                0,
                -0.965929747
            )
        elseif MyLevel == 1575 or MyLevel <= 1599 then
            Mon = "Dragon Crew Warrior"
            LevelQuest = 1
            NameQuest = "DragonCrewQuest"
            NameMon = "Dragon Crew Warrior"
            CFrameQuest = CFrame.new(6750.4931640625, 127.44916534423828, -711.0308837890625)
            CFrameMon =
                CFrame.new(
                6709.76367,
                52.3442993,
                -1139.02966,
                -0.763515472,
                0,
                0.645789504,
                0,
                1,
                0,
                -0.645789504,
                0,
                -0.763515472
            )
        elseif MyLevel == 1600 or MyLevel <= 1624 then
            Mon = "Dragon Crew Archer"
            NameQuest = "DragonCrewQuest"
            LevelQuest = 2
            NameMon = "Dragon Crew Archer"
            CFrameQuest = CFrame.new(6750.4931640625, 127.44916534423828, -711.0308837890625)
            CFrameMon =
                CFrame.new(
                6668.76172,
                481.376923,
                329.12207,
                -0.121787429,
                0,
                -0.992556155,
                0,
                1,
                0,
                0.992556155,
                0,
                -0.121787429
            )
        elseif MyLevel == 1625 or MyLevel <= 1649 then
            Mon = "Hydra Enforcer"
            NameQuest = "VenomCrewQuest"
            LevelQuest = 1
            NameMon = "Hydra Enforcer"
            CFrameQuest = CFrame.new(5206.40185546875, 1004.10498046875, 748.3504638671875)
            CFrameMon =
                CFrame.new(
                4547.11523,
                1003.10217,
                334.194824,
                0.388810456,
                -0,
                -0.921317935,
                0,
                1,
                -0,
                0.921317935,
                0,
                0.388810456
            )
        elseif MyLevel == 1650 or MyLevel <= 1699 then
            Mon = "Venomous Assailant"
            NameQuest = "VenomCrewQuest"
            LevelQuest = 2
            NameMon = "Venomous Assailant"
            CFrameQuest = CFrame.new(5206.40185546875, 1004.10498046875, 748.3504638671875)
            CFrameMon =
                CFrame.new(
                4674.92676,
                1134.82654,
                996.308838,
                0.731321394,
                -0,
                -0.682033002,
                0,
                1,
                -0,
                0.682033002,
                0,
                0.731321394
            )
        elseif MyLevel == 1700 or MyLevel <= 1724 then
            Mon = "Marine Commodore"
            LevelQuest = 1
            NameQuest = "MarineTreeIsland"
            NameMon = "Marine Commodore"
            CFrameQuest =
                CFrame.new(
                2180.54126,
                27.8156815,
                -6741.5498,
                -0.965929747,
                0,
                0.258804798,
                0,
                1,
                0,
                -0.258804798,
                0,
                -0.965929747
            )
            CFrameMon = CFrame.new(2286.0078125, 73.13391876220703, -7159.80908203125)
        elseif MyLevel == 1725 or MyLevel <= 1774 then
            Mon = "Marine Rear Admiral [Lv. 1725]"
            NameMon = "Marine Rear Admiral"
            NameQuest = "MarineTreeIsland"
            LevelQuest = 2
            CFrameQuest = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
            CFrameMon = CFrame.new(3656.773681640625, 160.52406311035156, -7001.5986328125)
        elseif MyLevel == 1775 or MyLevel <= 1799 then
            Mon = "Fishman Raider"
            LevelQuest = 1
            NameQuest = "DeepForestIsland3"
            NameMon = "Fishman Raider"
            CFrameQuest =
                CFrame.new(
                -10581.6563,
                330.872955,
                -8761.18652,
                -0.882952213,
                0,
                0.469463557,
                0,
                1,
                0,
                -0.469463557,
                0,
                -0.882952213
            )
            CFrameMon = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
        elseif MyLevel == 1800 or MyLevel <= 1824 then
            Mon = "Fishman Captain"
            LevelQuest = 2
            NameQuest = "DeepForestIsland3"
            NameMon = "Fishman Captain"
            CFrameQuest =
                CFrame.new(
                -10581.6563,
                330.872955,
                -8761.18652,
                -0.882952213,
                0,
                0.469463557,
                0,
                1,
                0,
                -0.469463557,
                0,
                -0.882952213
            )
            CFrameMon = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625)
        elseif MyLevel == 1825 or MyLevel <= 1849 then
            Mon = "Forest Pirate"
            LevelQuest = 1
            NameQuest = "DeepForestIsland"
            NameMon = "Forest Pirate"
            CFrameQuest =
                CFrame.new(
                -13234.04,
                331.488495,
                -7625.40137,
                0.707134247,
                -0,
                -0.707079291,
                0,
                1,
                -0,
                0.707079291,
                0,
                0.707134247
            )
            CFrameMon = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
        elseif MyLevel == 1850 or MyLevel <= 1899 then
            Mon = "Mythological Pirate"
            LevelQuest = 2
            NameQuest = "DeepForestIsland"
            NameMon = "Mythological Pirate"
            CFrameQuest =
                CFrame.new(
                -13234.04,
                331.488495,
                -7625.40137,
                0.707134247,
                -0,
                -0.707079291,
                0,
                1,
                -0,
                0.707079291,
                0,
                0.707134247
            )
            CFrameMon = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
        elseif MyLevel == 1900 or MyLevel <= 1924 then
            Mon = "Jungle Pirate"
            LevelQuest = 1
            NameQuest = "DeepForestIsland2"
            NameMon = "Jungle Pirate"
            CFrameQuest =
                CFrame.new(
                -12680.3818,
                389.971039,
                -9902.01953,
                -0.0871315002,
                0,
                0.996196866,
                0,
                1,
                0,
                -0.996196866,
                0,
                -0.0871315002
            )
            CFrameMon = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
        elseif MyLevel == 1925 or MyLevel <= 1974 then
            Mon = "Musketeer Pirate"
            LevelQuest = 2
            NameQuest = "DeepForestIsland2"
            NameMon = "Musketeer Pirate"
            CFrameQuest =
                CFrame.new(
                -12680.3818,
                389.971039,
                -9902.01953,
                -0.0871315002,
                0,
                0.996196866,
                0,
                1,
                0,
                -0.996196866,
                0,
                -0.0871315002
            )
            CFrameMon = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
        elseif MyLevel == 1975 or MyLevel <= 1999 then
            Mon = "Reborn Skeleton"
            LevelQuest = 1
            NameQuest = "HauntedQuest1"
            NameMon = "Reborn Skeleton"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
        elseif MyLevel == 2000 or MyLevel <= 2024 then
            Mon = "Living Zombie"
            LevelQuest = 2
            NameQuest = "HauntedQuest1"
            NameMon = "Living Zombie"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875)
        elseif MyLevel == 2025 or MyLevel <= 2049 then
            Mon = "Demonic Soul"
            LevelQuest = 1
            NameQuest = "HauntedQuest2"
            NameMon = "Demonic Soul"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625)
        elseif MyLevel == 2050 or MyLevel <= 2074 then
            Mon = "Posessed Mummy"
            LevelQuest = 2
            NameQuest = "HauntedQuest2"
            NameMon = "Posessed Mummy"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-9582.0224609375, 6.251527309417725, 6205.478515625)
        elseif MyLevel == 2075 or MyLevel <= 2099 then
            Mon = "Peanut Scout"
            LevelQuest = 1
            NameQuest = "NutsIslandQuest"
            NameMon = "Peanut Scout"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875)
        elseif MyLevel == 2100 or MyLevel <= 2124 then
            Mon = "Peanut President"
            LevelQuest = 2
            NameQuest = "NutsIslandQuest"
            NameMon = "Peanut President"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
        elseif MyLevel == 2125 or MyLevel <= 2149 then
            Mon = "Ice Cream Chef"
            LevelQuest = 1
            NameQuest = "IceCreamIslandQuest"
            NameMon = "Ice Cream Chef"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
        elseif MyLevel == 2150 or MyLevel <= 2199 then
            Mon = "Ice Cream Commander"
            LevelQuest = 2
            NameQuest = "IceCreamIslandQuest"
            NameMon = "Ice Cream Commander"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
        elseif MyLevel == 2200 or MyLevel <= 2224 then
            Mon = "Cookie Crafter"
            LevelQuest = 1
            NameQuest = "CakeQuest1"
            NameMon = "Cookie Crafter"
            CFrameQuest =
                CFrame.new(
                -2021.32007,
                37.7982254,
                -12028.7295,
                0.957576931,
                -8.80302053e-08,
                0.288177818,
                6.9301187e-08,
                1,
                7.51931211e-08,
                -0.288177818,
                -5.2032135e-08,
                0.957576931
            )
            CFrameMon = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375)
        elseif MyLevel == 2225 or MyLevel <= 2249 then
            Mon = "Cake Guard"
            LevelQuest = 2
            NameQuest = "CakeQuest1"
            NameMon = "Cake Guard"
            CFrameQuest =
                CFrame.new(
                -2021.32007,
                37.7982254,
                -12028.7295,
                0.957576931,
                -8.80302053e-08,
                0.288177818,
                6.9301187e-08,
                1,
                7.51931211e-08,
                -0.288177818,
                -5.2032135e-08,
                0.957576931
            )
            CFrameMon = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875)
        elseif MyLevel == 2250 or MyLevel <= 2274 then
            Mon = "Baking Staff"
            LevelQuest = 1
            NameQuest = "CakeQuest2"
            NameMon = "Baking Staff"
            CFrameQuest =
                CFrame.new(
                -1927.91602,
                37.7981339,
                -12842.5391,
                -0.96804446,
                4.22142143e-08,
                0.250778586,
                4.74911062e-08,
                1,
                1.49904711e-08,
                -0.250778586,
                2.64211941e-08,
                -0.96804446
            )
            CFrameMon = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375)
        elseif MyLevel == 2275 or MyLevel <= 2299 then
            Mon = "Head Baker"
            LevelQuest = 2
            NameQuest = "CakeQuest2"
            NameMon = "Head Baker"
            CFrameQuest =
                CFrame.new(
                -1927.91602,
                37.7981339,
                -12842.5391,
                -0.96804446,
                4.22142143e-08,
                0.250778586,
                4.74911062e-08,
                1,
                1.49904711e-08,
                -0.250778586,
                2.64211941e-08,
                -0.96804446
            )
            CFrameMon = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125)
        elseif MyLevel == 2300 or MyLevel <= 2324 then
            Mon = "Cocoa Warrior"
            LevelQuest = 1
            NameQuest = "ChocQuest1"
            NameMon = "Cocoa Warrior"
            CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
            CFrameMon = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
        elseif MyLevel == 2325 or MyLevel <= 2349 then
            Mon = "Chocolate Bar Battler"
            LevelQuest = 2
            NameQuest = "ChocQuest1"
            NameMon = "Chocolate Bar Battler"
            CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
            CFrameMon = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
        elseif MyLevel == 2350 or MyLevel <= 2374 then
            Mon = "Sweet Thief"
            LevelQuest = 1
            NameQuest = "ChocQuest2"
            NameMon = "Sweet Thief"
            CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
            CFrameMon = CFrame.new(165.1884765625, 76.05885314941406, -12600.8369140625)
        elseif MyLevel == 2375 or MyLevel <= 2399 then
            Mon = "Candy Rebel"
            LevelQuest = 2
            NameQuest = "ChocQuest2"
            NameMon = "Candy Rebel"
            CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
            CFrameMon = CFrame.new(134.86563110351562, 77.2476806640625, -12876.5478515625)
        elseif MyLevel == 2400 or MyLevel <= 2424 then
            Mon = "Candy Pirate"
            LevelQuest = 1
            NameQuest = "CandyQuest1"
            NameMon = "Candy Pirate"
            CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
            CFrameMon = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875)
        elseif MyLevel == 2425 or MyLevel <= 2449 then
            Mon = "Snow Demon"
            LevelQuest = 2
            NameQuest = "CandyQuest1"
            NameMon = "Snow Demon"
            CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
            CFrameMon = CFrame.new(-880.2006225585938, 71.24776458740234, -14538.609375)
        elseif MyLevel == 2450 or MyLevel <= 2474 then
            Mon = "Isle Outlaw"
            LevelQuest = 1
            NameQuest = "TikiQuest1"
            NameMon = "Isle Outlaw"
            CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
            CFrameMon = CFrame.new(-16442.814453125, 116.13899993896484, -264.4637756347656)
        elseif MyLevel == 2475 or MyLevel <= 2524 then
            Mon = "Island Boy"
            LevelQuest = 2
            NameQuest = "TikiQuest1"
            NameMon = "Island Boy"
            CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
            CFrameMon = CFrame.new(-16901.26171875, 84.06756591796875, -192.88906860351562)
        elseif MyLevel == 2525 or MyLevel <= 2550 then
            Mon = "Isle Champion"
            LevelQuest = 2
            NameQuest = "TikiQuest2"
            NameMon = "Isle Champion"
            CFrameQuest = CFrame.new(-16539.078125, 55.68632888793945, 1051.5738525390625)
            CFrameMon = CFrame.new(-16641.6796875, 235.7825469970703, 1031.282958984375)
        elseif MyLevel == 2550 or MyLevel <= 2574 then
            Mon = "Serpent Hunter"
            LevelQuest = 1
            NameQuest = "TikiQuest3"
            NameMon = "Serpent Hunter"
            CFrameQuest =
                CFrame.new(
                -16665.1914,
                104.596405,
                1579.69434,
                0.951068401,
                -0,
                -0.308980465,
                0,
                1,
                -0,
                0.308980465,
                0,
                0.951068401
            )
            CFrameMon =
                CFrame.new(
                -16521.0625,
                106.09285,
                1488.78467,
                0.469467044,
                0,
                0.882950008,
                0,
                1,
                0,
                -0.882950008,
                0,
                0.469467044
            )
        elseif MyLevel >= 2575 then
            Mon = "Skull Slayer"
            LevelQuest = 2
            NameQuest = "TikiQuest3"
            NameMon = "Skull Slayer"
            CFrameQuest =
                CFrame.new(
                -16665.1914,
                104.596405,
                1579.69434,
                0.951068401,
                -0,
                -0.308980465,
                0,
                1,
                -0,
                0.308980465,
                0,
                0.951068401
            )
            CFrameMon =
                CFrame.new(
                -16855.043,
                122.457253,
                1478.15308,
                -0.999392271,
                0,
                -0.0348687991,
                0,
                1,
                0,
                0.0348687991,
                0,
                -0.999392271
            )
        end
    end
end
function CheckBossQuest()
    if World1 then
        if SelectBoss == "The Gorilla King" then
            BossMon = "The Gorilla King"
            NameBoss = "The Gorrila King"
            NameQuestBoss = "JungleQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$2,000\n7,000 Exp."
            CFrameQBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameBoss =
                CFrame.new(
                -1088.75977,
                8.13463783,
                -488.559906,
                -0.707134247,
                0,
                0.707079291,
                0,
                1,
                0,
                -0.707079291,
                0,
                -0.707134247
            )
        elseif SelectBoss == "Bobby" then
            BossMon = "Bobby"
            NameBoss = "Bobby"
            NameQuestBoss = "BuggyQuest1"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$8,000\n35,000 Exp."
            CFrameQBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
            CFrameBoss = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344)
        elseif SelectBoss == "The Saw" then
            BossMon = "The Saw"
            NameBoss = "The Saw"
            CFrameBoss = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906)
        elseif SelectBoss == "Yeti" then
            BossMon = "Yeti"
            NameBoss = "Yeti"
            NameQuestBoss = "SnowQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$10,000\n180,000 Exp."
            CFrameQBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
            CFrameBoss = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
        elseif SelectBoss == "Mob Leader" then
            BossMon = "Mob Leader"
            NameBoss = "Mob Leader"
            CFrameBoss = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813)
        elseif SelectBoss == "Vice Admiral" then
            BossMon = "Vice Admiral"
            NameBoss = "Vice Admiral"
            NameQuestBoss = "MarineQuest2"
            QuestLvBoss = 2
            RewardBoss = "Reward:\n$10,000\n180,000 Exp."
            CFrameQBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625)
            CFrameBoss = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375)
        elseif SelectBoss == "Saber Expert" then
            NameBoss = "Saber Expert"
            BossMon = "Saber Expert"
            CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564)
        elseif SelectBoss == "Warden" then
            BossMon = "Warden"
            NameBoss = "Warden"
            NameQuestBoss = "ImpelQuest"
            QuestLvBoss = 1
            RewardBoss = "Reward:\n$6,000\n850,000 Exp."
            CFrameBoss =
                CFrame.new(
                5278.04932,
                2.15167475,
                944.101929,
                0.220546961,
                -4.49946401e-06,
                0.975376427,
                -1.95412576e-05,
                1,
                9.03162072e-06,
                -0.975376427,
                -2.10519756e-05,
                0.220546961
            )
            CFrameQBoss =
                CFrame.new(
                5191.86133,
                2.84020686,
                686.438721,
                -0.731384635,
                0,
                0.681965172,
                0,
                1,
                0,
                -0.681965172,
                0,
                -0.731384635
            )
        elseif SelectBoss == "Chief Warden" then
            BossMon = "Chief Warden"
            NameBoss = "Chief Warden"
            NameQuestBoss = "ImpelQuest"
            QuestLvBoss = 2
            RewardBoss = "Reward:\n$10,000\n1,000,000 Exp."
            CFrameBoss =
                CFrame.new(
                5206.92578,
                0.997753382,
                814.976746,
                0.342041343,
                -0.00062915677,
                0.939684749,
                0.00191645394,
                0.999998152,
                -2.80422337e-05,
                -0.939682961,
                0.00181045406,
                0.342041939
            )
            CFrameQBoss =
                CFrame.new(
                5191.86133,
                2.84020686,
                686.438721,
                -0.731384635,
                0,
                0.681965172,
                0,
                1,
                0,
                -0.681965172,
                0,
                -0.731384635
            )
        elseif SelectBoss == "Swan" then
            BossMon = "Swan"
            NameBoss = "Swan"
            NameQuestBoss = "ImpelQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$15,000\n1,600,000 Exp."
            CFrameBoss =
                CFrame.new(
                5325.09619,
                7.03906584,
                719.570679,
                -0.309060812,
                0,
                0.951042235,
                0,
                1,
                0,
                -0.951042235,
                0,
                -0.309060812
            )
            CFrameQBoss =
                CFrame.new(
                5191.86133,
                2.84020686,
                686.438721,
                -0.731384635,
                0,
                0.681965172,
                0,
                1,
                0,
                -0.681965172,
                0,
                -0.731384635
            )
        elseif SelectBoss == "Magma Admiral" then
            BossMon = "Magma Admiral"
            NameBoss = "Magma Admiral"
            NameQuestBoss = "MagmaQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$15,000\n2,800,000 Exp."
            CFrameQBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875)
            CFrameBoss = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875)
        elseif SelectBoss == "Fishman Lord" then
            BossMon = "Fishman Lord"
            NameBoss = "Fishman Lord"
            NameQuestBoss = "FishmanQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$15,000\n4,000,000 Exp."
            CFrameQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameBoss = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)
        elseif SelectBoss == "Wysper" then
            BossMon = "Wysper"
            NameBoss = "Wysper"
            NameQuestBoss = "SkyExp1Quest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$15,000\n4,800,000 Exp."
            CFrameQBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094)
            CFrameBoss = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531)
        elseif SelectBoss == "Thunder God" then
            BossMon = "Thunder God"
            NameBoss = "Thunder God"
            NameQuestBoss = "SkyExp2Quest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$20,000\n5,800,000 Exp."
            CFrameQBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
            CFrameBoss = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188)
        elseif SelectBoss == "Cyborg" then
            BossMon = "Cyborg"
            NameBoss = "Cyborg"
            NameQuestBoss = "FountainQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$20,000\n7,500,000 Exp."
            CFrameQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            CFrameBoss = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)
        elseif SelectBoss == "Greybeard" then
            BossMon = "Greybeard"
            NameBoss = "Greybeard"
            CFrameBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
        end
    end
    if World2 then
        if SelectBoss == "Diamond" then
            BossMon = "Diamond"
            NameBoss = "Diamond"
            NameQuestBoss = "Area1Quest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$25,000\n9,000,000 Exp."
            CFrameQBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375)
            CFrameBoss = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407)
        elseif SelectBoss == "Jeremy" then
            BossMon = "Jeremy"
            NameBoss = "Jeremy"
            NameQuestBoss = "Area2Quest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$25,000\n11,500,000 Exp."
            CFrameQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063)
            CFrameBoss = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)
        elseif SelectBoss == "Fajita" then
            BossMon = "Fajita"
            NameBoss = "Fajita"
            NameQuestBoss = "MarineQuest3"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$25,000\n15,000,000 Exp."
            CFrameQBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031)
            CFrameBoss = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625)
        elseif SelectBoss == "Don Swan" then
            BossMon = "Don Swan"
            NameBoss = "Don Swan"
            CFrameBoss = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)
        elseif SelectBoss == "Smoke Admiral" then
            BossMon = "Smoke Admiral"
            NameBoss = "Smoke Admiral"
            NameQuestBoss = "IceSideQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$20,000\n25,000,000 Exp."
            CFrameQBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
            CFrameBoss = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875)
        elseif SelectBoss == "Awakened Ice Admiral" then
            BossMon = "Awakened Ice Admiral"
            NameBoss = "Awakened Ice Admiral"
            NameQuestBoss = "FrostQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$20,000\n36,000,000 Exp."
            CFrameQBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813)
            CFrameBoss = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125)
        elseif SelectBoss == "Tide Keeper" then
            BossMon = "Tide Keeper"
            NameBoss = "Tide Keeper"
            NameQuestBoss = "ForgottenQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$12,500\n38,000,000 Exp."
            CFrameQBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625)
            CFrameBoss = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188)
        elseif SelectBoss == "Darkbeard" then
            BossMon = "Darkbeard"
            NameBoss = "Darkbeard"
            CFrameMon = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
        elseif SelectBoss == "Cursed Captain" then
            BossMon = "Cursed Captain"
            NameBoss = "Cursed Captain"
            CFrameBoss = CFrame.new(916.928589, 181.092773, 33422)
        elseif SelectBoss == "Order" then
            BossMon = "Order"
            NameBoss = "Order"
            CFrameBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
        end
    end
    if World3 then
        if SelectBoss == "Stone" then
            BossMon = "Stone"
            NameBoss = "Stone"
            NameQuestBoss = "PiratePortQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$25,000\n40,000,000 Exp."
            CFrameQBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625)
            CFrameBoss = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438)
        elseif SelectBoss == "Island Empress" then
            BossMon = "Island Empress"
            NameBoss = "Island Empress"
            NameQuestBoss = "AmazonQuest2"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$30,000\n52,000,000 Exp."
            CFrameQBoss = CFrame.new(5445.9541015625, 601.62945556641, 751.43792724609)
            CFrameBoss = CFrame.new(5543.86328125, 668.97399902344, 199.0341796875)
        elseif SelectBoss == "Kilo Admiral" then
            BossMon = "Kilo Admiral"
            NameBoss = "Kilo Admiral"
            NameQuestBoss = "MarineTreeIsland"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$35,000\n56,000,000 Exp."
            CFrameQBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938)
            CFrameBoss = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125)
        elseif SelectBoss == "Captain Elephant" then
            BossMon = "Captain Elephant"
            NameBoss = "Captain Elephant"
            NameQuestBoss = "DeepForestIsland"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$40,000\n67,000,000 Exp."
            CFrameQBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875)
            CFrameBoss = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
        elseif SelectBoss == "Beautiful Pirate" then
            BossMon = "Beautiful Pirate"
            NameBoss = "Beautiful Pirate"
            NameQuestBoss = "DeepForestIsland2"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$50,000\n70,000,000 Exp."
            CFrameQBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
            CFrameBoss = CFrame.new(5283.609375, 22.56223487854, -110.78285217285)
        elseif SelectBoss == "Cake Queen" then
            BossMon = "Cake Queen"
            NameBoss = "Cake Queen"
            NameQuestBoss = "IceCreamIslandQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$30,000\n112,500,000 Exp."
            CFrameQBoss =
                CFrame.new(
                -819.376709,
                64.9259796,
                -10967.2832,
                -0.766061664,
                0,
                0.642767608,
                0,
                1,
                0,
                -0.642767608,
                0,
                -0.766061664
            )
            CFrameBoss =
                CFrame.new(
                -678.648804,
                381.353943,
                -11114.2012,
                -0.908641815,
                0.00149294338,
                0.41757378,
                0.00837114919,
                0.999857843,
                0.0146408929,
                -0.417492568,
                0.0167988986,
                -0.90852499
            )
        elseif SelectBoss == "Longma" then
            BossMon = "Longma"
            NameBoss = "Longma"
            CFrameBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
        elseif SelectBoss == "Soul Reaper" then
            BossMon = "Soul Reaper"
            NameBoss = "Soul Reaper"
            CFrameBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
        elseif SelectBoss == "rip_indra True Form" then
            BossMon = "rip_indra True Form"
            NameBoss = "rip_indra True Form"
            CFrameBoss = CFrame.new(-5415.3920898438, 505.74133300781, -2814.0166015625)
        end
    end
end
task.spawn(
    function()
        while wait() do
            pcall(
                function()
                    if getgenv().Weapon == "Melee" then
                        for e, c in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if c.ToolTip == "Melee" then
                                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(c.Name)) then
                                    getgenv().Weapon = c.Name
                                end
                            end
                        end
                    elseif getgenv().Weapon == "Sword" then
                        for e, c in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if c.ToolTip == "Sword" then
                                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(c.Name)) then
                                    getgenv().Weapon = c.Name
                                end
                            end
                        end
                    elseif getgenv().Weapon == "Gun" then
                        for e, c in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if c.ToolTip == "Gun" then
                                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(c.Name)) then
                                    getgenv().Weapon = c.Name
                                end
                            end
                        end
                    elseif getgenv().Weapon == "Fruit" then
                        for e, c in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if c.ToolTip == "Blox Fruit" then
                                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(c.Name)) then
                                    getgenv().Weapon = c.Name
                                end
                            end
                        end
                    end
                end
            )
        end
    end
)
game:GetService("Players").LocalPlayer.Idled:connect(
    function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end
)
function AutoHaki()
    local f = game:GetService("Players").LocalPlayer
    local g = f.Character
    if g and not g:FindFirstChild("HasBuso") then
        local h = game:GetService("ReplicatedStorage").Remotes.CommF_
        if h then
            h:InvokeServer("Buso")
        end
    end
end
function UnEquipWeapon(Weapon)
    if game.Players.LocalPlayer.Character:FindFirstChild(Weapon) then
        _G.NotAutoEquip = true
        wait(.5)
        game.Players.LocalPlayer.Character:FindFirstChild(Weapon).Parent = game.Players.LocalPlayer.Backpack
        wait(.1)
        _G.NotAutoEquip = false
    end
end
function EquipWeapon(i)
    if game.Players.LocalPlayer.Backpack:FindFirstChild(i) then
        local j = game.Players.LocalPlayer.Backpack:FindFirstChild(i)
        wait(.4)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(j)
    end
end
function EquipWeapon(i)
    if not _G.NotAutoEquip then
        if game.Players.LocalPlayer.Backpack:FindFirstChild(i) then
            Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(i)
            wait(.1)
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
        end
    end
end
local k
function noclip()
    local char = game:GetService("Players").LocalPlayer.Character
    if not char then
        return
    end
    if not char.HumanoidRootPart:FindFirstChild("BodyClip") then
        local l = Instance.new("BodyVelocity")
        l.Name = "BodyClip"
        l.Parent = char.HumanoidRootPart
        l.MaxForce = Vector3.new(100000, 100000, 100000)
        l.Velocity = Vector3.new(0, 0, 0)
    end
    if not k then
        k =
            game:GetService("RunService").Stepped:Connect(
            function()
                for b, c in pairs(char:GetDescendants()) do
                    if c:IsA("BasePart") then
                        c.CanCollide = false
                    end
                end
            end
        )
    end
end
function unnoclip()
    local char = game:GetService("Players").LocalPlayer.Character
    if not char then
        return
    end
    if char.HumanoidRootPart:FindFirstChild("BodyClip") then
        char.HumanoidRootPart.BodyClip:Destroy()
    end
    if k then
        k:Disconnect()
        k = nil
    end
    for b, c in pairs(char:GetDescendants()) do
        if c:IsA("BasePart") then
            c.CanCollide = true
        end
    end
end
function GetDistance(m)
    return math.floor((m.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
end
function BTP(n)
    pcall(
        function()
            if
                (n.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1500 and
                    not Auto_Raid and
                    game.Players.LocalPlayer.Character.Humanoid.Health > 0
             then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = n
                    wait(0.5)
                    game.Players.LocalPlayer.Character.Head:Destroy()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = n
                until (n.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1500 and
                    game.Players.LocalPlayer.Character.Humanoid.Health > 0
            end
        end
    )
end
function TP(a)
    Distance = (a.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 300 then
        Speed = 300
    elseif Distance >= 1000 then
        Speed = 300
    end
    game:GetService("TweenService"):Create(
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear),
        {CFrame = a}
    ):Play()
    _G.Clip = true
    wait(Distance / Speed)
    _G.Clip = false
end
function Idk(a)
    Distance = (a.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
        game.Players.LocalPlayer.Character.Humanoid.Sit = false
    end
    pcall(
        function()
            tween =
                game:GetService("TweenService"):Create(
                game.Players.LocalPlayer.Character.HumanoidRootPart,
                TweenInfo.new(Distance / 315, Enum.EasingStyle.Linear),
                {CFrame = a}
            )
        end
    )
    tween:Play()
    if Distance <= 200 then
        tween:Cancel()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = a
    end
    if _G.StopTween == true then
        tween:Cancel()
        _G.Clip = false
    end
end
function CheckNearestTeleporter(o)
    local MyLevel = game.Players.LocalPlayer.Data.Level.Value
    vcspos = o.Position
    min = math.huge
    min2 = math.huge
    local p = game.PlaceId
    if p == 2753915549 then
        OldWorld = true
    elseif p == 4442272183 then
        NewWorld = true
    elseif p == 7449423635 then
        ThreeWorld = true
    end
    if World3 then
        TableLocations = {
            ["Caslte On The Sea"] = Vector3.new(-5058.77490234375, 314.5155029296875, -3155.88330078125),
            ["Hydra"] = Vector3.new(5661.5302734375, 1013.3587036132812, -334.9619140625),
            ["Mansion"] = Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125),
            ["Great Tree"] = Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586),
            ["Ngu1"] = Vector3.new(-11989.2880859375, 332.1744384765625, -8886.025390625),
            ["ngu2"] = Vector3.new(5314.58203125, 25.419387817382812, -125.94227600097656),
            ["ngu3"] = Vector3.new(28282.5703125, 14896.8232421875, 105.1042709350586)
        }
    elseif World2 then
        TableLocations = {
            ["Mansion"] = Vector3.new(-288.46246337890625, 306.130615234375, 597.9988403320312),
            ["Flamingo"] = Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625),
            ["122"] = Vector3.new(923.21252441406, 126.9760055542, 32852.83203125),
            ["3032"] = Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422)
        }
    elseif World1 then
        TableLocations = {
            ["1"] = Vector3.new(-7894.6201171875, 5545.49169921875, -380.2467346191406),
            ["2"] = Vector3.new(-4607.82275390625, 872.5422973632812, -1667.556884765625),
            ["3"] = Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875),
            ["4"] = Vector3.new(3876.280517578125, 35.10614013671875, -1939.3201904296875)
        }
    end
    TableLocations2 = {}
    for q, c in pairs(TableLocations) do
        TableLocations2[q] = (c - vcspos).Magnitude
    end
    for q, c in pairs(TableLocations2) do
        if c < min then
            min = c
            min2 = c
        end
    end
    for q, c in pairs(TableLocations2) do
        if c < min then
            min = c
            min2 = c
        end
    end
    for q, c in pairs(TableLocations2) do
        if c <= min then
            choose = TableLocations[q]
        end
    end
    min3 = (vcspos - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if min2 <= min3 then
        return choose
    end
end
function requestEntrance(r)
    args = {"requestEntrance", r}
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
    oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    char = game.Players.LocalPlayer.Character.HumanoidRootPart
    char.CFrame = CFrame.new(oldcframe.X, oldcframe.Y + 50, oldcframe.Z)
    task.wait(0.5)
end
function AntiLowHealth(s)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
        CFrame.new(
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,
        s,
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z
    )
    wait()
end
TweenSpeed = 300
function TPP(a)
    Distance = (a.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
        game.Players.LocalPlayer.Character.Humanoid.Sit = false
    end
    pcall(
        function()
            tween =
                game:GetService("TweenService"):Create(
                game.Players.LocalPlayer.Character.HumanoidRootPart,
                TweenInfo.new(Distance / 340, Enum.EasingStyle.Linear),
                {CFrame = a}
            )
        end
    )
    tween:Play()
    noclip()
    if Distance <= 100 then
        tween:Cancel()
        unnoclip()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = a
    end
    if _G.StopTween == true then
        tween:Cancel()
        unnoclip()
        _G.Clip = false
    end
end
function topos(t)
    pcall(
        function()
            if
                game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character and
                    game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") and
                    game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                    game:GetService("Players").LocalPlayer.Character.Humanoid.Health > 0 and
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
             then
                if not TweenSpeed then
                    TweenSpeed = 300
                end
                noclip()
                DefualtY = t.Y
                TargetY = t.Y
                targetCFrameWithDefualtY = CFrame.new(t.X, DefualtY, t.Z)
                targetPos = t.Position
                oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                Distance =
                    (targetPos -
                    game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
                local u = CheckNearestTeleporter(t)
                if u then
                    pcall(
                        function()
                            tween:Cancel()
                        end
                    )
                    requestEntrance(u)
                end
                b1 =
                    CFrame.new(
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,
                    DefualtY,
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z
                )
                if IngoreY and (b1.Position - targetCFrameWithDefualtY.Position).Magnitude > 5 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                        CFrame.new(
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,
                        DefualtY,
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z
                    )
                    local tweenfunc = {}
                    local v = game:service "TweenService"
                    local w =
                        TweenInfo.new(
                        (targetPos -
                            game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude /
                            TweenSpeed,
                        Enum.EasingStyle.Linear
                    )
                    tween =
                        v:Create(
                        game:GetService("Players").LocalPlayer.Character["HumanoidRootPart"],
                        w,
                        {CFrame = targetCFrameWithDefualtY}
                    )
                    tween:Play()
                    function tweenfunc:Stop()
                        tween:Cancel()
                    end
                    tween.Completed:Wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                        CFrame.new(
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,
                        TargetY,
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z
                    )
                else
                    local tweenfunc = {}
                    local v = game:service "TweenService"
                    local w =
                        TweenInfo.new(
                        (targetPos -
                            game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude /
                            TweenSpeed,
                        Enum.EasingStyle.Linear
                    )
                    tween =
                        v:Create(game:GetService("Players").LocalPlayer.Character["HumanoidRootPart"], w, {CFrame = t})
                    tween:Play()
                    function tweenfunc:Stop()
                        tween:Cancel()
                    end
                    tween.Completed:Wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                        CFrame.new(
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,
                        TargetY,
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z
                    )
                end
                if not tween then
                    return tween
                end
                return tweenfunc
            end
            unnoclip()
        end
    )
end
IngoreY = true
Type = 1
spawn(
    function()
        while wait(.1) do
            if Type == 1 then
                a = CFrame.new(0, PosY, -30)
            elseif Type == 2 then
                a = CFrame.new(30, PosY, 0)
            elseif Type == 3 then
                a = CFrame.new(0, PosY, 30)
            elseif Type == 4 then
                a = CFrame.new(-30, PosY, 0)
            end
        end
    end
)
spawn(
    function()
        while wait(0.5) do
            Type = 1
            wait(0.4)
            Type = 2
            wait(0.3)
            Type = 3
            wait(0.4)
            Type = 4
            wait(0.2)
            Type = 5
            wait(0.3)
        end
    end
)
spawn(
    function()
        while wait(.1) do
            Frame = 1
            wait(0.4)
            Frame = 2
            wait(0.4)
            Frame = 3
            wait(0.3)
            Frame = 4
            wait(0.4)
            Frame = 5
            wait(0.3)
        end
    end
)
Type = 1
spawn(
    function()
        while wait(.1) do
            if Frame == 1 then
                Check = CFrame.new(0, 50, 0)
            elseif F == 2 then
                Check = CFrame.new(0, 0, -100)
            elseif F == 3 then
                Check = CFrame.new(100, 0, 0)
            elseif F == 4 then
                Check = CFrame.new(0, 0, 100)
            elseif F == 5 then
                Check = CFrame.new(-100, 0, 0)
            elseif F == 6 then
                Check = CFrame.new(0, 50, 0)
            end
        end
    end
)
spawn(
    function()
        while wait(.1) do
            F = 1
            wait(0.5)
            F = 2
            wait(0.5)
            F = 3
            wait(0.5)
            F = 4
            wait(0.5)
            F = 5
            wait(0.5)
        end
    end
)
getgenv().toposs = function(n)
    task.spawn(
        function()
            pcall(
                function()
                    if game:GetService("Players").LocalPlayer:DistanceFromCharacter(n.Position) <= 250 then
                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = n
                    elseif not game.Players.LocalPlayer.Character:FindFirstChild("Root") then
                        local x = Instance.new("Part", game.Players.LocalPlayer.Character)
                        x.Size = Vector3.new(1, 0.5, 1)
                        x.Name = "Root"
                        x.Anchored = true
                        x.Transparency = 1
                        x.CanCollide = false
                        x.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
                    end
                    local y = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - n.Position).Magnitude
                    local z = game:service("TweenService")
                    local A =
                        TweenInfo.new(
                        (n.Position - game.Players.LocalPlayer.Character.Root.Position).Magnitude / 300,
                        Enum.EasingStyle.Linear
                    )
                    local B, C =
                        pcall(
                        function()
                            local D = z:Create(game.Players.LocalPlayer.Character.Root, A, {CFrame = n})
                            D:Play()
                        end
                    )
                    if not B then
                        return C
                    end
                    game.Players.LocalPlayer.Character.Root.CFrame =
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    if B and game.Players.LocalPlayer.Character:FindFirstChild("Root") then
                        pcall(
                            function()
                                if
                                    (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - n.Position).Magnitude >=
                                        20
                                 then
                                    spawn(
                                        function()
                                            pcall(
                                                function()
                                                    if
                                                        (game.Players.LocalPlayer.Character.Root.Position -
                                                            game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >
                                                            150
                                                     then
                                                        game.Players.LocalPlayer.Character.Root.CFrame =
                                                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                                    else
                                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                            game.Players.LocalPlayer.Character.Root.CFrame
                                                    end
                                                end
                                            )
                                        end
                                    )
                                elseif
                                    (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - n.Position).Magnitude >=
                                        10 and
                                        (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - n.Position).Magnitude <
                                            20
                                 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = n
                                elseif
                                    (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - n.Position).Magnitude <
                                        10
                                 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = n
                                end
                            end
                        )
                    end
                end
            )
        end
    )
end
function InstancePos(E)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = E
end
game:GetService("Players").LocalPlayer.Idled:connect(
    function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end
)
local G = game:GetService("Players")
local H = #game:GetService("Players"):GetPlayers()
local I = game.PlaceId
local J = game.JobId
PosY = 45
AutoHaki()
function StopTween(m)
    if not m then
        _G.StopTween = true
        wait()
        topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
        if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
        end
        _G.StopTween = false
        _G.Clip = false
    end
end
function GetDistance(D)
    if type(D) == "instance" then
        if Instance:IsA("BasePart") or Instance:IsA("Part") then
            return (D.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        elseif Instance:FindFirstChild("HumanoidRootPart") then
            return (D.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        else
            for q, c in pairs(D:GetDescendants()) do
                if c:IsA("BasePart") or c:IsA("Part") then
                    return (c.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                end
            end
        end
    else
        return (D - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    end
end
local function K()
    local L = math.huge
    local M = nil
    for b, c in pairs(workspace.Map:GetDescendants()) do
        if string.find(c.Name:lower(), "chest") then
            if c:FindFirstChild("TouchInterest") then
                local N = (c.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if N < L then
                    L = N
                    M = c
                end
            end
        end
    end
    return M
end
local function O(P)
    for b, c in pairs(workspace.Enemies:GetChildren()) do
        if c.Name == P then
            if
                c:FindFirstChild("Humanoid") and c:FindFirstChild("HumanoidRootPart") and c.Humanoid.Health > 0 and
                    c.Parent
             then
                return c
            end
        end
    end
    return nil
end
local function Q()
    return game.Players.LocalPlayer.Backpack:FindFirstChild("Microchip") or
        game.Players.LocalPlayer.Character:FindFirstChild("Microchip")
end
local function R()
    return game.Players.LocalPlayer.Backpack:FindFirstChild("Core Brain") or
        game.Players.LocalPlayer.Character:FindFirstChild("Core Brain")
end
local function S()
    local T = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")
    return T == 1 or T == 2
end
local function U(V, W, X)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = V, Text = W, Duration = X or 5})
end
local function Y()
    local Z = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer", "Check")
    if Z == 2 then
        U("Auto Cyborg", "Đã có tộc cyborg!", 10)
        return
    end
    if not Z then
        local _ = game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main
        if not _.CanCollide then
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer", "Buy")
        else
            if R() then
                fireclickdetector(_.ClickDetector)
            else
                if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CheckBlockPart") then
                    if game.ReplicatedStorage:FindFirstChild("Order") or workspace.Enemies:FindFirstChild("Order") then
                        local a0 = O("Order")
                        if a0 then
                            repeat
                                wait()
                                AutoHaki()
                                EquipWeapon(getgenv().Weapon)
                                a0.HumanoidRootPart.CanCollide = false
                                a0.Humanoid.WalkSpeed = 0
                                local targetPos = a0.HumanoidRootPart.CFrame * a
                                topos(targetPos)
                                sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                            until a0.Humanoid.Health <= 0 or not a0.Parent
                        else
                            topos(
                                CFrame.new(
                                    -6064.06885,
                                    15.2422857,
                                    -4902.97852,
                                    0.453972578,
                                    -0,
                                    -0.891015649,
                                    0,
                                    1,
                                    -0,
                                    0.891015649,
                                    0,
                                    0.453972578
                                )
                            )
                        end
                    else
                        if not Q() then
                            if game.Players.LocalPlayer.Data.Fragments.Value >= 1000 then
                                S()
                            else
                                U("Auto Cyborg", "Hết con mẹ fragments rồi còn mua gì nữa!", 10)
                                wait(11)
                            end
                        elseif Q() then
                            fireclickdetector(_.ClickDetector)
                        end
                    end
                else
                    if not game.Players.LocalPlayer.Backpack:FindFirstChild("First Of Darkness") then
                        local a1 = K()
                        if a1 then
                            repeat
                                wait()
                                topos(a1.CFrame)
                                if
                                    (a1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <=
                                        10
                                 then
                                    game:service("VirtualInputManager"):SendKeyEvent(true, "Q", false, game)
                                    task.wait()
                                    game:service("VirtualInputManager"):SendKeyEvent(false, "Q", false, game)
                                    wait(0.3)
                                end
                            until not a1:FindFirstChild("TouchInterest") or not a1.Parent or
                                game.Players.LocalPlayer.Backpack:FindFirstChild("First Of Darkness")
                        else
                            Hop()
                        end
                    else
                        fireclickdetector(_.ClickDetector)
                    end
                end
            end
        end
    end
end
function EvoRaceV2()
    local f = game.Players.LocalPlayer
    if f.Data.Race.Value ~= "Cyborg" then
        return
    end
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
        topos(
            CFrame.new(
                -2779.83521,
                72.9661407,
                -3574.02002,
                -0.730484903,
                6.39014104e-08,
                -0.68292886,
                3.59963224e-08,
                1,
                5.50667032e-08,
                0.68292886,
                1.56424669e-08,
                -0.730484903
            )
        )
        if
            (game.Players.LocalPlayer.Character.HumanoidRootPart.Position -
                Vector3.new(
                    -2779.83521,
                    72.9661407,
                    -3574.02002,
                    -0.730484903,
                    6.39014104e-08,
                    -0.68292886,
                    3.59963224e-08,
                    1,
                    5.50667032e-08,
                    0.68292886,
                    1.56424669e-08,
                    -0.730484903
                )).Magnitude <= 10
         then
            wait(0.5)
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "2")
        end
    elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
        if
            not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 1") and
                not game.Players.LocalPlayer.Character:FindFirstChild("Flower 1")
         then
            topos(game.Workspace.Flower1.CFrame)
        elseif
            not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 2") and
                not game.Players.LocalPlayer.Character:FindFirstChild("Flower 2")
         then
            topos(game.Workspace.Flower2.CFrame)
        elseif
            not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") and
                not game.Players.LocalPlayer.Character:FindFirstChild("Flower 3")
         then
            if
                game.Workspace.Enemies:FindFirstChild("Ship Deckhand") or
                    game.Workspace.Enemies:FindFirstChild("Ship Engineer") or
                    game.Workspace.Enemies:FindFirstChild("Ship Steward") or
                    game.Workspace.Enemies:FindFirstChild("Ship Officer")
             then
                for b, c in pairs(game.Workspace.Enemies:GetChildren()) do
                    if
                        (c.Name == "Ship Deckhand" or c.Name == "Ship Engineer" or c.Name == "Ship Steward" or
                            c.Name == "Ship Officer") and
                            c:FindFirstChild("Humanoid") and
                            c:FindFirstChild("HumanoidRootPart") and
                            c.Humanoid.Health > 0
                     then
                        repeat
                            task.wait()
                            AutoHaki()
                            EquipWeapon(Weapon)
                            topos(c.HumanoidRootPart.CFrame * CFrame.new(0, 25, 0))
                        until not c.Parent or c.Humanoid.Health <= 0 or
                            game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") or
                            game.Players.LocalPlayer.Character:FindFirstChild("Flower 3")
                    end
                end
            else
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer(
                    "requestEntrance",
                    Vector3.new(923.213, 126.976, 32852.832)
                )
            end
        end
    elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "3")
    end
end
function CyborgEvoRaceV3()
    local f = game.Players.LocalPlayer
    if f.Data.Race.Value ~= "Cyborg" then
        return
    end
    if not evo then
        local a2 = game:GetService("ReplicatedStorage").Remotes.CommF_
        a2:InvokeServer("Wenlocktoad", "1")
        task.wait(1)
        a2:InvokeServer("Wenlocktoad", "2")
        evo = true
    end
    local a3 = false
    if evo and not a3 and not game:GetService("Players").LocalPlayer.PlayerGui.Main.Timer.Visible then
        pcall(
            function()
                if not f.Character or not f.Character:FindFirstChild("HumanoidRootPart") then
                    return
                end
                local a4 = f.Data.Race.Value
                local a2 = game:GetService("ReplicatedStorage").Remotes.CommF_
                if a4 == "Cyborg" then
                    local a5 = false
                    repeat
                        local a6 = {
                            "Rocket-Rocket",
                            "Spin-Spin",
                            "Blade-Blade",
                            "Spring-Spring",
                            "Bomb-Bomb",
                            "Smoke-Smoke",
                            "Spike-Spike",
                            "Flame-Flame",
                            "Falcon-Falcon",
                            "Ice-Ice",
                            "Sand-Sand",
                            "Dark-Dark",
                            "Ghost-Ghost",
                            "Diamond-Diamond",
                            "Light-Light",
                            "Rubber-Rubber",
                            "Barrier-Barrier"
                        }
                        for b, a7 in pairs(a6) do
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", a7)
                            for b, c in pairs(f.Backpack:GetChildren()) do
                                if string.find(c.Name, "Fruit") then
                                    a5 = true
                                    break
                                end
                            end
                            task.wait(1)
                        end
                    until a5
                    a3 = true
                end
                if a3 then
                    local T = a2:InvokeServer("Wenlocktoad", "3")
                    if T == -2 then
                        return
                    end
                end
            end
        )
    end
end
function AutoCyborgEvolution()
    local f = game.Players.LocalPlayer
    local Z = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer", "Check")
    if Z ~= 2 then
        Y()
        wait(5)
    end
    if f.Data.Race.Value == "Cyborg" then
        EvoRaceV2()
        task.wait(2)
        CyborgEvoRaceV3()
    end
end
evo = false
spawn(
    function()
        while wait() do
            pcall(
                function()
                    AutoCyborgEvolution()
                end
            )
        end
    end
)
