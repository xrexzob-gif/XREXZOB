local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- // !!! MESIN PELANGI NGEBUT KHUSUS TEKS (VIP RGB) !!!
task.spawn(function()
    local counter = 0
    while task.wait(0.01) do -- Speed pelangi ngebut
        counter = counter + 0.02
        local color = Color3.fromHSV(counter % 1, 1, 1)
        
        for _, v in pairs(game.CoreGui:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
                v.TextColor3 = color
            elseif v:IsA("UIStroke") then
                v.Color = color
            end
        end
    end
end)

-- // SETTINGAN OWNER & KEY
local MyUsername = "tolongggggs" -- AKUN RAJA
local CorrectKey = "XREX"

local UseKey = true
if game.Players.LocalPlayer.Name == MyUsername then
    UseKey = false
end

local Window = Rayfield:CreateWindow({
   Name = "XREXZOB VIP",
   LoadingTitle = "VIP ACCESS: " .. MyUsername,
   LoadingSubtitle = "RGB NEON MODE ENABLED",
   ConfigurationSaving = { Enabled = false },
   KeySystem = UseKey,
   KeySettings = {
      Title = "XREXZOB VIP | PRIVATE",
      Subtitle = "Key: XREX",
      Note = "Owner bypass aktif buat " .. MyUsername,
      FileName = "XREXKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {CorrectKey}
   }
})

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
   Name = "Nempel (Carry)",
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
   Name = "Lepas",
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
TabEmote:CreateButton({ Name = "Stop", Callback = function() if _G.Track then _G.Track:Stop() _G.Track:Destroy() _G.Track = nil end end })
