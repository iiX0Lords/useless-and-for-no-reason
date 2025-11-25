local engine = require("engine.main")

local mainScene = engine:CreateScene("Main")

local shape = engine.Instance("Shape")
shape:SetScene(mainScene)
shape.Colour = engine.Colour.new(255, 0, 0)

engine.services.Runservice:RenderStep("Test", function(dt)
    shape.Position = shape.Position + engine.Vector2.new(100 * dt, 100 * dt)
    shape.Rotation = shape.Rotation + 1 * dt
end)