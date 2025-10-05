-- Script dentro del TextButton
local button = script.Parent
local player = game.Players.LocalPlayer
local flying = false
local flight = nil
 
button.MouseButton1Click:Connect(function()
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    
    if flying == false then
        -- Activar vuelo
        flying = true
        button.Text = "Volar: ON"
        
        flight = Instance.new("BodyVelocity")
        flight.Name = "Flight"
        flight.Velocity = Vector3.new(0,0,0)
        flight.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        flight.Parent = hrp
        
        -- Control de vuelo
        local UIS = game:GetService("UserInputService")
        
        UIS.InputBegan:Connect(function(input, gpe)
            if not flight.Parent then return end
            if input.KeyCode == Enum.KeyCode.W then
                flight.Velocity = hrp.CFrame.LookVector * 100
            elseif input.KeyCode == Enum.KeyCode.S then
                flight.Velocity = hrp.CFrame.LookVector * -100
            elseif input.KeyCode == Enum.KeyCode.Space then
                flight.Velocity = Vector3.new(0,100,0)
            elseif input.KeyCode == Enum.KeyCode.LeftControl then
                flight.Velocity = Vector3.new(0,-100,0)
            end
        end)
        
        UIS.InputEnded:Connect(function(input)
            if flight and flight.Parent then
                flight.Velocity = Vector3.new(0,0,0)
            end
        end)
        
    else
        -- Apagar vuelo
        flying = false
        button.Text = "Volar: OFF"
        
        if flight then
            flight:Destroy()
        end
    end
end)
