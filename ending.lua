ending_rocket_y = 256
ending_bg = endingBase

function initialize_ending()
    ending_bg = endingBase
    ending_rocket_y = 256
    if music4:isPlaying() == true then
        music4:stop()
    end
    if music_ending:isPlaying() == false then
        music_ending:setLooping(true)
        music_ending:play()
    end
end

function update_ending(dt)
    -- change rocket position... used also for staff roll as a hack
    if ending_bg == endingBase then
        ending_rocket_y = ending_rocket_y - 96*dt
    end
    if ending_bg == endingCredits then
        ending_rocket_y = ending_rocket_y - 24*dt
    end
    
    -- change into credits when the rocket leaves the screen
    if ending_rocket_y <= -512 and ending_bg == endingBase then
        start_trans()
        game_state = STATE_ENDTOCRE
    end

    -- end the ending when credits scroll
    if ending_rocket_y <= -1600 and ending_bg == endingCredits then
        start_trans()
        game_state = STATE_ENDINGTOMENU
    end
end

function draw_ending()
    love.graphics.draw(ending_bg, 0, 0)
    if ending_rocket_y > -112 then
        love.graphics.draw(powerupGraphics[9], 32, -112)
    end
    if ending_rocket_y <= -112 then
        love.graphics.draw(powerupGraphics[9], 32, ending_rocket_y)
    end
end

function draw_blackness()
    love.graphics.setColor( 0, 0, 0, 1 )
	love.graphics.rectangle("fill", 0,0, 320,240)
	love.graphics.setColor( 1, 1, 1, 1 )
end

function draw_credits()
    love.graphics.setColor( 1, 1, 1, 1 )
    love.graphics.setFont(font)
    -- name
    love.graphics.printf( "-------------------------", 0, ending_rocket_y+768, 320, "center")
    love.graphics.printf( "-------------------------", 1, ending_rocket_y+768, 320, "center")
    love.graphics.printf( "-------------------------", -1, ending_rocket_y+768, 320, "center")
    love.graphics.printf( "-------------------------", 2, ending_rocket_y+768, 320, "center")
    love.graphics.printf( "-------------------------", -2, ending_rocket_y+768, 320, "center")
    love.graphics.printf( "AOTM Remastered", 0, ending_rocket_y+768+16, 320, "center")
    love.graphics.printf( "AOTM Remastered", 1, ending_rocket_y+768+16, 320, "center")
    love.graphics.printf( "a game by", 0, ending_rocket_y+768+48, 320, "center")
    love.graphics.printf( "LilyUwU2001", 0, ending_rocket_y+768+80, 320, "center")
    love.graphics.printf( "LilyUwU2001", 1, ending_rocket_y+768+80, 320, "center")
    love.graphics.printf( "and", 0, ending_rocket_y+768+96, 320, "center")
    love.graphics.printf( "Sharkingv2", 0, ending_rocket_y+768+112, 320, "center")
    love.graphics.printf( "Sharkingv2", 1, ending_rocket_y+768+112, 320, "center")
    love.graphics.printf( "-------------------------", 0, ending_rocket_y+768+128, 320, "center")
    love.graphics.printf( "-------------------------", -1, ending_rocket_y+768+128, 320, "center")
    love.graphics.printf( "-------------------------", 1, ending_rocket_y+768+128, 320, "center")
    love.graphics.printf( "-------------------------", -2, ending_rocket_y+768+128, 320, "center")
    love.graphics.printf( "-------------------------", 2, ending_rocket_y+768+128, 320, "center")
    
    -- art design
    love.graphics.printf( "Art & graphic design", 0, ending_rocket_y+768+160, 320, "center")
    love.graphics.printf( "Art & graphic design", 1, ending_rocket_y+768+160, 320, "center")
    love.graphics.printf( "LilyUwU2001", 0, ending_rocket_y+768+176, 320, "center")
    love.graphics.printf( "Sharkingv2", 0, ending_rocket_y+768+192, 320, "center")

    -- music
    love.graphics.printf( "Music", 0, ending_rocket_y+768+224, 320, "center")
    love.graphics.printf( "Music", 1, ending_rocket_y+768+224, 320, "center")
    love.graphics.printf( "Metallica - Seek & Destroy", 0, ending_rocket_y+768+240, 320, "center")
    love.graphics.printf( "Caltron 6-in-1 - Bookyman", 0, ending_rocket_y+768+256, 320, "center")
    love.graphics.printf( "Metallica - For Whom the Bell Tolls", 0, ending_rocket_y+768+272, 320, "center")
    love.graphics.printf( "Gustav Holst - Mars, the Bringer of War", 0, ending_rocket_y+768+288, 320, "center")
    love.graphics.printf( "WarioWare: Mega Party Game$! - Kat & Ana", 0, ending_rocket_y+768+304, 320, "center")
    love.graphics.printf( "Star Wars - Cantina Band Theme", 0, ending_rocket_y+768+320, 320, "center")
    love.graphics.printf( "ABC - Murder One Theme", 0, ending_rocket_y+768+336, 320, "center")
    
    -- game design
    love.graphics.printf( "Game design & programming", 0, ending_rocket_y+768+368, 320, "center")
    love.graphics.printf( "Game design & programming", 1, ending_rocket_y+768+368, 320, "center")
    love.graphics.printf( "LilyUwU2001", 0, ending_rocket_y+768+384, 320, "center")
    love.graphics.printf( "Sharkingv2", 0, ending_rocket_y+768+400, 320, "center")

    -- level design
    love.graphics.printf( "Level design", 0, ending_rocket_y+768+432, 320, "center")
    love.graphics.printf( "Level design", 1, ending_rocket_y+768+432, 320, "center")
    love.graphics.printf( "1,3,5,7 - LilyUwU2001", 0, ending_rocket_y+768+448, 320, "center")
    love.graphics.printf( "2,4,6,8 - Sharkingv2", 0, ending_rocket_y+768+464, 320, "center")
    love.graphics.printf( "9 - Sharkingv2", 0, ending_rocket_y+768+480, 320, "center")

    -- Nintendo 3DS port
    love.graphics.printf( "Nintendo 3DS port", 0, ending_rocket_y+768+512, 320, "center")
    love.graphics.printf( "Nintendo 3DS port", 1, ending_rocket_y+768+512, 320, "center")
    love.graphics.printf( "LilyUwU2001", 0, ending_rocket_y+768+528, 320, "center")

    -- Thanks
    love.graphics.printf( "Thanks for playing!", 0, ending_rocket_y+768+560, 320, "center")
    love.graphics.printf( "Thanks for playing!", 1, ending_rocket_y+768+560, 320, "center")
    love.graphics.printf( "More fun games in development.", 0, ending_rocket_y+768+576, 320, "center")

    -- The End
    love.graphics.printf( "-------------------------", 0, ending_rocket_y+768+608, 320, "center")
    love.graphics.printf( "-------------------------", -1, ending_rocket_y+768+608, 320, "center")
    love.graphics.printf( "-------------------------", 1, ending_rocket_y+768+608, 320, "center")
    love.graphics.printf( "-------------------------", -2, ending_rocket_y+768+608, 320, "center")
    love.graphics.printf( "-------------------------", 2, ending_rocket_y+768+608, 320, "center")
    love.graphics.printf( "THE END!", 0, ending_rocket_y+768+624, 320, "center")
    love.graphics.printf( "THE END!", 1, ending_rocket_y+768+624, 320, "center")
    love.graphics.printf( "-------------------------", 0, ending_rocket_y+768+640, 320, "center")
    love.graphics.printf( "-------------------------", -1, ending_rocket_y+768+640, 320, "center")
    love.graphics.printf( "-------------------------", 1, ending_rocket_y+768+640, 320, "center")
    love.graphics.printf( "-------------------------", -2, ending_rocket_y+768+640, 320, "center")
    love.graphics.printf( "-------------------------", 2, ending_rocket_y+768+640, 320, "center")

    love.graphics.setColor( 1, 1, 1, 1 )
end