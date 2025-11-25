local engine = require("engine.main")

local mainScene = engine:CreateScene("Main")

local shape = engine.Instance("Shape")
shape:SetScene(mainScene)
shape.Colour = engine.Colour.new(255, 0, 0)

local sprite = engine.Instance("sprite")
sprite:SetScene(mainScene)
sprite.Image = engine.services.AssetManager.LoadImage("assets/test.png")

engine.services.Runservice:RenderStep("Test", function(dt)
    shape.Position = shape.Position + engine.Vector2.new(100 * dt, 100 * dt)
    shape.Rotation = shape.Rotation + 1 * dt

    sprite.Position = sprite.Position + engine.Vector2.new(100 * dt, 100 * dt)
    sprite.Rotation = sprite.Rotation + 1 * dt
end)