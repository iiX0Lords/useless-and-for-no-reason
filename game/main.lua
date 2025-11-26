local engine = require("engine.main")

local mainScene = engine:CreateScene("Main")

local shape = engine.Instance("Shape")
shape:SetScene(mainScene)
shape.Colour = engine.Colour.new(255, 0, 0)

local cam = engine.Instance("Camera")
cam:SetScene(mainScene)
cam:SetActive(true)

local fps = engine.Instance("Label")
fps:SetScene(mainScene)
fps.Colour = engine.Colour.new(0, 255, 0)

local sprites = {}
function Spawn(pos)
    local sprite = engine.Instance("sprite")
    sprite:SetScene(mainScene)
    sprite.Image = engine.services.AssetManager.LoadImage("assets/test.png")
    if pos then
        sprite.Position = pos
    end
    table.insert(sprites, sprite)
    sprite.ZIndex = #sprites
end

local pressed = false
local movement = {
    Up = false,
    Down = false,
    Left = false,
    Right = false
}

engine.services.InputService.OnKeypressed(function(key)
    if key == "f" then
        pressed = true
    end

    if key == "w" then
        movement.Up = true
    end
    if key == "s" then
        movement.Down = true
    end
    if key == "a" then
        movement.Left = true
    end
    if key == "d" then
        movement.Right = true
    end

    if key == "g" then
        cam.Zoom = cam.Zoom + 0.1
    end
end)

engine.services.InputService.OnKeyreleased(function(key)
    if key == "f" then
        pressed = false
    end

    if key == "w" then
        movement.Up = false
    end
    if key == "s" then
        movement.Down = false
    end
    if key == "a" then
        movement.Left = false
    end
    if key == "d" then
        movement.Right = false
    end
end)

engine.services.Runservice:RenderStep("Test", function(dt)

    if movement.Up then
        cam.Position = cam.Position + engine.Vector2.new(0, 350 * dt)
    end
    if movement.Down then
        cam.Position = cam.Position - engine.Vector2.new(0, 350 * dt)
    end
    if movement.Left then
        cam.Position = cam.Position + engine.Vector2.new(350 * dt, 0)
    end
    if movement.Right then
        cam.Position = cam.Position - engine.Vector2.new(350 * dt, 0)
    end

    shape.Rotation = shape.Rotation + 1 * dt
    for _, sprite in pairs(sprites) do
        sprite.Rotation = sprite.Rotation + 1 * dt
    end

    if pressed then
        local x, y = love.mouse.getPosition()
        local pos = cam:ToWorldSpace(engine.Vector2.new(x, y))
        Spawn(pos)
    end
end)

engine.services.Runservice:OnDraw("draw", function()
    local visible = 0
    for _,v in pairs(mainScene.Children) do
        if v.Render ~= nil then
            if v:IsVisible() then
                visible = visible + 1
            end
        end
    end
    fps.Text = "FPS: ".. tostring(love.timer.getFPS()).. "\nInstances: ".. tostring(#mainScene.Children).."\nVisible: ".. tostring(visible)
end)