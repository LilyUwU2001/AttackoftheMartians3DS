function spawn_decors()
	for y=1, map_h do
		for x=1, map_w do                                                         
			if map[y][x] == 4 then
				spawn_decor(x*32, y*32, 4)
				map[y][x] = 0
			end
			if map[y][x] == 5 then
				spawn_decor(x*32, y*32, 5)
				map[y][x] = 0
			end
			if map[y][x] == 6 then
				spawn_decor(x*32, y*32, 6)
				map[y][x] = 0
			end
			if map[y][x] == 7 then
				spawn_decor(x*32, y*32, 7)
				map[y][x] = 0
			end
			if map[y][x] == 8 then
				spawn_decor(x*32, y*32, 8)
				map[y][x] = 0
			end
			if map[y][x] == 9 then
				spawn_decor(x*32, y*32, 9)
				map[y][x] = 0
			end
			if map[y][x] == 10 then
				spawn_decor(x*32, y*32, 10)
				map[y][x] = 0
			end
			if map[y][x] == 11 then
				spawn_decor(x*32, y*32, 11)
				map[y][x] = 0
			end
			if map[y][x] == 32 then
				spawn_decor(x*32+8, y*32-8, 32)
				map[y][x] = 0
			end
			if map[y][x] == 33 then
				spawn_decor(x*32+8, y*32-16, 33)
				map[y][x] = 0
			end
			if map[y][x] == 34 then
				spawn_decor(x*32+8, y*32-16, 34)
				map[y][x] = 0
			end
			if map[y][x] == 35 then
				spawn_decor(x*32+8, y*32-16, 35)
				map[y][x] = 0
			end
			if map[y][x] == 36 then
				spawn_decor(x*32+8, y*32-16, 36)
				map[y][x] = 0
			end
			if map[y][x] == 37 then
				spawn_decor(x*32+8, y*32-4, 37)
				map[y][x] = 0
			end
			if map[y][x] == 38 then
				spawn_decor(x*32+8, y*32-8, 38)
				map[y][x] = 0
			end
		end
	 end
end

function spawn_decor(x,y,t)
	local d = {}
	d.x = x
	d.y = y
	d.t = t
	add(decors, d)
end

function draw_decors()
	for decor in all(decors) do
		draw_decor(decor)
	end
end

function draw_decor(self)
	if self.t < 8 then
		love.graphics.draw(tile[self.t], - 48 + self.x - offset_x - firstTile_x * 32, - 48 + self.y - offset_y - firstTile_y * 32)
	end
	if self.t >= 8 then
		love.graphics.draw(tile[self.t], - 48 + self.x - offset_x - firstTile_x * 32, - 40 + self.y - offset_y - firstTile_y * 32)
	end
end