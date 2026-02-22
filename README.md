# shadercore

A simple shader library for LOVE2D allowing for easy application of stacking shaders onto the game screen.

## Usage

1. Place your shader files ANYWHERE in your project. For example, you can create a `shaders` folder and put them there.
2. In your main file, require the shadercore library and initialize it with a list of shader file paths:
3. (optional) Set up any callbacks you want for your shaders - Only contains resizing at this moment
4. In your update function, update any uniforms you want to change every frame (like time, for example)
5. In your draw function, push the shader you want to use, draw your game, and then pop the shader.

```lua
local shadercore = require("shadercore")

shadercore:register("name", "path/to/shader.glsl", { time = 0, time2 = 0 }) -- options table is an example AND optional! Fill it with whatever uniforms your shader needs, or keep it empty if you want.

shadercore:setCallback("name", "resize", function(w, h)
    -- this callback will be called whenever the window is resized, and will be passed the new width and height of the window
end)

shadercore:set("name", "time", shadercore:get("name", "time") + dt)  -- this is how you update a uniform every frame. You can set it to whatever you want, of course!
            :set("time2", 10) -- You can also chain set calls like this!

shadercore:push("name")
-- draw your game here
shadercore:pop("name")
```

Don't like the shadercore:func(name, ...) syntax? No issue! You can also do this:

```lua
local shader = shadercore:register("name", "path/to/shader.glsl", { time = 0, time2 = 0 })
```

You can then use shader:func(...) instead of shadercore:func("name", ...). For example:

```lua
shader:set("time", shader:get("time") + dt)
    :set("time2", 10)
```

### Example:
```lua
function love.load()
    shadercore:register("wave", "shaders/wave.glsl", { time = 0, resolution = { love.graphics.getDimensions() } })
    shadercore:setCallback("wave", "resize", function(w, h)
        shadercore:set("wave", "resolution", { w, h })
    end)
end

function love.update(dt)
    shadercore:set("wave", "time", shadercore:get("wave", "time") + dt)
end

function love.draw()
    shadercore:push("wave")
    -- draw your game here
    shadercore:pop("wave")
end
```

## Note
This library is made for SCREEN shaders! With a bit of messing around, you CAN use this for sprites and whatnot! But that is not the purpose of this library.

Example shaders are included in the [shaders](shaders) folder. You can use them as a starting point for your own shaders, or just for testing the library!
