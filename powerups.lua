function spawn_powerups()
	for y=1, map_h do
		for x=1, map_w do                                                         
			if map[y][x] == 27 then
				spawn_powerup(x*32-48, y*32-48, 32, 32, 0, 0)
				map[y][x] = 0
			end
			if map[y][x] == 28 then
				spawn_powerup(x*32-48, y*32-48, 32, 32, 0, 1)
				map[y][x] = 0
            end
            if map[y][x] == 29 then
				spawn_powerup(x*32-48, y*32-32, 32, 16, -16, 2)
				map[y][x] = 0
			end
			if map[y][x] == 30 then
				spawn_powerup(x*32-48, y*32-43, 32, 16, 0, 3)
				map[y][x] = 0
            end
            if map[y][x] == 31 then
                if stagenum <= 3 then
                    spawn_powerup(x*32-96, y*32-76, 96, 64, 0, 4)
                end
                if stagenum == 4 or stagenum == 5 or stagenum == 6 then
                    spawn_powerup(x*32-96, y*32-64, 85, 480, 0, 4)
                end
				if stagenum == 7 then
                    spawn_powerup(x*32-64, y*32-80, 64, 64, 0, 4)
                end
				if stagenum == 8 then
                    spawn_powerup(x*32-32, y*32-128, 96, 320, 0, 4)
                end
				if stagenum == 9 then
					spawn_martian(x*32-88, y*32-70, 4)
				end
                map[y][x] = 0
            end
		end
	 end
end

function spawn_powerup(x,y,w,h,o,t)
	local p = {}
	p.x = x
	p.y = y
	p.t = t
    p.w = w
    p.h = h
    p.o = o
	add(powerups, p)
end

function draw_powerups()
	for powerup in all(powerups) do
		draw_powerup(powerup)
	end
end

function draw_powerup(self)
    if self.t < 4 then
        love.graphics.draw(powerupGraphics[self.t], self.x - offset_x - firstTile_x * 32, self.y - offset_y + self.o - firstTile_y * 32)
    end
    if self.t == 4 then
		if stagenum <= 4 then
        	love.graphics.draw(powerupGraphics[3+stagenum], self.x - offset_x - firstTile_x * 32, self.y - offset_y + self.o - firstTile_y * 32)
		end
		if stagenum == 5 or stagenum == 6 then
        	love.graphics.draw(powerupGraphics[7], self.x - offset_x - firstTile_x * 32, self.y - offset_y + self.o - firstTile_y * 32)
		end
		if stagenum == 7 then
        	love.graphics.draw(powerupGraphics[8], self.x - offset_x - firstTile_x * 32, self.y - offset_y + self.o - firstTile_y * 32)
		end
		if stagenum == 8 then
        	love.graphics.draw(powerupGraphics[9], self.x - offset_x - firstTile_x * 32, self.y - offset_y + self.o - firstTile_y * 32)
		end
    end
end

function draw_powerup_collider(self)
    love.graphics.setColor( 1, 1, 0, 1 )
	love.graphics.rectangle("fill", self.x - offset_x - firstTile_x * 32, self.y - offset_y - firstTile_y * 32, self.w, self.h)
end
