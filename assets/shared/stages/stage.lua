function makeAndAddSprite(id, image, x, y, sx, sy, scale, above)
    makeLuaSprite(id, image, x, y)
    setScrollFactor(id, sx, sy)
    scaleLuaSprite(id, scale, scale)
    addLuaSprite(id, above)
end

function onCreate()
    makeAndAddSprite('bg', 'stageback', -600, -200, 0.9, 0.9, 1, false)
    makeAndAddSprite('stageFront', 'stagefront', -650, 600, 0.9, 0.9, 1.1, false)

    if not lowQuality then 
        makeAndAddSprite('stagelight1', 'stage_light', -125, -100, 0.9, 0.9, 1.1, false)
        makeAndAddSprite('stagelight2', 'stage_light', 1125, -100, 0.9, 0.9, 1.1, false)
        setPropertyLuaSprite('stagelight2', 'flipX', true)

        makeAndAddSprite('curtains', 'stagecurtains', -500, -300, 1.3, 1.3, 0.9, true)
    end
end

function onEventPushed(event, value1, value2, strumTime)
    if event == 'Dadbattle Spotlight' then 
        makeLuaSprite('black', nil, -800, -400)
        setScrollFactor('black', 0, 0)
        makeGraphic('black', screenWidth*2, screenHeight*2)
        setPropertyLuaSprite('black', 'alpha', 0.25)
        setPropertyLuaSprite('black', 'visible', false)

        addLuaSprite('black', true)

        makeAndAddSprite('spotlight', 400, -400, 1, 1, 1, true)
        setPropertyLuaSprite('spotlight', 'alpha', 0.375)
        setPropertyLuaSprite('spotlight', 'visible', false)
        setBlendMode('spotlight', 'ADD')

        createInstance('fog', 'states.stages.DadBattleFog')
        setProperty('fog.visible', false)
        addInstance('fog')
    end
end

function onEvent(event, value1, value2, strumTime)
    if event == 'Dadbattle Spotlight' then

    end
end