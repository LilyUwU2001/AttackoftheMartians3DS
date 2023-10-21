function draw_bg()
	love.graphics.setColor(stagebgs[stagenum])
	love.graphics.rectangle("fill", 0,0, 400,240)
	love.graphics.setColor( 1, 1, 1, 1 )
end
	
function draw_map()
	offset_x = (map_x % tile_w) - 16
	offset_y = (map_y % tile_h) - 16
	firstTile_x = math.floor(map_x / tile_w)
	firstTile_y = math.floor(map_y / tile_h)
	
	for y=1, (map_display_h + map_display_buffer) do
		for x=1, (map_display_w + map_display_buffer) do
			-- Note that this condition block allows us to go beyond the edge of the map.
			if y+firstTile_y >= 1 and y+firstTile_y <= map_h
				and x+firstTile_x >= 1 and x+firstTile_x <= map_w
			then
				love.graphics.draw(
					tile[map[y+firstTile_y][x+firstTile_x]], 
					((x-1)*tile_w) - offset_x - tile_w/2, 
					((y-1)*tile_h) - offset_y - tile_h/2)
			end
		end
	end
end

function scroll_map(dt)
    local speed = (5*60*dt)/2
	-- get input
    leftAnalog_x = Joystick:getAxis(1)
    leftAnalog_y = Joystick:getAxis(2)
    rightAnalog_x = Joystick:getAxis(3)
    rightAnalog_y = Joystick:getAxis(4)

    for p in all(players) do
        target_map_x = p.x - 175 + (leftShoulderKey * -175) + (rightShoulderKey * 175)
        target_map_y = p.y - 60
    end

	if map_x > target_map_x then
		map_x = map_x - speed
	end
    if map_x < target_map_x then
		map_x = map_x + speed
	end
    if map_y > target_map_y then
		map_y = map_y - speed
	end
    if map_y < target_map_y then
		map_y = map_y + speed
	end
	if Joystick:isGamepadDown( "start" ) then
		love.event.quit()
	end

	-- check boundaries. remove this section if you don't wish to be constrained to the map.
	if map_x < 0 then
		map_x = 0
	end

	if map_y < 0 then
		map_y = 0
	end	
 
	if map_x > map_w * tile_w - map_display_w * tile_w - 1 then
		map_x = map_w * tile_w - map_display_w * tile_w - 1
	end
 
	if map_y > map_h * tile_h - map_display_h * tile_h - 1 then
		map_y = map_h * tile_h - map_display_h * tile_h - 1
	end
end