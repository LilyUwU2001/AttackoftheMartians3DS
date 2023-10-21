function check_collision(x1,y1,w1,h1, x2,y2,w2,h2)
	return x1 < x2+w2 and
		   x2 < x1+w1 and
		   y1 < y2+h2 and
		   y2 < y1+h1
end

function spawn_colliders()
	for y=1, map_h do
		for x=1, map_w do                                                         
			if map[y][x] ~= 0 and map[y][x] ~= 15 and map[y][x] ~= 16 and map[y][x] ~= 17 then
				spawn_collider(x*32-48, y*32-48, 32, 32)
			end
            if map[y][x] == 15 or map[y][x] == 16 or map[y][x] == 17 then
				spawn_collider(x*32-48, y*32-48, 32, 12)
			end
		end
	 end
end

function spawn_collider(x,y,w,h)
    local c = {}
	c.x = x
	c.y = y
	c.w = w
    c.h = h
	add(colliders, c)
end

function draw_colliders()
    for collider in all(colliders) do
        draw_collider(collider)
    end
end

function draw_sprite_colliders()
    for player in all(players) do
        draw_player_collider(player)
    end
    for martian in all(martians) do
        draw_martian_collider(martian)
    end
    for mb in all(martianbullets) do
        draw_martianbullet_collider(mb)
    end
    for pb in all(playerbullets) do
        draw_playerbullet_collider(pb)
    end
    for powerup in all(powerups) do
        draw_powerup_collider(powerup)
    end
end

function draw_collider(self)
    love.graphics.setColor( 1, 1, 1, 1 )
	love.graphics.rectangle("fill", self.x - offset_x - firstTile_x * 32, self.y - offset_y - firstTile_y * 32, self.w, self.h)
end

function check_terrain_collisions(playerObject, xspeed, yspeed)
    local collidingTerrain = 0
    for collider in all(colliders) do
        if check_collision(playerObject.x+xspeed, playerObject.y+yspeed, 25, 90, collider.x, collider.y, collider.w, collider.h) then
            collidingTerrain = 1
        end
    end
    return collidingTerrain
end

function check_all_collisions(dt)
    check_pb_martian_collisions(dt)
    check_mb_player_collisions(dt)
    check_powerup_player_collisions(dt)
    check_martian_player_collisions(dt)
end

function check_pb_martian_collisions(dt)
    for p in all(players) do
        for pb in all(playerbullets) do
            for martian in all(martians) do
                if martian.t ~= 4 then
                    if check_collision(pb.x, pb.y, 8, 8, martian.x, martian.y, 50, 50) then
                        martian.isDead = 1
                        p.shootTimer = 100
                        del(playerbullets, pb)
                    end
                end
                if martian.t == 4 then
                    if check_collision(pb.x, pb.y, 8, 8, martian.x, martian.y, 200, 300) then
                        martian.isDead = 1
                        p.shootTimer = 100
                        del(playerbullets, pb)
                    end
                end
            end
        end
    end
end

function check_mb_player_collisions(dt)
    for p in all(players) do
        for mb in all(martianbullets) do
            if check_collision(mb.x, mb.y, 32, 16, p.x, p.y, 25, 90) then
                health = health - 50*dt
                hit_sound = hit_sound + 1
                if hit_sound >= 5 then
                    TEsound.play(snd_hit, "sfx")
                    hit_sound = 0
                end
            end
        end
    end
end

function check_martian_player_collisions(dt)
    for p in all(players) do
        for m in all(martians) do
            if check_collision(m.x, m.y, 50, 50, p.x, p.y, 25, 90) then
                if m.t == 0 then
                    health = health - 25*dt
                    hit_sound = hit_sound + 1
                    if hit_sound >= 5 then
                        TEsound.play(snd_hit, "sfx")
                        hit_sound = 0
                    end
                end
            end
        end
    end
end


function check_powerup_player_collisions(dt)
    for p in all(players) do
        for pu in all(powerups) do
            if check_collision(pu.x, pu.y, pu.w, pu.h, p.x, p.y, 25, 90) then
                if pu.t == 0 then
                    health = 100
                    TEsound.play(snd_apteczka, "sfx")
                    del(powerups, pu)
                end
                if pu.t == 1 then
                    lives = lives + 1
                    TEsound.play(snd_zycie, "sfx")
                    del(powerups, pu)
                end
                if pu.t == 2 or pu.t == 3 then
                    health = health - 25*dt
                    hit_sound = hit_sound + 1
                    if hit_sound >= 5 then
                        TEsound.play(snd_hit, "sfx")
                        hit_sound = 0
                    end
                end
                if pu.t >= 4 then
                    stagenum = stagenum + 1
                    reinit_stages()
                    initialize_stage()
                end
            end
        end
    end
end