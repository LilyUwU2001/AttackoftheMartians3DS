--require('nest'):init({mode = "ctr", scale = 1, emulateJoystick = true})
require('pico8')
require('tesound')
require('input')

require('stagesystem')
require('statesystem')
require('trans_general')
require('changelvl_state')

require('map')
require('decors')
require('martians')
require('players')
require('powerups')
require('ui')

require('collision')

require('menu')
require('ending')
require('pause')

require('drawgame')

function love.load()
	-- debug flag
	DEBUG_FLAG = 0

	-- gamepads
	joysticks = love.joystick.getJoysticks()
    Joystick = joysticks[1]

	-- our tiles
	tile = {}
	for i=0,41 do -- change 3 to the number of tile images minus 1.
		tile[i] = love.graphics.newImage( "graphics/tile"..i..".png" )
	end
	
	reinit_stages()

	-- font
	font = love.graphics.newFont( "graphics/arial.ttf", 16)

	-- extra life icon
	lifeicon = love.graphics.newImage("graphics/life.png")

	-- map graphics
	maphead = love.graphics.newImage("graphics/maphead.png")
	mapmedkit = love.graphics.newImage("graphics/mapmedkit.png")
	map1up = love.graphics.newImage("graphics/map1up.png")
	mapsign = love.graphics.newImage("graphics/mapsign.png")
	mapportal = love.graphics.newImage("graphics/mapportal.png")
	mapsmoke = love.graphics.newImage("graphics/mapsmoke.png")
	maprocket = love.graphics.newImage("graphics/maprocket.png")
	mapfinalboss = love.graphics.newImage("graphics/mapfinalboss.png")

	-- Atak Marsjanów logo
	amlogo = love.graphics.newImage("graphics/amlogo.png")
	gameover = love.graphics.newImage("graphics/gameover.png")

	-- Martian graphics
	martianGraphics = {}
	martianGraphics[0] = love.graphics.newImage("graphics/martianGreen.png")
	martianGraphics[1] = love.graphics.newImage("graphics/martianPink.png")
	martianGraphics[2] = love.graphics.newImage("graphics/martianBlue.png")
	martianGraphics[3] = love.graphics.newImage("graphics/martianRed.png")
	martianGraphics[4] = love.graphics.newImage("graphics/finalboss.png")

	-- Martian bullet graphics
	martianBulletGraphics = {}
	martianBulletGraphics[0] = love.graphics.newImage("graphics/martianBulletF0.png")
	martianBulletGraphics[1] = love.graphics.newImage("graphics/martianBulletF1.png")

	-- Player graphics
	playerGraphics = {}
	playerGraphics[0] = love.graphics.newImage("graphics/playerF0.png")
	playerGraphics[1] = love.graphics.newImage("graphics/playerF1.png")
	playerGraphics[2] = love.graphics.newImage("graphics/playerF2.png")

	-- Player bullet graphics
	playerBullet = love.graphics.newImage("graphics/playerBullet.png")

	-- Powerup graphics
	powerupGraphics = {}
	powerupGraphics[0] = love.graphics.newImage("graphics/tile27.png")
	powerupGraphics[1] = love.graphics.newImage("graphics/tile28.png")
	powerupGraphics[2] = love.graphics.newImage("graphics/tile29.png")
	powerupGraphics[3] = love.graphics.newImage("graphics/tile30.png")
	powerupGraphics[4] = love.graphics.newImage("graphics/sign_stage1.png")
	powerupGraphics[5] = love.graphics.newImage("graphics/sign_stage2.png")
	powerupGraphics[6] = love.graphics.newImage("graphics/sign_stage3.png")
	powerupGraphics[7] = love.graphics.newImage("graphics/sign_stage4.png")
	powerupGraphics[8] = love.graphics.newImage("graphics/sign_stage7.png")
	powerupGraphics[9] = love.graphics.newImage("graphics/sign_stage8.png")

	-- Ending graphics
	endingBase = love.graphics.newImage("graphics/ending_base.png")
	endingCredits = love.graphics.newImage("graphics/ending_credits.png")

	-- Menu graphics
	menuNewGameBtn = love.graphics.newImage("graphics/new_game.png")
	menuExitBtn = love.graphics.newImage("graphics/exit.png")
	menuContinueBtn = love.graphics.newImage("graphics/continue.png")
	menuEndGameBtn = love.graphics.newImage("graphics/endgame.png")
	
	-- Assorted sounds
	snd_marsDeath = love.sound.newSoundData("sound/marsdeath.wav")
	snd_tarcza = love.sound.newSoundData("sound/tarcza.wav")
	snd_hit = love.sound.newSoundData("sound/hit.wav")
	snd_death = love.sound.newSoundData("sound/death.wav")
	snd_apteczka = love.sound.newSoundData("sound/apteczka.wav")
	snd_zycie = love.sound.newSoundData("sound/zycie.wav")
	snd_select = love.sound.newSoundData("sound/select.wav")
	snd_konamipause = love.sound.newSoundData("sound/konamipause.wav")

	-- current stage variable
	stagenum = 1
		
	-- universal map variables
	map_display_w = 13
	map_display_h = 8
	tile_w = 32
	tile_h = 32

	-- last tap
	tapx = 0
	tapy = 0

	-- is continuing?
	continue = 0

	-- sound variables
	hit_sound = 4 -- variable for hit sound loop

	-- all music
	music1 = love.audio.newSource("music/music1.ogg", "stream") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
	music2 = love.audio.newSource("music/music2.ogg", "stream") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
	music3 = love.audio.newSource("music/music3.ogg", "stream") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
	music4 = love.audio.newSource("music/music4.ogg", "stream") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
	music_ending = love.audio.newSource("music/music_ending.ogg", "stream") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
	music_title = love.audio.newSource("music/music_title.ogg", "stream") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
	music_gover = love.audio.newSource("music/music_gover.ogg", "stream") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
	
	-- player data
	score = 0
	lives = 10
	health = 100

	-- debug gamepad & joystick labels
	gam_label = ""
	joy_label = ""

	-- various inputs
	upKey = 0
	downKey = 0
	leftKey = 0
	rightKey = 0
	aKey = 0
	bKey = 0
	xKey = 0
	yKey = 0
	selectKey = 0
	startKey = 0
	leftShoulderKey = 0
	rightShoulderKey = 0

	-- transition variables
	trans_val = 0
	trans_direction = 0

	-- current game state variable
	game_state = STATE_MENU

	initialize_menu()
	--initialize_stage()
	--initialize_ending()
end

function love.update(dt)
	TEsound.cleanup()
	if game_state == STATE_GAME then
		scroll_map(dt)
		update_martians(dt)
		update_martianbullets(dt)
		update_players(dt)
		update_playerbullets(dt)
		check_all_collisions(dt)
		check_gameover()
	end
	if game_state == STATE_CHANGELVL then
		scroll_map(dt)
		if trans_direction == 0 then
			update_trans(dt, STATE_DETRANS_STUB)
		end
		if trans_direction == 1 then
			update_trans(dt, STATE_GAME)
		end
	end
	if game_state == STATE_TRANS_STUB then
		start_trans()
		game_state = stub_prev_state
	end
	if game_state == STATE_DETRANS_STUB then
		start_detrans()
		if stub_prev_state == STATE_CHANGELVL then
			load_stage_after_trans()
		end
		if stub_prev_state == STATE_MENUTOGAME then
			load_stage_after_trans()
		end
		if stub_prev_state == STATE_ENDTOCRE then
			ending_bg = endingCredits
		end
		if stub_prev_state == STATE_GAMETOEND then
			initialize_ending()
		end
		if stub_prev_state == STATE_MENUTOEXIT then
			love.event.quit() 
		end
		if stub_prev_state == STATE_MENUTOGAME then
			initialize_game()
		end
		if stub_prev_state == STATE_GAMETOGOVER then
			initialize_gover()
		end
		if stub_prev_state == STATE_GOVERTOGAME then
			initialize_game_continue()
		end
		if stub_prev_state == STATE_GOVERTOMENU then
			initialize_menu()
		end
		if stub_prev_state == STATE_ENDINGTOMENU then
			initialize_menu()
		end
		game_state = stub_prev_state
	end
	if game_state == STATE_ENDING then
		update_ending(dt)
	end
	if game_state == STATE_ENDTOCRE then
		if trans_direction == 0 then
			update_trans(dt, STATE_DETRANS_STUB)
		end
		if trans_direction == 1 then
			update_trans(dt, STATE_ENDING)
		end
	end
	if game_state == STATE_CREDITS then
		update_ending(dt)
	end
	if game_state == STATE_GAMETOEND then
		scroll_map(dt)
		if trans_direction == 0 then
			update_trans(dt, STATE_DETRANS_STUB)
		end
		if trans_direction == 1 then
			update_trans(dt, STATE_ENDING)
		end
	end
	if game_state == STATE_MENU then
		update_menu()
	end
	if game_state == STATE_MENUTOGAME then
		if trans_direction == 0 then
			update_trans(dt, STATE_DETRANS_STUB)
		end
		if trans_direction == 1 then
			update_trans(dt, STATE_GAME)
			scroll_map(dt)
		end
	end
	if game_state == STATE_MENUTOEXIT then
		if trans_direction == 0 then
			update_trans(dt, STATE_DETRANS_STUB)
		end
	end
	if game_state == STATE_GOVER then
		update_gover()
	end
	if game_state == STATE_GAMETOGOVER then
		if trans_direction == 0 then
			scroll_map(dt)
			update_trans(dt, STATE_DETRANS_STUB)
		end
		if trans_direction == 1 then
			update_trans(dt, STATE_GOVER)
		end
	end
	if game_state == STATE_GOVERTOGAME then
		if trans_direction == 0 then
			update_trans(dt, STATE_DETRANS_STUB)
		end
		if trans_direction == 1 then
			update_trans(dt, STATE_GAME)
			scroll_map(dt)
		end
	end
	if game_state == STATE_GOVERTOMENU then
		if trans_direction == 0 then
			update_trans(dt, STATE_DETRANS_STUB)
		end
		if trans_direction == 1 then
			update_trans(dt, STATE_MENU)
		end
	end
	if game_state == STATE_ENDINGTOMENU then
		if trans_direction == 0 then
			update_trans(dt, STATE_DETRANS_STUB)
		end
		if trans_direction == 1 then
			update_trans(dt, STATE_MENU)
		end
	end
	if game_state == STATE_PAUSED then
		update_pause(dt)
	end
end

function love.touchpressed(id, x, y, dx, dy, pressure)
	tapx = x
	tapy = y
 end

function love.draw(screen)
	if game_state == STATE_GAME then
		if screen == "left" then
			draw_game_top()
		end
		if screen == "bottom" then
			draw_game_bottom()
		end
	end
	if game_state == STATE_CHANGELVL then
		if screen == "left" then
			draw_game_top()
			draw_trans_top()
		end
		if screen == "bottom" then
			draw_game_bottom()
		end
	end
	if game_state == STATE_ENDING then
		if screen == "left" then
			draw_ending()
		end
		if screen == "bottom" then
			draw_blackness()
			draw_credits()
		end
	end
	if game_state == STATE_ENDTOCRE then
		if screen == "left" then
			draw_ending()
			draw_trans_top()
		end
		if screen == "bottom" then
			draw_blackness()
		end
	end
	if game_state == STATE_GAMETOEND then
		if trans_direction == 0 then
			if screen == "left" then
				draw_game_top()
				draw_trans_top()
			end
			if screen == "bottom" then
				draw_game_bottom()
				draw_trans_bottom()
			end
		end
		if trans_direction == 1 then
			if screen == "left" then
				draw_ending()
				draw_trans_top()
			end
			if screen == "bottom" then
				draw_blackness()
				draw_credits()
			end
		end
	end
	if game_state == STATE_MENU then
		if screen == "left" then
			draw_menu_top()
		end
		if screen == "bottom" then
			draw_menu_bottom()
		end
	end
	if game_state == STATE_MENUTOGAME then
		if trans_direction == 0 then
			if screen == "left" then
				draw_menu_top()
				draw_trans_top()
			end
			if screen == "bottom" then
				draw_menu_bottom()
				draw_trans_bottom()
			end
		end
		if trans_direction == 1 then
			if screen == "left" then
				draw_game_top()
				draw_trans_top()
			end
			if screen == "bottom" then
				draw_game_bottom()
				draw_trans_bottom()
			end
		end
	end
	if game_state == STATE_MENUTOEXIT then
		if screen == "left" then
			draw_menu_top()
			draw_trans_top()
		end
		if screen == "bottom" then
			draw_menu_bottom()
			draw_trans_bottom()
		end
	end
	if game_state == STATE_GOVER then
		if screen == "left" then
			draw_gover_top()
		end
		if screen == "bottom" then
			draw_gover_bottom()
		end
	end
	if game_state == STATE_GAMETOGOVER then
		if trans_direction == 0 then
			if screen == "left" then
				draw_game_top()
				draw_trans_top()
			end
			if screen == "bottom" then
				draw_game_bottom()
				draw_trans_bottom()
			end
		end
		if trans_direction == 1 then
			if screen == "left" then
				draw_gover_top()
				draw_trans_top()
			end
			if screen == "bottom" then
				draw_gover_bottom()
				draw_trans_bottom()
			end
		end
	end
	if game_state == STATE_GOVERTOGAME then
		if trans_direction == 0 then
			if screen == "left" then
				draw_gover_top()
				draw_trans_top()
			end
			if screen == "bottom" then
				draw_gover_bottom()
				draw_trans_bottom()
			end
		end
		if trans_direction == 1 then
			if screen == "left" then
				draw_game_top()
				draw_trans_top()
			end
			if screen == "bottom" then
				draw_game_bottom()
				draw_trans_bottom()
			end
		end
	end
	if game_state == STATE_GOVERTOMENU then
		if trans_direction == 0 then
			if screen == "left" then
				draw_gover_top()
				draw_trans_top()
			end
			if screen == "bottom" then
				draw_gover_bottom()
				draw_trans_bottom()
			end
		end
		if trans_direction == 1 then
			if screen == "left" then
				draw_menu_top()
				draw_trans_top()
			end
			if screen == "bottom" then
				draw_menu_bottom()
				draw_trans_bottom()
			end
		end
	end
	if game_state == STATE_ENDINGTOMENU then
		if trans_direction == 0 then
			if screen == "left" then
				draw_ending()
				draw_trans_top()
			end
			if screen == "bottom" then
				draw_blackness()
				draw_trans_bottom()
			end
		end
		if trans_direction == 1 then
			if screen == "left" then
				draw_menu_top()
				draw_trans_top()
			end
			if screen == "bottom" then
				draw_menu_bottom()
				draw_trans_bottom()
			end
		end
	end
	if game_state == STATE_PAUSED then
		if screen == "left" then
			draw_game_top()
			draw_pause_top()
		end
		if screen == "bottom" then
			draw_game_bottom()
			draw_pause_bottom()
		end
	end
end
