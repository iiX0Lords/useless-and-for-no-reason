
local sceneManager = require("engine.instances.scene")
local scenes = {}

local engine = {}

function engine:CreateScene(name)
    local newScene = sceneManager.new()
    newScene.Name = name
    table.insert(scenes, newScene)

    return newScene
end


function engine:Render()
    for _, scene in pairs(scenes) do
        for _, instance in pairs(scene.Children) do
            if instance:IsA("Shape") then
                print(instance.Name)
                love.graphics.rectangle("fill", instance.Position.x, instance.Position.y, instance.Size.x, instance.Size.y)
            end
        end
    end
end

engine.instances = {
    Shape = require("engine.instances.shape")
}


return engine