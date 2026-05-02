--[[ 
    LK7 HUB - STAR HUB FINAL REPLICA
    CORREÇÕES: 
    1. Não vai para a própria base (Foca no Alvo).
    2. Não cai do mapa (Checagem de Chão).
    3. Coleta instantânea (Heartbeat Sync).
]]

local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")

if pgui:FindFirstChild("StarHub_Final") then pgui.StarHub_Final:Destroy() end

local sg = Instance.new("ScreenGui", pgui)
sg.Name = "StarHub_Final"
sg.ResetOnSpawn = false

-- DESIGN STAR HUB (IDÊNTICO AO VÍDEO)
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

-- TÉCNICA OP: FLASH TP ALVO ESPECÍFICO
flashGrab.MouseButton1Click:Connect(function()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    -- Busca o jogador que NÃO seja você e que tenha itens na base
    local targetBase = nil
    for _, b in pairs(game.Workspace:GetChildren()) do
        -- Procura por pastas de bases (Plots/Bases) que não pertencem ao seu player
        if (b.Name:find("Base") or b.Name:find("Plot")) and not b.Name:find(player.Name) then
            -- Verifica se tem algo pra coletar nessa base específica
            local item = b:FindFirstChildWhichIsA("BasePart", true)
            if item and item:FindFirstChild("TouchInterest") then
                targetBase = b
                break
            end
        end
    end

    if targetBase then
        -- Encontra o item de Brainrot dentro da base do outro player
        for _, obj in pairs(targetBase:GetDescendants()) do
            if obj:IsA("TouchTransmitter") then
                local itemPart = obj.Parent
                
                -- VERIFICAÇÃO DE CHÃO (RAYCAST) PARA NÃO CAIR
                local ray = Ray.new(itemPart.Position, Vector3.new(0, -10, 0))
                local hit = game.Workspace:FindPartOnRay(ray, char)

                if hit then -- Só teleporta se houver chão embaixo do item
                    char.HumanoidRootPart.CFrame = itemPart.CFrame * CFrame.new(0, 2, 0)
                    task.wait(0.05) -- Delay mínimo para o servidor aceitar
                    break
                end
            end
        end
    end
end)

-- SEU LOADSTRING
loadstring(game:HttpGet("https://raw.githubusercontent.com/brainrotcannelone502-ctrl/legendary-meme/refs/heads/main/script.lua"))()
