function draw_game_top()
	draw_bg()
	draw_map()
	draw_decors()
	draw_martians()
	draw_martianbullets()
	draw_players()
	draw_playerbullets()
	draw_powerups()
	if DEBUG_FLAG == 1 then
	draw_colliders()
	draw_sprite_colliders()
	end
end

function draw_game_bottom()
	draw_uibg()
	draw_score()
	draw_lives()
	draw_healthbar()
	draw_mappos()
	draw_logo()
end