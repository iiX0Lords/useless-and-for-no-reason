
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
	love.graphics.translate(self.Position.x, self.Position.y)
	love.graphics.rotate(self.Rotation)
	love.graphics.rectangle("fill", -self.Size.x/2, -self.Size.y/2, self.Size.x, self.Size.y)
	love.graphics.pop()
end

function shape:SetScene(scene)
    self.Parent = scene
    table.insert(scene.Children, self)
end

return shape