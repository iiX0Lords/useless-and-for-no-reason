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
local darken = 0
local direction = 1
local col = engine.Colour.new(math.random(50, 255), math.random(50, 255), math.random(50, 255))
function Spawn(pos)
    local sprite = engine.Instance("Shape")
    sprite:SetScene(mainScene)
    --sprite.Image = engine.services.AssetManager.LoadImage("assets/test.png")
    sprite.Colour = engine.Colour.new(col.r - (darken / 1.2), col.g - (darken / 1.2), col.b - (darken / 1.2))
    if sprite.Colour.r <= -50 and sprite.Colour.g <= -50 and sprite.Colour.b <= -50 then
        direction = direction * -1
        sprite.Colour = engine.Colour.new(col.r - darken, col.g - darken, col.b - darken)
    elseif sprite.Colour.r > col.r and sprite.Colour.g > col.g and sprite.Colour.b > col.b then
        direction = direction * -1
        sprite.Colour = engine.Colour.new(col.r - darken, col.g - darken, col.b - darken)
    end
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
        col = engine.Colour.new(math.random(50, 255), math.random(50, 255), math.random(50, 255))
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
    if key == "h" then
        for _,v in pairs(sprites) do
            v:Destroy()
        end
    end
end)

engine.services.InputService.OnKeyreleased(function(key)
    if key == "f" then
        pressed = false
        darken = 0
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
    for i, sprite in pairs(sprites) do
        if sprite.Parent == nil then
            table.remove(sprites, i)
            else
            sprite.Rotation = sprite.Rotation + 1 * dt
        end
    end

    if pressed then
        local x, y = love.mouse.getPosition()
        local pos = cam:ToWorldSpace(engine.Vector2.new(x, y))
        Spawn(pos)
        darken = darken + direction
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
    fps.Text = "FPS: ".. tostring(love.timer.getFPS()).. "\nInstances: ".. tostring(#sprites).." ".. tostring(#mainScene.Children).."\nVisible: ".. tostring(visible)
end)