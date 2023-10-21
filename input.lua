--  upKey = 12
--	downKey = 13
--	leftKey = 14
--	rightKey = 15
--	aKey = 1
--	bKey = 2
--	xKey = 3
--	yKey = 4
--	selectKey = 5
--	startKey = 7
function love.gamepadpressed(joystick, button)
    -- button here has a code
    gam_label = "gamepad pressed: " .. tostring(button)
    if tostring(button) == "dpup" then
        upKey = 1
    end
    if tostring(button) == "dpdown" then
        downKey = 1
    end
    if tostring(button) == "dpleft" then
        leftKey = 1
    end
    if tostring(button) == "dpright" then
        rightKey = 1
    end
    if tostring(button) == "a" then
        aKey = 1
    end
    if tostring(button) == "b" then
        bKey = 1
    end
    if tostring(button) == "x" then
        xKey = 1
    end
    if tostring(button) == "y" then
        yKey = 1
    end
    if tostring(button) == "back" then
        selectKey = 1
    end
    if tostring(button) == "start" then
        startKey = 1
    end
    if tostring(button) == "leftshoulder" then
        leftShoulderKey = 1
    end
    if tostring(button) == "rightshoulder" then
        rightShoulderKey = 1
    end
end
function love.gamepadreleased(joystick, button)
    -- button here has a code
    gam_label = "gamepad released: " .. tostring(button)
    if tostring(button) == "dpup" then
        upKey = 0
    end
    if tostring(button) == "dpdown" then
        downKey = 0
    end
    if tostring(button) == "dpleft" then
        leftKey = 0
    end
    if tostring(button) == "dpright" then
        rightKey = 0
    end
    if tostring(button) == "a" then
        aKey = 0
    end
    if tostring(button) == "b" then
        bKey = 0
    end
    if tostring(button) == "x" then
        xKey = 0
    end
    if tostring(button) == "y" then
        yKey = 0
    end
    if tostring(button) == "back" then
        selectKey = 0
    end
    if tostring(button) == "start" then
        startKey = 0
    end
    if tostring(button) == "leftshoulder" then
        leftShoulderKey = 0
    end
    if tostring(button) == "rightshoulder" then
        rightShoulderKey = 0
    end
end