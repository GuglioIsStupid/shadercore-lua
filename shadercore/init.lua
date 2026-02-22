local path = (...):gsub("%.init$", "")

local shadercore = {}
shadercore.__shaderFactory = require(path .. ".shader")
shadercore.__shaders = {}

function shadercore:register(name, shaderpath, options)
    self.__shaders[name] = self.__shaderFactory.new(shaderpath, options)

    return self.__shaders[name]
end

function shadercore:get(name)
    return self.__shaders[name]
end

function shadercore:has(name)
    return self.__shaders[name] ~= nil
end

function shadercore:list()
    local names = {}
    for name, _ in pairs(self.__shaders) do
        table.insert(names, name)
    end
    return names
end

function shadercore:set(name, key, value)
    local shader = self.__shaders[name]
    if shader then
        shader:set(key, value)
    else
        error("Shader not found: " .. name)
    end

    return shader
end

function shadercore:setCallback(name, key, callback)
    local shader = self.__shaders[name]
    if shader then
        shader["__" .. key .. "Callback"] = callback
    else
        error("Shader not found: " .. name)
    end
end

function shadercore:setResize(name, v)
    local shader = self.__shaders[name]
    if shader then
        shader:setResize(v)
    else
        error("Shader not found: " .. name)
    end
end

function shadercore:unregister(name)
    self.__shaders[name]:clean()
    self.__shaders[name] = nil
end

function shadercore:clean()
    for _, shader in pairs(self.__shaders) do
        shader:clean()
    end
    self.__shaders = {}
end

function shadercore:push(name)
    local shader = self.__shaders[name]
    if shader then
        shader:push()
    else
        error("Shader not found: " .. name)
    end

    return shader
end

function shadercore:pop(name)
    local shader = self.__shaders[name]
    if shader then
        shader:pop()
    else
        error("Shader not found: " .. name)
    end
end

function shadercore:resize(w, h)
    for _, shader in pairs(self.__shaders) do
        shader:resize(w, h)
    end
end

return shadercore
