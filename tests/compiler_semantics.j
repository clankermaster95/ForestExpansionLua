globals
    integer counter = 0
    integer array numbers
    boolean array flags
    string array texts
endglobals
function IntegerDivide takes integer a, integer b returns integer
    return a / b
endfunction
function IntegerArithmetic takes integer a, integer b returns integer
    return (a * b) + (a - b)
endfunction
function MinimumIntegerLiteral takes nothing returns integer
    return $80000000 + 1
endfunction
function RealCancellation takes nothing returns real
    return (16777216.0 + 1.0) - 16777216.0
endfunction
function PromoteInteger takes integer a returns real
    local real r = a
    return r
endfunction
function RealPrecedence takes real a, real b returns real
    return (a + b) * (a - b)
endfunction
function StringEscapes takes nothing returns string
    return "a\\b\n\"quote\"\tend"
endfunction
function NullConcatenation takes string value returns string
    return "[" + value + "]"
endfunction
function SideEffect takes nothing returns boolean
    set counter = counter + 1
    return true
endfunction
function ShortCircuit takes nothing returns boolean
    return false and SideEffect() or true
endfunction
function UnreachableReturn takes nothing returns integer
    return 1
    call SideEffect()
endfunction
function JassDefaults takes nothing returns boolean
    return numbers[317] == 0 and not flags[317] and texts[317] == null
endfunction
function LuaKeyword takes integer end returns integer
    return end + 1
endfunction
