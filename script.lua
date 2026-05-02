local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local pgui = player:WaitForChild("PlayerGui")

-- Limpeza de interfaces antigas
if pgui:FindFirstChild("StarHub_Flash") then pgui.StarHub_Flash:Destroy() end

local sg = Instance.new("ScreenGui", pgui)
sg.Name = "StarHub_Flash"
sg.ResetOnSpawn = false

-- MENU PRINCIPAL (ESTILO STAR HUB)
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 220, 0, 140)
Main.Position = UDim2.new(0.8, 0, 0.1, 0) -- Canto superior direito
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(200, 200, 200)

local layout = Instance.new("UIListLayout", Main)
layout.Padding = UDim.new(0, 5)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- FUNÇÃO PARA CRIAR BOTÕES DO STAR HUB
local function CreateStarBtn(text, isMain)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 200, 0, 35)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    
    if isMain then
        btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Vermelho do "Flash - Grab"
        btn.TextColor3 = Color3.new(1, 1, 1)
    else
        btn.BackgroundColor3 = Color3.fromRGB(240, 240, 240) -- Botões brancos superiores
        btn.TextColor3 = Color3.new(0, 0, 0)
    end
    return btn
end

-- BOTÕES CONFORME O VÍDEO
local btnCamera = CreateStarBtn("AUTO ALIGN CAMERA", false)
local btnPosition = CreateStarBtn("AUTO POSITION", false)
local btnFlash = CreateStarBtn("FLASH - GRAB", true)

-- LÓGICA DO FLASH - GRAB
-- Esta função foca em pegar itens rapidamente na área da loja de equipamentos.
btnFlash.MouseButton1Click:Connect(function()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        -- Coordenada da Loja de Equipamentos (Direita/Topo)
        local lojaPos = Vector3.new(25, 4, -45) 
        hrp.CFrame = CFrame.new(lojaPos + Vector3.new(0, 2, 0))
        
        -- Simula a coleta rápida (Flash TP)
        task.wait(0.3)
        print("Flash - Grab executado na Loja de Equipamentos!")
    end
end)

-- BARRA DE INVENTÁRIO PERSONALIZADA (ÍCONE DE RAIO)
local InvFrame = Instance.new("Frame", sg)
InvFrame.Size = UDim2.new(0, 300, 0, 60)
InvFrame.Position = UDim2.new(0.5, -150, 0.9, -30)
InvFrame.BackgroundTransparency = 0.5
InvFrame.BackgroundColor3 = Color3.new(0, 0, 0)

local flashIcon = Instance.new("ImageLabel", InvFrame)
flashIcon.Size = UDim2.new(0, 50, 0, 50)
flashIcon.Position = UDim2.new(0.5, -25, 0.5, -25)
flashIcon.Image = "rbxassetid://10816901249" -- Ícone de Raio/Flash
flashIcon.BackgroundTransparency = 1
flashIcon.ImageColor3 = Color3.new(1, 1, 0) -- Amarelo brilhante
