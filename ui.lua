function draw_uibg()
    love.graphics.setColor( 0.75, 0.75, 0.75, 1 )
	love.graphics.rectangle("fill", 0,0, 400,240)
	love.graphics.setColor( 1, 1, 1, 1 )
end

function draw_score()
    love.graphics.setColor( 0.0, 0.0, 0.0, 1 )
    love.graphics.setFont(font)
    love.graphics.print( "$ "..score, 16, 16)
    love.graphics.setColor( 1, 1, 1, 1 )
end

function draw_lives()
    for l=1, lives do
        love.graphics.draw(lifeicon, 3+13*l, 32)
    end
end

function draw_healthbar()
    if lives > 0 then
        love.graphics.setColor( 0.0, 0.0, 0.0, 1 )
        love.graphics.rectangle("fill", 16,48, 112,16)
        love.graphics.setColor( 1, 0, 0, 1 )
        love.graphics.rectangle("fill", 17,49, 110*health/100,14)
        love.graphics.setColor( 1, 1, 1, 1 )
    end
    if lives <= 0 then
        love.graphics.setColor( 0.0, 0.0, 0.0, 1 )
        love.graphics.rectangle("fill", 16,48, 112,16)
        love.graphics.setColor( 1, 0, 0, 1 )
        love.graphics.rectangle("fill", 17,49, 110*0/100,14)
        love.graphics.setColor( 1, 1, 1, 1 )
    end
end

function draw_mappos()
    love.graphics.setColor( 0.0, 0.0, 0.0, 1 )
	love.graphics.rectangle("fill", 16,128, 288,4)
    love.graphics.rectangle("fill", 16,116, 4,16)
    love.graphics.rectangle("fill", 16,116, 4,16)
    love.graphics.rectangle("fill", 88,122, 4,10)
    love.graphics.rectangle("fill", 160,116, 4,16)
    love.graphics.rectangle("fill", 232,122, 4,10)
    love.graphics.rectangle("fill", 304,116, 4,16)
    love.graphics.setColor( 1, 1, 1, 1 )
    maxprogress = (map_w*32)
    for pu in all(powerups) do
        if pu.t == 1 then
            love.graphics.draw(map1up, 10+(stagemodifiers[stagenum]*(pu.x/maxprogress)), 92)
        end
        if pu.t == 0 then
            love.graphics.draw(mapmedkit, 10+(stagemodifiers[stagenum]*(pu.x/maxprogress)), 92)
        end
        if pu.t == 4 then
            if stagenum <= 3 then
                love.graphics.draw(mapsign, 10+(stagemodifiers[stagenum]*(pu.x/maxprogress)), 92)
            end
            if stagenum == 4 or stagenum == 5 or stagenum == 6 then
                love.graphics.draw(mapportal, 10+(stagemodifiers[stagenum]*(pu.x/maxprogress)), 92)
            end
            if stagenum == 7 then
                love.graphics.draw(mapsmoke, 10+(stagemodifiers[stagenum]*(pu.x/maxprogress)), 92)
            end
            if stagenum == 8 then
                love.graphics.draw(maprocket, 10+(stagemodifiers[stagenum]*(pu.x/maxprogress)), 92)
            end
        end
    end
    for p in all(players) do
        love.graphics.draw(maphead, 10+(stagemodifiers[stagenum]*(p.x/maxprogress)), 92)
    end
    for m in all(martians) do
        if m.t == 4 then
            love.graphics.draw(mapfinalboss, 10+(stagemodifiers[stagenum]*(m.x/maxprogress)), 92)
        end
    end
end

function draw_logo()
    love.graphics.draw(amlogo, 16, 144)
end