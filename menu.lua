-- this handles both the main & game over menus

function initialize_menu()
    tapx = 0
    tapy = 0
    if music1:isPlaying() == true then
        music1:stop()
    end
    if music2:isPlaying() == true then
        music2:stop()
    end
    if music3:isPlaying() == true then
        music3:stop()
    end
    if music4:isPlaying() == true then
        music4:stop()
    end
    if music_ending:isPlaying() == true then
        music_ending:stop()
    end
    if music_gover:isPlaying() == true then
        music_gover:stop()
    end
    if music_title:isPlaying() == false then
        music_title:setLooping(true)
        music_title:play()
    end
end

function initialize_gover()
    tapx = 0
    tapy = 0
    if music1:isPlaying() == true then
        music1:stop()
    end
    if music2:isPlaying() == true then
        music2:stop()
    end
    if music3:isPlaying() == true then
        music3:stop()
    end
    if music4:isPlaying() == true then
        music4:stop()
    end
    if music_ending:isPlaying() == true then
        music_ending:stop()
    end
    if music_gover:isPlaying() == true then
        music_gover:stop()
    end
    if music_title:isPlaying() == true then
        music_title:stop()
    end
    if music_gover:isPlaying() == false then
        music_gover:setLooping(true)
        music_gover:play()
    end
end

function initialize_game()
    score = 0
	lives = 10
	health = 100
    new_stagenum = 1
    load_stage_after_trans()
end

function initialize_game_continue()
    score = 0
	lives = 10
	health = 100
    new_stagenum = stagenum
    load_stage_after_trans()
end

function update_menu(dt)
    -- check for button tap
    if tapx >= 20 and tapx <= 300 then
        if tapy >= 40 and tapy <= 100 then
            TEsound.play(snd_select, "sfx")
            start_trans()
            game_state = STATE_MENUTOGAME
        end
        if tapy >= 120 and tapy <= 180 then
            TEsound.play(snd_select, "sfx")
            start_trans()
            game_state = STATE_MENUTOEXIT
        end
    end
end

function update_gover(dt)
    -- check for button tap
    if tapx >= 20 and tapx <= 300 then
        if tapy >= 40 and tapy <= 100 then
            TEsound.play(snd_select, "sfx")
            continue = 1
            start_trans()
            game_state = STATE_GOVERTOGAME
        end
        if tapy >= 120 and tapy <= 180 then
            TEsound.play(snd_select, "sfx")
            continue = 0
            start_trans()
            game_state = STATE_GOVERTOMENU
        end
    end
end

function draw_menu_top()
    -- draw bg & logo
    love.graphics.setColor( 0.75, 0.75, 0.75, 1 )
	love.graphics.rectangle("fill", 0,0, 400,240)
	love.graphics.setColor( 1, 1, 1, 1 )
    love.graphics.draw(amlogo, 48, 72)
end

function draw_menu_bottom()
    -- draw bg
    love.graphics.setColor( 0.75, 0.75, 0.75, 1 )
	love.graphics.rectangle("fill", 0,0, 320,240)
	love.graphics.setColor( 1, 1, 1, 1 )
    -- draw buttons
    love.graphics.draw(menuNewGameBtn, 20, 40)
    love.graphics.draw(menuExitBtn, 20, 120)
    -- draw copyright texts
    love.graphics.setColor( 0.0, 0.0, 0.0, 1 )
    love.graphics.setFont(font)
    love.graphics.printf( "© 2011-2023 Extremely Awesome Games", 0, 200, 320, "center")
    love.graphics.printf( "Not licensed by Nintendo.", 0, 216, 320, "center")
    love.graphics.setColor( 1, 1, 1, 1 )
end

function draw_gover_top()
    -- draw bg & logo
    love.graphics.setColor( 0.0, 0.0, 0.0, 1 )
	love.graphics.rectangle("fill", 0,0, 400,240)
	love.graphics.setColor( 1, 1, 1, 1 )
    love.graphics.draw(gameover, 48, 72)
end

function draw_gover_bottom()
    -- draw bg
    love.graphics.setColor( 0.0, 0.0, 0.0, 1 )
	love.graphics.rectangle("fill", 0,0, 320,240)
	love.graphics.setColor( 1, 1, 1, 1 )
    -- draw buttons
    love.graphics.draw(menuContinueBtn, 20, 40)
    love.graphics.draw(menuEndGameBtn, 20, 120)
end