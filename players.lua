function spawn_players()
	for y=1, map_h do
		for x=1, map_w do                                                         
			if map[y][x] == 26 then
				spawn_player(x*32-32, y*32-108, 0)
				map[y][x] = 0
			end
		end
	 end
end

function spawn_player(x,y)
	local p = {}
	p.x = x
	p.y = y
    p.dj = 2
    p.jump = 0
    p.shootTimer = 100
    p.animFrame = 0
    p.moveDir = 1
    p.speed = 0
    p.moveLeft = 0
    p.moveRight = 0
    p.jumpKey = 0
    p.shootKey = 0
	add(players, p)
    target_map_x = p.x - 175
    target_map_y = p.y - 60
    map_x = target_map_x
    map_y = target_map_y
end

function update_players(dt)
	for player in all(players) do
		update_player(player, dt)
	end
end

function update_player(self, dt)
    -- check for out of bounds
    if self.x < -16 then self.x = -16 end
    if self.x+60 > map_w * 32 then self.x = map_w * 32 - 60 end
    if self.y < -16 then self.y = -16 end
    if self.y+90 > map_h * 32 + 90 then 
        health = 100
        lives = lives - 1
        TEsound.play(snd_death, "sfx")
        reinit_stages()
        initialize_stage()
    end

    self.speed = (5*60*dt)/2
    self.shootTimer = self.shootTimer + 30*dt
    -- 3DS
    --self.moveLeft = Joystick:isGamepadDown( "dpleft" ) or leftAnalog_x < -0.5
    --self.moveRight = Joystick:isGamepadDown( "dpright" ) or leftAnalog_x > 0.5
    -- PC
	self.moveLeft = Joystick:isGamepadDown( "dpleft" ) or leftAnalog_x < -0.5 or love.keyboard.isDown("left")
    self.moveRight = Joystick:isGamepadDown( "dpright" ) or leftAnalog_x > 0.5  or love.keyboard.isDown("right")

    if self.moveLeft then
        if check_terrain_collisions(self, -self.speed, 0) == 0 then
		    self.x = self.x - self.speed
            self.animFrame = self.animFrame + 10*dt
            self.moveDir = -1
        end
    end
    if self.moveRight then
        if check_terrain_collisions(self, self.speed, 0) == 0 then
		    self.x = self.x + self.speed
            self.animFrame = self.animFrame + 10*dt
            self.moveDir = 1
        end
    end
    if self.jump <= 0 then
        if check_terrain_collisions(self, 0, self.speed) == 0 then
		    self.y = self.y + self.speed
            self.jump = self.jump - self.speed
        else
            self.dj = 2
        end
	end
    if self.jump > 0 then
        if check_terrain_collisions(self, 0, -self.speed) == 0 then
		    self.y = self.y - self.speed
            self.jump = self.jump - self.speed
        else
            self.jump = 0
        end
	end
    if bKey == 1 then
        if self.dj > 0 then
            self.jump = 150
            self.dj = self.dj - 1
        end
        bKey = 0
    end
    if aKey == 1 then
        if self.shootTimer >= 100 then
            spawn_playerbullet(self.x+10, self.y+45, self.moveDir)
            self.shootTimer = 0
        end
        aKey = 0
    end
    if health <= 0 then
        health = 100
        lives = lives - 1
        TEsound.play(snd_death, "sfx")
    end
end

function draw_players()
	for player in all(players) do
		draw_player(player)
	end
end

function draw_player(self)
    if self.animFrame >= 3 then
        self.animFrame = 0
    end
    love.graphics.draw(playerGraphics[math.floor(self.animFrame)], -12*self.moveDir + 12 + self.x - offset_x - firstTile_x * 32, self.y - offset_y - firstTile_y * 32, 0, self.moveDir, 1)
    --love.graphics.print(gam_label, 16, 32)
end

function draw_player_collider(self)
    love.graphics.setColor( 0, 1, 0, 1 )
	love.graphics.rectangle("fill", self.x - offset_x - firstTile_x * 32, self.y - offset_y - firstTile_y * 32, 25, 90)
end

function spawn_playerbullet(x,y,d)
    local pb = {}
	pb.x = x
	pb.y = y
	pb.d = d
    pb.xs = 0
    pb.timer = 0
	add(playerbullets, pb)
end

function update_playerbullets(dt)
    for pb in all(playerbullets) do
        update_playerbullet(pb, dt)
    end
end

function update_playerbullet(self, dt)
    if self.d == -1 then
        self.xs = -5*(dt*60)
    end
    if self.d == 1 then
        self.xs = 5*(dt*60)
    end
    self.x = self.x + self.xs
    self.timer = self.timer + 30*dt
    if self.timer >= 50 then
        del(playerbullets, self)
    end
end

function draw_playerbullets()
    for pb in all(playerbullets) do
        draw_playerbullet(pb)
    end
end

function draw_playerbullet(self)
    love.graphics.draw(playerBullet, self.x - offset_x - firstTile_x * 32, self.y - offset_y - firstTile_y * 32)
end

function draw_playerbullet_collider(self)
    love.graphics.setColor( 0, 1, 0, 1 )
	love.graphics.rectangle("fill", self.x - offset_x - firstTile_x * 32, self.y - offset_y - firstTile_y * 32, 8, 8)
end