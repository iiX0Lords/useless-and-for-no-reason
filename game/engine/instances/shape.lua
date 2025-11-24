
local instance = require("engine.instances.instance")
local vector2 = require("engine.math.vector2")

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
    self.Parent = nil

    return self
end

return shape