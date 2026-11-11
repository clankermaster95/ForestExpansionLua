-- Compatibility operations used by the typed JASS port. Lua 5.3+.
-- Keep engine natives and handle IDs supplied by Warcraft III.
local __forestInt32 = math.maxinteger == 2147483647
local __forestReal32 = (16777216.0 + 1.0) == 16777216.0

function __jint(value)
    -- Warcraft uses 32-bit Lua numbers; the standalone tools may use 64-bit.
    if __forestInt32 then return value | 0 end
    value = value & 0xffffffff
    if value >= 0x80000000 then return value - 0x100000000 end
    return value
end

function __jreal(value)
    -- Coerce integers to real even when the VM already uses binary32.
    -- The game path does not depend on string.pack/unpack or their save state.
    if __forestReal32 then return value + 0.0 end
    -- Standard standalone Lua uses wider floating-point numbers.
    return (string.unpack("f", string.pack("f", value)))
end

function __jdiv(a, b)
    -- Lua // rounds down, while JASS integer division truncates toward zero.
    if b == 0 then error("JASS integer division by zero", 2) end
    -- Avoid abs(INT_MIN), which cannot be represented by a signed 32-bit int.
    local quotient = a // b
    if math.fmod(a, b) ~= 0 and (a < 0) ~= (b < 0) then quotient = quotient + 1 end
    return __jint(quotient)
end

function __jarray(default)
    return setmetatable({}, {__index = function() return default end})
end

function __jconcat(a, b)
    return (a or "") .. (b or "")
end
