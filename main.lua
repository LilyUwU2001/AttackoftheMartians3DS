--require('nest'):init({mode = "ctr", scale = 1, emulateJoystick = true})
require('pico8')
require('TEsound')
require('input')

require('stagesystem')

require('map')
require('decors')
require('martians')
require('players')
require('powerups')
require('ui')

require('collision')

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

	-- Assorted sounds
	snd_marsDeath = love.sound.newSoundData("sound/marsdeath.wav")
	snd_tarcza = love.sound.newSoundData("sound/tarcza.wav")
	snd_hit = love.sound.newSoundData("sound/hit.wav")
	snd_death = love.sound.newSoundData("sound/death.wav")
	snd_apteczka = love.sound.newSoundData("sound/apteczka.wav")
	snd_zycie = love.sound.newSoundData("sound/zycie.wav")

	-- current stage variable
	stagenum = 1
		
	-- universal map variables
	map_display_w = 13
	map_display_h = 8
	tile_w = 32
	tile_h = 32

	-- sound variables
	hit_sound = 4 -- variable for hit sound loop

	-- all music
	music1 = love.audio.newSource("music/music1.ogg", "stream") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
	music2 = love.audio.newSource("music/music2.ogg", "stream") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
	music3 = love.audio.newSource("music/music3.ogg", "stream") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
	music4 = love.audio.newSource("music/music4.ogg", "stream") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks

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

	initialize_stage()
end

function love.update(dt)
	TEsound.cleanup()
	scroll_map(dt)
	update_martians(dt)
	update_martianbullets(dt)
	update_players(dt)
	update_playerbullets(dt)
	check_all_collisions(dt)
end

function love.draw(screen)
	if screen == "left" then
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
	if screen == "bottom" then
		draw_uibg()
		draw_score()
		draw_lives()
		draw_healthbar()
		draw_mappos()
		draw_logo()
	end
end