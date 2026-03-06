local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- // !!! MESIN PELANGI JALAN (UIGRADIENT MOVING ENGINE) - VIP !!!
local function applyVIPFlow(obj)
    if not obj:FindFirstChild("VIPFlow") then
        local gradient = Instance.new("UIGradient")
        gradient.Name = "VIPFlow"
        -- Set gradasi pelangi penuh
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), -- Merah
            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)), -- Kuning
            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)), -- Hijau
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)), -- Cyan
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)), -- Biru
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) -- Merah (Loop)
        })
        gradient.Parent = obj
    end
end

-- Loop untuk ngejalanin efek gradasinya (NGEBUT)
task.spawn(function()
    local offset = 0
    while task.wait(0.01) do -- Speed jalan pelangi (makin kecil makin ngebut)
        offset = offset + 0.05 -- Kecepatan flow gradasi
        if offset >= 1 then offset = 0 end
        
        -- Paksa gradasi ke Text, Button, Stroke (garis), dan Frame
        for _, v in pairs(game.CoreGui:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("UIStroke") or v:IsA("Frame") then
                applyVIPFlow(v)
                local gradient = v:FindFirstChild("VIPFlow")
                if gradient then
                    gradient.Offset = Vector2.new(-offset, 0)
                end
            end
        end
    end
end)

-- // SETTINGAN OWNER & KEY
local MyUsername = "tolongggggs" -- Username lo udah masuk sini
local CorrectKey = "XREX"

local UseKey = true
if game.Players.LocalPlayer.Name == MyUsername then
    UseKey = false
end

local Window = Rayfield:CreateWindow({
   Name = "XREXZOB VIP",
   LoadingTitle = "VIP ACCESS: " .. MyUsername,
   LoadingSubtitle = "RAINBOW FLOW ENABLED",
   ConfigurationSaving = { Enabled = false },
   KeySystem = UseKey,
   KeySettings = {
      Title = "XREXZOB VIP | PRIVATE",
      Subtitle = "Key: XREX",
      Note = "Owner bypass aktif!",
      FileName = "XREXKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {CorrectKey}
   }
})

---
-- SEMUA FITUR DI BAWAH INI TETEP ADA (NGGAK DIHAPUS)
---

-- // TAB MOVEMENT
local TabMove = Window:CreateTab("Movement", 4483362458)
_G.WSValue = 16

TabMove:CreateSlider({
   Name = "Set Speed",
   Range = {0, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v)
      _G.WSValue = v
      if _G.SpeedToggle then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end
   end,
})

TabMove:CreateToggle({
   Name = "Aktifkan Speed",
   CurrentValue = false,
   Callback = function(v)
      _G.SpeedToggle = v
      task.spawn(function()
         while _G.SpeedToggle do
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
               game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.WSValue
            end
            task.wait(0.1)
         end
         if game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 end
      end)
   end,
})

-- // TAB PLAYER TOOLS (TP & NEMPEL)
local TabPlayer = Window:CreateTab("Player Tools", 4483362458)
local TargetName = ""

TabPlayer:CreateInput({
   Name = "Target Name",
   PlaceholderText = "Ketik USN Target...",
   Callback = function(Text) TargetName = Text end,
})

TabPlayer:CreateButton({
   Name = "Teleport",
   Callback = function()
      for _, p in pairs(game.Players:GetPlayers()) do
         if string.find(string.lower(p.Name), string.lower(TargetName)) then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
         end
      end
   end,
})

TabPlayer:CreateButton({
   Name = "Nempel (Carry Position)",
   Callback = function()
      _G.Nempel = true
      for _, p in pairs(game.Players:GetPlayers()) do
         if string.find(string.lower(p.Name), string.lower(TargetName)) then
            task.spawn(function()
               while _G.Nempel do
                  if p.Character and game.Players.LocalPlayer.Character then
                     game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0.5)
                  end
                  task.wait()
               end
            end)
         end
      end
   end,
})

TabPlayer:CreateButton({
   Name = "Lepas Nempel",
   Callback = function() _G.Nempel = false end,
})

-- // TAB EMOTES
local TabEmote = Window:CreateTab("Emotes", 4483362458)
_G.EMSpeed = 1
_G.Track = nil

TabEmote:CreateSlider({
   Name = "Speed Joget",
   Range = {0, 20},
   Increment = 0.5,
   CurrentValue = 1,
   Callback = function(v) _G.EMSpeed = v end,
})

local function PlayEm(id)
    local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if _G.Track then _G.Track:Stop() _G.Track:Destroy() end
    local a = Instance.new("Animation")
    a.AnimationId = "rbxassetid://"..id
    _G.Track = hum:LoadAnimation(a)
    _G.Track.Looped = true
    _G.Track:Play()
    task.spawn(function()
        while _G.Track do
            _G.Track:AdjustSpeed(_G.EMSpeed)
            task.wait(0.1)
        end
    end)
end

TabEmote:CreateButton({ Name = "Hype Dance", Callback = function() PlayEm("3695333486") end })
TabEmote:CreateButton({ Name = "Old School", Callback = function() PlayEm("3333499508") end })
TabEmote:CreateButton({ Name = "Stop Emote", Callback = function() if _G.Track then _G.Track:Stop() _G.Track:Destroy() _G.Track = nil end end })
