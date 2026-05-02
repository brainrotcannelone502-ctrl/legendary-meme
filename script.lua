--[[ 
    LK7 HUB - FIXED FLASH GRAB 
    Link oficial do repositório: 
    https://raw.githubusercontent.com/brainrotcannelone502-ctrl/legendary-meme/refs/heads/main/script.lua
]]

-- Coordenadas Calibradas para DENTRO do mapa
local LOJA_EQUIPAMENTOS = Vector3.new(35, 4, 45) -- Ponto positivo para evitar o vazio
local SLOT_BASE = Vector3.new(-15, 4, 20)

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Interface Star Hub
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "StarHub_Fixed"

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 220, 0, 140)
Main.Position = UDim2.new(0.8, 0, 0.1, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 35)

local btnFlash = Instance.new("TextButton", Main)
btnFlash.Size = UDim2.new(0, 200, 0, 40)
btnFlash.Position = UDim2.new(0, 10, 0, 80)
btnFlash.Text = "FLASH - GRAB"
btnFlash.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
btnFlash.TextColor3 = Color3.new(1, 1, 1)

-- Lógica de Teletransporte Corrigida
btnFlash.MouseButton1Click:Connect(function()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        -- Teleporte para a Loja de Equipamentos (Coordenada segura)
        hrp.CFrame = CFrame.new(LOJA_EQUIPAMENTOS)
        task.wait(0.2)
        -- Retorno rápido para a Base (Otimização do Flash TP)
        hrp.CFrame = CFrame.new(SLOT_BASE)
    end
end)

-- Execução do Script Externo via Loadstring
loadstring(game:HttpGet("https://raw.githubusercontent.com/brainrotcannelone502-ctrl/legendary-meme/refs/heads/main/script.lua"))()
