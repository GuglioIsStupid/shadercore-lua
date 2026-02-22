local shadercore = require("shadercore")

shadercore:register("colorShift", "shaders/colorShift.glsl", { time = 0, time2 = 0 })
shadercore:register("wave", "shaders/wave.glsl", { time = 0, resolution = { love.graphics.getWidth(), love.graphics.getHeight() } })
shadercore:register("rainbow", "shaders/rainbow.glsl", { time = 0 })
shadercore:register("rgbsplit", "shaders/rgbsplit.glsl", { time = 0 })
shadercore:register("scanline", "shaders/scanline.glsl", { time = 0, resolution = { love.graphics.getWidth(), love.graphics.getHeight() } })
shadercore:setCallback("wave", "resize", function(w, h)
    shadercore:set("wave", "resolution", { w, h })
end)
shadercore:setCallback("scanline", "resize", function(w, h)
    shadercore:set("scanline", "resolution", { w, h })
end)

function love.update(dt)
    shadercore:set("colorShift", "time", shadercore:get("colorShift"):get("time") + dt)
    shadercore:set("wave", "time", shadercore:get("wave"):get("time") + dt)
    shadercore:set("rainbow", "time", shadercore:get("rainbow"):get("time") + dt)
    shadercore:set("rgbsplit", "time", shadercore:get("rgbsplit"):get("time") + dt)
    shadercore:set("scanline", "time", shadercore:get("scanline"):get("time") + dt)
end

function love.resize(w, h)
    shadercore:resize(w, h)
end

function love.draw()
    shadercore:push("scanline")
        shadercore:get("rgbsplit"):push()
            shadercore:push("rainbow")
                love.graphics.rectangle("fill", 50, 50, 300, 300)
            shadercore:pop("rainbow")
        shadercore:get("rgbsplit"):pop()

        love.graphics.circle("fill", 400, 300, 100)

        shadercore:push("wave")
            shadercore:push("colorShift")
                love.graphics.rectangle("fill", 100, 375, 200, 200)
            shadercore:pop("colorShift")

            love.graphics.circle("fill", 680, 300, 100)
        shadercore:pop("wave")
    shadercore:pop("scanline")
end
