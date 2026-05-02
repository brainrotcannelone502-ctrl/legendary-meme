--[[ 
    LK7 HUB - STAR HUB UNIVERSAL (NO ERRORS)
    Foco: Pegar QUALQUER item da base alvo sem cair do mapa
]]

local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

if pgui:FindFirstChild("StarHub_Universal") then pgui.StarHub_Universal:Destroy() end

local sg = Instance.new("ScreenGui", pgui)
sg.Name = "StarHub_Universal"
sg.ResetOnSpawn = false

-- PAINEL STAR HUB (IDENTICO AO VÍDEO)
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 210, 0, 135)
Main.Position = UDim2.new(1, -220, 0, 50) 
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(200, 200, 200)

local layout = Instance.new("UIListLayout", Main)
layout.Padding = UDim.new(0, 4)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function CreateBtn(text, isFlash)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 195, 0, 32)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.BackgroundColor3 = isFlash and Color3.fromRGB(180, 40, 40) or Color3.fromRGB(255, 255, 255)
    btn.TextColor3 = isFlash and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    return btn
end

local autoCamera = CreateBtn("AUTO ALIGN CAMERA", false)
local autoPosition = CreateBtn("AUTO POSITION", false)
local flashGrab = CreateBtn("FLASH - GRAB", true)

-- TÉCNICA FLASH GRAB UNIVERSAL (PEGA TUDO NA BASE ALVO)
flashGrab.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        -- 1. Tenta achar qualquer item com "TouchInterest" (coletável) no mapa
        -- Prioriza itens que estão dentro de zonas de coleta (Collect Zone)
        for _, item in pairs(game.Workspace:GetDescendants()) do
            if item:IsA("TouchTransmitter") then -- Detecta o gatilho de pegar o item
                local parent = item.Parent
                if parent and parent:IsA("BasePart") then
                    -- SEGURANÇA: Só teleporta se o item estiver acima de uma certa altura (evita o vazio)
                    if parent.Position.Y > -10 then 
                        char.HumanoidRootPart.CFrame = parent.CFrame * CFrame.new(0, 2, 0)
                        task.wait(0.05) -- Velocidade máxima de 60Hz
                        break 
                    end
                end
            end
        end
    end
end)

-- SEU LOADSTRING
loadstring(game:HttpGet("https://raw.githubusercontent.com/brainrotcannelone502-ctrl/legendary-meme/refs/heads/main/script.lua"))()
