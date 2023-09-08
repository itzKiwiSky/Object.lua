PATH = ...

json = require(PATH .. ".json")

local object = {
    _VERSION        = "Object 0.0.1",
    _AUTHOR         = "StrawberryChocolate",
    _URL            = "https://github.com/Doge2Dev/Object.lua",
}
object.__index = object

--% Object instance %--

function object.new(_x, _y)
    local o = setmetatable({}, object)
    o.x = _x or 0
    o.y = _y or 0
    o.sizeX = 1
    o.sizeY = 1
    o.angle = 0
    o.originX = 0
    o.originY = 0
    o.hitbox = {}
    o.hitbox.x = o.x
    o.hitbox.y = o.y
    o.hitbox.w = 16
    o.hitbox.h = 16
    o.animation = {}
    o.animation.animations = {}
    o.animation.frame = 1
    o.animation.currentAnimation = ""
    o.animation.frameRate = 1
    o.animation.speed = 1
    o.animation.animationsPlaying = false
    o.meta = {}
    o.meta.image = nil
    o.meta.quads = {}
    o.meta.animationTimer = 0
    o.meta.flipX = false
    o.meta.flipY = false
    o.meta.animationLoop = false
    o.meta.displayHitbox = false
    return o
end

--% Object functions %--

function object:loadGraphic(_path)
    self.meta.image = love.graphics.newImage(_path)
end

function object:loadSparrow(_path)
    self.meta.image = love.graphics.newImage(_path .. ".png")
    local jsonData = love.filesystem.read(_path .. ".json")
    local sparrow = json.decode(jsonData)

    local Quads = {}
    for i = 1, #sparrow.frames, 1 do
        table.insert(
            self.meta.quads, love.graphics.newQuad(
            sparrow.frames[i].frame.x,
            sparrow.frames[i].frame.y,
            sparrow.frames[i].frame.w,
            sparrow.frames[i].frame.h,
            self.meta.image
            )
        )
    end
end

function object:registerAnimation(_animationName, _indexes)
    self.animation.animations[_animationName] = _indexes
end

function object:setAnimation(_animationName, _speed, _loop)
    self.animation.currentAnimation = _animationName or "idle"
    self.animation.frameRate = _speed or 1
    self.meta.animationLoop = _loop or false
    self.animation.animationPlaying = true
end

function object:centerScreen()
    self.x, self.y = love.graphics.getWidth() / 2, love.graphics.getHeight() / 2
end

function object:centerOrigin()
    if #self.meta.quads > 0 then
        local x, y, w, h = self.meta.quads[1]:getViewport()
        self.originX, self.originY = w / 2, h / 2
    else
        self.originX, self.originY = self.meta.image:getWidth() / 2, self.meta.image:getHeight() / 2
    end
end

function object:updateHitbox()
    if #self.meta.quads > 0 then
        local x, y, w, h = self.meta.quads[1]:getViewport()
        self.hitbox.x, self.hitbox.y = self.x - (w * (self.sizeX / 2)), self.y - (h * (self.sizeY / 2))
        self.hitbox.w, self.hitbox.h = w * self.sizeX, h * self.sizeY
    else
        self.hitbox.x, self.hitbox.y = self.x - (self.meta.image:getWidth() * (self.sizeX / 2)), self.y - (self.meta.image:getHeight() * (self.sizeY / 2))
        self.hitbox.w, self.hitbox.h = self.meta.image:getWidth() * self.sizeX, self.meta.image:getHeight() * self.sizeY
    end
end

function object:flipX(_flip)
    self.meta.flipX = _flip
    if self.meta.flipX then
        self.sizeX = -self.sizeX
    else
        self.sizeX = self.sizeX
    end
end

function object:flipY(_flip)
    self.meta.flipY = _flip
    if self.meta.flipY then
        self.sizeY = -self.sizeY
    else
        self.sizeY = self.sizeY
    end
end


--% External API %--

function object:draw()
    if self.meta.image ~= nil then
        if #self.meta.quads == 0 then
            love.graphics.draw(self.meta.image, self.x, self.y, self.angle, self.sizeX, self.sizeY, self.originX, self.originY)
        else
            love.graphics.draw(self.meta.image, self.meta.quads[self.animation.animations[self.animation.currentAnimation][self.animation.frame]], self.x, self.y, self.angle, -self.sizeX, self.sizeY, self.originX, self.originY)
        end
        if self.meta.displayHitbox then
            love.graphics.rectangle("line", self.hitbox.x, self.hitbox.y, self.hitbox.w, self.hitbox.h)
        end
    end
end

function object:update(elapsed)
    if #self.meta.quads > 0 then
        if self.animation.animationPlaying then
            self.meta.animationTimer = self.meta.animationTimer + 1
            if self.meta.animationTimer >= self.animation.frameRate then
                self.meta.animationTimer = 0
                self.animation.frame = self.animation.frame + 1
                if self.animation.frame > #self.animation.animations[self.animation.currentAnimation] then
                    if self.meta.animationLoop then
                        self.animation.frame = 1
                    else
                        self.animation.frame = #self.animation.animations[self.animation.currentAnimation]
                        self.animation.animationPlaying = false
                    end
                end
            end
        end
    end
end


return object