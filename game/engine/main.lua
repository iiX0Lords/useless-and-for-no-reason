
--[[

    TODO
    Create camera
]]

local sceneManager = require("engine.instances.scene")
local scenes = {}

local engine = {
    Vector2 = require("engine.math.vector2")
}

engine.instances = {
    Shape = require("engine.instances.shape")
}
engine.services = {
    Runservice = require("engine.services.runservice"),
    AssetManager = require("engine.services.assetmanager"),
    InputService = require("engine.services.inputservice")
}
engine.Colour = require("engine.math.colour")

function engine:CreateScene(name)
    local newScene = sceneManager.new()
    newScene.Name = name
    newScene.Active = true
    table.insert(scenes, newScene)

    return newScene
end

function engine:Render()
    for _, scene in pairs(scenes) do
        if scene.Active == true then
            for _, instance in pairs(scene.Children) do
                if instance.Render then
                    if instance:IsVisible(instance) then
                        love.graphics.setColor(instance.Colour.r / 255, instance.Colour.g / 255, instance.Colour.b / 255)
                        instance:Render()
                    end
                end
            end
        end
    end
end

function engine.Instance(classname)
    return engine.services.AssetManager.AttemptRequire("engine/instances/".. string.lower(classname) ..".lua").new()
end

function love.update(dt)
    for _, loop in pairs(engine.services.Runservice.loops) do
        loop.Callback(dt)
    end
end
function love.draw()
    engine:Render()
    for _, loop in pairs(engine.services.Runservice.drawingloops) do
        loop.Callback()
    end
    
end

return engine