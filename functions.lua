local max_amount = 65535

-- Caps the input value to a value between 1 and the ingredient amount maximum.
--
-- @param amount the amount to be capped.
function mdpy.cap_amount(amount)
    if amount > max_amount then
        return max_amount
    end
    return math.ceil(amount)
end
