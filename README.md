# Object.lua

Object.lua is a simple library to create objects

## Creating an object

To create a object, you can call the constructor
```lua
object.new(_x, _y)
```
The `x` and `y` parameters are optional.

here a simple example
```lua
function love.load()
    object = require 'object'

    player = object.new()   -- create a new Object
    player:loadGraphic("resources/images/player.png")   -- load the image to object
end

function love.draw()
    player:draw()   -- draw the object
end
```

Object.lua also support animation with spritesheet and a map file.

```lua
function love.load()
    object = require 'object'

    player = object.new()   -- create a new object
    player:loadSparrow("resources/images/player")   -- load the spritesheet and the map file (it need be with the same name  example : player.png, player.json) [check the resources files to see the player]
    player:registerAnimation("walk_down", {1, 2, 1, 3})   -- setup the animation based on quad indexes
    player:registerAnimation("walk_up", {7, 8, 7, 9})  
    player:registerAnimation("walk_dir", {4, 5, 4, 6}) 
    player:setAnimation("walk_dir", 5, true)
end

function love.draw()
    player:draw()
end

function love.update(elapsed)
    player:update(elapsed)
end
```

you can also control how the object will be displayed with some variables.
```lua
function love.load()
    object = require 'object'

    player = object.new()   -- create a new Object
    player:loadGraphic("resources/images/player.png")   -- load the image to object

    -- set the object position --
    player.x = love.graphics.getWidth()
    player.y = love.graphics.getHeight()

    -- or you can get the easy way --
    player:centerScreen()

    -- and also center the origin point --
    player:centerOrigin()

    -- and flip it horizontally or vertically --
    player:flipX(true)  -- now the object is flipped on X
    player:flipY(false) -- and here the object is on normal direction
end
```

Object.lua also have built-in functions to hitboxes, so you don't need to setup any hitbox.
When you create a object a hitbox is automatically created.
```lua
object:updateHitbox()
```

## List of functions

| Constructor |
|---|
| new() |

| Function | Description |
|---|---|
| loadGraphic(_imagePath) | Load a image to the object |
| loadSparrow(_path) | Load a spritesheet and a map file allowing animations() |
| registerAnimation(_animationName, _quadIndexes) | Register a new animation based on indexes |
| setAnimation(_animationName) | set and play the animation |
| centerScreen() | center the object position on the center of the screen |
| centerOrigin() | center the origin point of the object to the center |
| updateHitbox() | update the hitbox size and position |
| flipX(_enable) | enable or disable the horizontal flip |
| flipY(_enable) | enable or disable the vertical flip |
| draw() | draw the object |
| update(dt) | update the object if has animations |

## list of variables

```lua
    object.x
    object.
    object.sizeX
    object.sizeY
    object.angle
    object.originX
    object.originY
    object.hitbox.x
    object.hitbox.y
    object.hitbox.w
    object.hitbox.h
    object.animation.frame
    object.animation.currentAnimation
    object.animation.frameRate
    object.animation.speed
    object.animation.animationsPlaying
```

# Credits
### [HaxeFlixel (Inspiration)](https://haxeflixel.com)
### [Haxeflixel Tutorial Player](https://haxeflixel.com/documentation/sprites-and-animation/)
### [Json Library - Actboy168](https://github.com/actboy168/json.lua)

