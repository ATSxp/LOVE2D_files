-- Vector Manager --
Vector = {}

function Vector:new(x, y)
    local s = {}
    s.x = x or 0
    s.y = y or 0
    return s
end

return Vector