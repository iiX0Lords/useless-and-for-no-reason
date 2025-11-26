
local instance = require("engine.instances.instance")
local vector2 = require("engine.math.vector2")
local colour = require("engine.math.colour")

local shape = {}
shape.__index = shape
setmetatable(shape, instance)

function shape.new()
    local self = instance.new()
    setmetatable(self, shape)
    self.Name = "Shape"
    self.ClassName = self.Name
    self.Size = vector2.new(100, 100)
    self.Position = vector2.new(0, 0)
    self.Rotation = 0
    self.Colour = colour.new(255, 255, 255)

    self.Parent = nil

    return self
end

function shape:Render()
    love.graphics.push()
	love.graphics.translate(self.Position.x + self.Parent.Camera.Position.x, self.Position.y + self.Parent.Camera.Position.y)
    love.graphics.scale(self.Parent.Camera.Zoom, self.Parent.Camera.Zoom)
	love.graphics.rotate(self.Rotation)
	love.graphics.rectangle("fill", -self.Size.x/2, -self.Size.y/2, self.Size.x, self.Size.y)
	love.graphics.pop()
end

function shape:IsVisible(instance)
    local size = instance.Size
    local camera = instance.Parent.Camera
    local pos = instance.Position
    pos = camera:ToScreenSpace(pos)

    local WindowHeight = 600
    local WindowWidth = 800

    local left = pos.x - (size.x / 2)
    local right = pos.x + (size.x / 2)
    local top = pos.y - (size.y / 2)
    local bottom = pos.y + (size.y / 2)

    if right < 0 then
        return false
    end
    if left > WindowWidth then
        return false
    end
    if bottom < 0 then
        return false
    end
    if top > WindowHeight then
        return false
    end

    return true
end

function shape:SetScene(scene)
    self.Parent = scene
    table.insert(scene.Children, self)
end

return shape