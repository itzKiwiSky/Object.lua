function love.load()
    require 'libraries.getTableContent'
    object = require 'libraries.object'

    love.graphics.setDefaultFilter("nearest", "nearest")

    love.graphics.setBackgroundColor(127 / 255, 20 / 255, 56 / 255)

    animatedObject = object.new()
    staticobj = object.new(90, 90)

    staticobj:loadGraphic("resources/images/player.png")
    staticobj.sizeX = 8
    staticobj.sizeY = 8
    staticobj:centerOrigin()
    staticobj:updateHitbox()


    animatedObject:loadSparrow("resources/images/player-sheet")    
    animatedObject:registerAnimation("walk_down", {1, 2, 1, 3})    
    animatedObject:registerAnimation("walk_up", {7, 8, 7, 9})  
    animatedObject:registerAnimation("walk_dir", {4, 5, 4, 6}) 
    animatedObject:setAnimation("walk_dir", 5, true)
    animatedObject.sizeX = 8
    animatedObject.sizeY = 8
    animatedObject:centerScreen()
    animatedObject:centerOrigin()
    animatedObject:updateHitbox()
    animatedObject:flipY(false)
    animatedObject:flipX(true)
end

function love.draw()
    animatedObject:draw()
    staticobj:draw()
end

function love.update(elapsed)
    animatedObject:update(elapsed)
    staticobj:update()
end
