
--[[

    TODO
    Create colour class
    Add sprites
    Add rotation
    Create camera
    Create InputService

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
    Runservice = require("engine.services.runservice")
}

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
                if instance:IsA("Shape") then
                    love.graphics.setColor(instance.Colour[1] / 255, instance.Colour[2] / 255, instance.Colour[3] / 255)
                    love.graphics.rectangle("fill", instance.Position.x, instance.Position.y, instance.Size.x, instance.Size.y)
                end
            end
        end
    end
end

function engine.Instance(classname)
    local exists = love.filesystem.getInfo("engine/instances/".. string.lower(classname) ..".lua")
    if exists then
        if exists.type ~= "file" then return nil end
        local instance = require("engine/instances/".. string.lower(classname))
        return instance.new()
    end
    return nil
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