local shader = {}

function shader.new(shaderpath, options)
    local code = love.filesystem.read(shaderpath)
    local sh = love.graphics.newShader(code)

    local canvas = love.graphics.newCanvas()

    if options then
        for k, v in pairs(options) do
            if sh:hasUniform(k) then
                sh:send(k, v)
            end
        end
    end

    return {
        shader = sh,
        canvas = canvas,
        options = options or {},
        name = shaderpath,
        __lastCanvas = nil,
        __pushed = false,
        __canResize = true,

        set = function(self, key, value)
            if self.shader:hasUniform(key) then
                self.shader:send(key, value)
                self.options[key] = value
            end

            return self -- allow for chaining
        end,

        get = function(self, key)
            return self.options[key]
        end,

        push = function(self)
            if self.__pushed then
                error("Cannot push already pushed shader: " .. self.name)
            end
            self.__lastCanvas = love.graphics.getCanvas()
            love.graphics.setCanvas(self.canvas)
            love.graphics.clear()

            self.__pushed = true
        end,

        setResize = function(self, v)
            self.__canResize = v
        end,

        resize = function(self, width, height)
            if not self.__canResize then
                return
            end
            self.canvas = love.graphics.newCanvas(width, height)
            if self.__resizeCallback then
                self.__resizeCallback(width, height)
            end
        end,

        pop = function(self)
            if not self.__pushed then
                error("Cannot pop shader that is not pushed: " .. self.name)
            end
            love.graphics.setCanvas(self.__lastCanvas)
            local lastShader = love.graphics.getShader()
            love.graphics.setShader(self.shader)
            love.graphics.draw(self.canvas)
            love.graphics.setShader(lastShader)
            self.__pushed = false
        end
    }
end

return shader
