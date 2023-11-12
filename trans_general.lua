function update_trans(dt, state)
    if trans_direction == 0 then
        trans_val = trans_val + 1*dt
    end
    if trans_direction == 1 then
        trans_val = trans_val - 1*dt
    end
    if check_for_trans_end() then
        stub_prev_state = game_state
        game_state = state
    end
end

function draw_trans_top()
    love.graphics.setColor( 0, 0, 0, trans_val)
	love.graphics.rectangle("fill", 0,0, 400,240)
	love.graphics.setColor( 1, 1, 1, 1 )
end

function draw_trans_bottom()
    love.graphics.setColor( 0, 0, 0, trans_val)
	love.graphics.rectangle("fill", 0,0, 320,240)
	love.graphics.setColor( 1, 1, 1, 1 )
end

function check_for_trans_end()
    if trans_direction == 0 and trans_val >= 1 then
        return true
    else if trans_direction == 1 and trans_val <= 0 then
        return true
    else 
        return false
    end
end
end

function start_trans()
    trans_direction = 0
    trans_val = 0
end

function start_detrans()
    trans_direction = 1
    trans_val = 1
end