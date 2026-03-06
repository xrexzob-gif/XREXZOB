local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- // !!! MESIN PELANGI JALAN (RAINBOW FLOW ENGINE) - VIP !!!
local function applyVIPFlow(obj)
    if not obj:FindFirstChild("VIPFlow") then
        local gradient = Instance.new("UIGradient")
        gradient.Name = "VIPFlow"
        -- Gradasi Pelangi Full (Pink-Purple-Blue-Green-Yellow-Red)
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)), -- Pink
            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(150, 0, 255)), -- Purple
            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 0, 255)), -- Blue
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)), -- Green
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(255, 255, 0)), -- Yellow
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)) -- Loop Pink
        })
        gradient.Parent = obj
    end
end

-- Task buat ngejalanin animasinya biar ngeroll (NGEBUT)
task.spawn(function()
    local offset = 0
    while task.wait(0.01) do 
        offset = offset + 0.05 -- Kecepatan jalan pelangi
        if offset >= 1 then offset = 0 end
        
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
local MyUsername = "tolongggggs"
local CorrectKey = "XREXZOB_VIP_2024"

local UseKey = true
if game.Players.LocalPlayer.Name == MyUsername then
    UseKey = false
end

local Window = Rayfield:CreateWindow({
   Name = "XREXZOB VIP",
   LoadingTitle = "VIP PRIVATE ACCESS",
   LoadingSubtitle = "RAINBOW FLOW ACTIVE",
   ConfigurationSaving = { Enabled = false },
   KeySystem = UseKey,
   KeySettings = {
      Title = "XREXZOB VIP | KEY SYSTEM",
      Subtitle = "Khusus Member VIP",
      Note = "Owner bypass active for " .. MyUsername,
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
      if _G.SpeedEnabled then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end
   end,
})

TabMove:CreateToggle({
   Name = "Speed Hack",
   CurrentValue = false,
   Callback = function(v)
      _G.SpeedEnabled = v
      task.spawn(function()
         while _G.SpeedEnabled do
            if game.Players.LocalPlayer.Character then
               game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.WSValue
            end
            task.wait(0.1)
         end
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
      end)
   end,
})

TabMove:CreateToggle({
   Name = "Fly (Terbang)",
   CurrentValue = false,
   Callback = function(v)
      _G.Flying = v
      local root = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
      if v then
         local bv = Instance.new("BodyVelocity", root)
         bv.Name = "XREXFly"
         bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
         task.spawn(function()
            while _G.Flying do
               bv.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 100
               task.wait()
            end
            bv:Destroy()
         end)
      else
         if root:FindFirstChild("XREXFly") then root.XREXFly:Destroy() end
      end
   end,
})

-- // TAB PLAYER TOOLS (TP & NEMPEL)
local TabPlayer = Window:CreateTab("Player Tools", 4483362458)
local TargetName = ""

TabPlayer:CreateInput({
   Name = "Input Nama Target",
   PlaceholderText = "Username...",
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
   Name = "Lepas Nempel",
   Callback = function() _G.Nempel = false end,
})

-- // TAB EMOTES
local TabEmote = Window:CreateTab("Emotes", 4483362458)
_G.EMSpeed = 1

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
TabEmote:CreateButton({ Name = "STOP", Callback = function() if _G.Track then _G.Track:Stop() _G.Track:Destroy() _G.Track = nil end end })

-- // TAB EXTRA
local TabExtra = Window:CreateTab("Extra", 4483362458)
TabExtra:CreateToggle({
   Name = "ESP (Highlight)",
   CurrentValue = false,
   Callback = function(v)
      _G.ESP = v
      while _G.ESP do
         for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character then
               local h = p.Character:FindFirstChild("Highlight") or Instance.new("Highlight", p.Character)
               h.Enabled = true
            end
         end
         task.wait(1)
      end
   end,
})

TabExtra:CreateButton({
   Name = "Anti-Lag",
   Callback = function()
      for _, v in pairs(game.Workspace:GetDescendants()) do
         if v:IsA("Texture") or v:IsA("Decal") then v:Destroy() end
      end
   end,
})
