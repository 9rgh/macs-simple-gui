local function applyPerformanceFog()
    local lighting = game:GetService("Lighting")
    
    -- Set dense fog effect (limits view distance to boost performance)
    lighting.FogEnd = 500  -- Very close fog end distance, greatly reduces rendered objects
    lighting.FogColor = Color3.new(0.6, 0.6, 0.6)  -- Neutral gray fog
    lighting.FogStart = 50  -- Fog starts at 50 studs
    
    -- Performance optimization settings
    lighting.GlobalShadows = false  -- Disable global shadows
    lighting.Brightness = 1.2  -- Compensate for brightness loss from fog
    
    -- Set FOV to 120
    if workspace:FindFirstChild("Camera") then
        workspace.Camera.FieldOfView = 90  -- Ultra wide FOV
    end
    
    -- Disable decorative effects to boost performance
    lighting.Outlines = false  -- Disable outline effects
    lighting.EnvironmentSpecularScale = 0  -- Reduce reflection effects
    lighting.EnvironmentDiffuseScale = 0.5  -- Reduce diffuse reflection
    
    -- Set fog density (if supported by the game)
    pcall(function()
        lighting.FogDensity = 0.02  -- Fog density
    end)
end

-- Execute immediately
applyPerformanceFog()

-- Monitor Lighting property changes (prevent other scripts from overriding)
game:GetService("Lighting").Changed:Connect(function(property)
    if property == "FogEnd" or property == "FogColor" or property == "FogStart" then
        task.wait(0.1)
        applyPerformanceFog()
    end
end)

-- Reapply periodically (ensure effect persists)
task.spawn(function()
    while true do
        task.wait(5)  -- Reapply every 5 seconds
        applyPerformanceFog()
    end
end)

print("Performance fog activated - FPS Boost Mode - FOV 120")