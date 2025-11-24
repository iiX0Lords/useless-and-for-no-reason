local engine = require("engine.main")

local mainScene = engine:CreateScene("Main")

local shape = engine.instances.Shape.new()
table.insert(mainScene.Children, shape)

function love.draw()
    engine:Render()
end