function spawn_martians()
	for y=1, map_h do
		for x=1, map_w do                                                         
			if map[y][x] == 18 then
				spawn_martian(x*32-58, y*32-66, 0)
				map[y][x] = 0
			end
			if map[y][x] == 19 then
				spawn_martian(x*32-58, y*32-66, 1)
				map[y][x] = 0
			end
			if map[y][x] == 20 then
				spawn_martian(x*32-58, y*32-66, 2)
				map[y][x] = 0
			end
			if map[y][x] == 21 then
				spawn_martian(x*32-58, y*32-66, 3)
				map[y][x] = 0
			end
			if map[y][x] == 22 then
				spawn_martian(x*32-58, y*32-16, 0)
				map[y][x] = 0
			end
			if map[y][x] == 23 then
				spawn_martian(x*32-58, y*32-16, 1)
				map[y][x] = 0
			end
			if map[y][x] == 24 then
				spawn_martian(x*32-58, y*32-16, 2)
				map[y][x] = 0
			end
			if map[y][x] == 25 then
				spawn_martian(x*32-58, y*32-16, 3)
				map[y][x] = 0
			end
		end
	 end
end

function spawn_martian(x,y,t)
	local m = {}
	m.x = x
	m.y = y
	m.t = t
    m.shootTimer = 0
    m.moveTimer = 0
    m.moveDir = 1
    m.speed = 0
    m.isDead = 0
	add(martians, m)
end

function update_martians(dt)
	for martian in all(martians) do
		update_martian(martian, dt)
	end
end

function update_martian(self, dt)
    if self.isDead == 1 then
        if self.t ~= 3 then
            TEsound.play(snd_marsDeath, "sfx")
            if self.t == 0 then
                score = score + 10
            end
            if self.t == 1 then
                score = score + 25
            end
            if self.t == 2 then
                score = score + 50
            end
            del(martians, self)
        end
        if self.t == 3 then
            TEsound.play(snd_tarcza, "sfx")
            self.isDead = 0
        end
    end
	if self.t == 0 then
        self.speed = (192*dt)/2
        self.x = self.x + self.speed*self.moveDir
        self.moveTimer = self.moveTimer + self.speed
        if self.moveTimer >= 192 then
            self.moveDir = -self.moveDir
            self.moveTimer = 0
        end
    end
    if self.t == 1 then
        self.shootTimer = self.shootTimer + 30*dt
        if self.shootTimer >= 30 then
            spawn_martianbullet(self.x+8,self.y+16,0)
            spawn_martianbullet(self.x+8,self.y+16,1)
            self.shootTimer = 0
        end
    end
    if self.t == 2 then
        self.shootTimer = self.shootTimer + 30*dt
        if self.shootTimer >= 30 then
            spawn_martianbullet(self.x+8,self.y+16,0)
            spawn_martianbullet(self.x+8,self.y+16,1)
            spawn_martianbullet(self.x+8,self.y+16,2)
            spawn_martianbullet(self.x+8,self.y+16,3)
            self.shootTimer = 0
        end
    end
    if self.t == 3 then
        self.shootTimer = self.shootTimer + 30*dt
        if self.shootTimer >= 30 then
            spawn_martianbullet(self.x,self.y+16,0)
            spawn_martianbullet(self.x,self.y+16,1)
            spawn_martianbullet(self.x+8,self.y+16,2)
            spawn_martianbullet(self.x+8,self.y+16,3)
            self.shootTimer = 0
        end
    end
    if self.t == 4 then
        self.shootTimer = self.shootTimer + 30*dt
        if self.shootTimer >= 30 then
            spawn_martianbullet(self.x,self.y+16,0)
            spawn_martianbullet(self.x,self.y+16,1)
            spawn_martianbullet(self.x+8,self.y+16,2)
            spawn_martianbullet(self.x+8,self.y+16,3)
            self.shootTimer = 0
        end
    end
end

function draw_martians()
	for martian in all(martians) do
		draw_martian(martian)
	end
end

function draw_martian(self)
    love.graphics.draw(martianGraphics[self.t], self.x - offset_x - firstTile_x * 32, self.y - offset_y - firstTile_y * 32)
end

function draw_martian_collider(self)
    love.graphics.setColor( 1, 0, 0, 1 )
    if self.t < 4 then
	    love.graphics.rectangle("fill", self.x - offset_x - firstTile_x * 32, self.y - offset_y - firstTile_y * 32, 50, 50)
    end
    if self.t == 4 then
        love.graphics.rectangle("fill", self.x - offset_x - firstTile_x * 32, self.y - offset_y - firstTile_y * 32, 200, 300)
    end
end

function spawn_martianbullet(x,y,d)
    local mb = {}
	mb.x = x
	mb.y = y
	mb.d = d
    mb.xs = 0
    mb.ys = 0
    mb.timer = 0
    mb.animFrame = 0
	add(martianbullets, mb)
end

function update_martianbullets(dt)
    for mb in all(martianbullets) do
        update_martianbullet(mb, dt)
    end
end

function update_martianbullet(self, dt)
    if self.d == 0 then
        self.xs = -2.5*(dt*60)
    end
    if self.d == 1 then
        self.xs = 2.5*(dt*60)
    end
    if self.d == 2 then
        self.ys = -2.5*(dt*60)
    end
    if self.d == 3 then
        self.ys = 2.5*(dt*60)
    end
    self.x = self.x + self.xs
    self.y = self.y + self.ys
    self.timer = self.timer + 30*dt
    self.animFrame = self.animFrame + 30*dt
    if self.timer >= 50 then
        del(martianbullets, self)
    end
end

function draw_martianbullets()
    for mb in all(martianbullets) do
        draw_martianbullet(mb)
    end
end

function draw_martianbullet(self)
    if self.animFrame >= 2 then
        self.animFrame = 0
    end
    love.graphics.draw(martianBulletGraphics[math.floor(self.animFrame)], self.x - offset_x - firstTile_x * 32, -8 + self.y - offset_y - firstTile_y * 32)
end

function draw_martianbullet_collider(self)
    love.graphics.setColor( 1, 0, 0, 1 )
	love.graphics.rectangle("fill", self.x - offset_x - firstTile_x * 32, self.y - offset_y - firstTile_y * 32, 32, 16)
end