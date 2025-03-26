local forestBossTeleporter = {
    { 160, -148 },
    { 145, -156 },
    { 143, -141 },
}

local caveBossTeleporter = {
    { 55, 48 }, -- 進行方向の後ろ側
    { 45, 65 }, -- 進行方向右側
    { 66, 65 }, -- 進行方向左側
}

local function pointInTriangle(px, py, ax, ay, bx, by, cx, cy)
    local v0x, v0y = cx - ax, cy - ay
    local v1x, v1y = bx - ax, by - ay
    local v2x, v2y = px - ax, py - ay

    local dot00 = v0x * v0x + v0y * v0y
    local dot01 = v0x * v1x + v0y * v1y
    local dot02 = v0x * v2x + v0y * v2y
    local dot11 = v1x * v1x + v1y * v1y
    local dot12 = v1x * v2x + v1y * v2y

    local denom = dot00 * dot11 - dot01 * dot01
    if denom == 0 then return false end

    local invDenom = 1 / denom
    local u = (dot11 * dot02 - dot01 * dot12) * invDenom
    local v = (dot00 * dot12 - dot01 * dot02) * invDenom

    local epsilon = 1e-10
    return (u >= -epsilon) and (v >= -epsilon) and (u + v <= 1 + epsilon)
end

local function isPointInAnyTriangle(px, py, tri)
    if pointInTriangle(px, py, tri[1][1], tri[1][2], tri[2][1], tri[2][2], tri[3][1], tri[3][2]) then
        return true
    end
    return false
end

local function onTeleporter(floor, x, y, z)
    if floor == 11 then
        return isPointInAnyTriangle(x, z, forestBossTeleporter)
    end
    if floor == 12 then
        return isPointInAnyTriangle(x, z, caveBossTeleporter)
    end
end

return {
    onTeleporter = onTeleporter
}
