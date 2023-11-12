function update_pause(dt)
    if selectKey == 1 or startKey == 1 then
        selectKey = 0
        startKey = 0
        game_state = STATE_GAME
    end
end

function draw_pause_top()
    love.graphics.setColor( 0.0, 0.0, 0.0, 0.5 )
	love.graphics.rectangle("fill", 0,0, 400,240)
	love.graphics.setColor( 1, 1, 1, 1 )
    -- draw bolded PAUSE text
    love.graphics.printf( "PAUSE", 0, 110, 400, "center")
    love.graphics.printf( "PAUSE", 0, 110+1, 400, "center")
end


function draw_pause_bottom()
    love.graphics.setColor( 0.0, 0.0, 0.0, 0.5 )
	love.graphics.rectangle("fill", 0,0, 320,240)
	love.graphics.setColor( 1, 1, 1, 1 )
end