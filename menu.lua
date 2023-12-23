local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here

-- -------------------------------------------------------------------------------






-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
    composer.removeScene("GAME")--delete all display object in the "GAME"
    
    
    otherground:insert(sceneGroup)
    math.randomseed(os.time())
    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    display.setStatusBar( display.HiddenStatusBar )
    farBackground = display.newGroup()  --this will at the bottom
    nearBackground = display.newGroup()  --this will overlay 'farBackground'  
    foreground = display.newGroup()  --and this will overlay 'nearBackground'
    
    sceneGroup:insert(farBackground)
    sceneGroup:insert(nearBackground)
    sceneGroup:insert(foreground)
    
    
    
    --display background
    local background = display.newImageRect(foreground, "images/grass1.jpg", 717, 538 )
    background.x = 223
    background.y = 242

    local background = display.newImageRect(foreground, "images/logo.png", 425, 280 )
    background.x = 155
    background.y = 140
    
    
    
    
    
    local function loading(a)
        function loading_phase2()
            loading_screen:removeSelf()
            farBackground:removeSelf()
            nearBackground:removeSelf()
            foreground:removeSelf()
            if(a==1)then
              composer.gotoScene( "GAME", options )
            else
              composer.gotoScene( "GAME_hardcore_mode", options )
            end
        end
        loading_screen = display.newImageRect(loading_ground, "images/loading.png", 560, 927 )
        loading_ground:insert(loading_screen)
        sceneGroup:insert(loading_screen)
        loading_screen.x = 150
        loading_screen.y = -700
        transition.to(loading_screen, {time=1000, x=loading_screen.x, y=250, rotation=0,onComplete=loading_phase2})
        
    end
    
    
    
    
    
    
    
    
    -- 按鈕觸發按下事件
    local b_Press1 = function( event )
            --msgtxt.text = "Press"
    end
    
    -- 按鈕觸發放開事件
    local b_Release1 = function( event )
            --msgtxt.text = "Release"
            composer.removeScene("GAME")--delete all display object in the "GAME"
            audio.stop()
            local function sound_del()
              audio.dispose(Button_Sound)
            end
            local Button_Sound = audio.loadSound( "sound/button.mp3" )
            local play_Button_Sound = audio.play( Button_Sound , {onComplete=sound_del})
            --composer.gotoScene( "GAME", options )
            loading(1)
    end
    --]]
    
    -- 設定按鈕屬性(所有的屬性均是選擇性的，可不設定)
    local button1 = widget.newButton
    {
            width = 150,
            height = 150,
            defaultFile = "images/gamestart.png",          -- 未按按鈕時顯示的圖片
            overFile = "images/gamestart_pressed.png",             -- 按下按鈕時顯示的圖片
            --label = "Normal",                              -- 按鈕上顯示的文字
            font = native.systemFont,                     -- 按鈕使用字型
            labelColor = { default = { 0, 0, 0 } },       -- 按鈕字體顏色   
            fontSize = 20,                                -- 按鈕文字字體大小
            emboss = true,                                -- 立體效果
            onPress = b_Press1,                        -- 觸發按下按鈕事件要執行的函式
            onRelease = b_Release1,                    -- 觸發放開按鈕事件要執行的函式
    }
    -- 按鈕物件位置
    button1.x = 160; button1.y = 400
    foreground:insert(button1)
    
    
    

    
    backgroundMusic = audio.loadStream( "sound/menu.mp3" )
    backgroundMusic_options =
    {
        channel = 32,
        loops = -1,
        --duration = 30000,
        --fadein = 5000,
        --onComplete = callbackListener
    }
    audio.setVolume( 0.6, { channel=32 } )
    playBackgroundMusic = audio.play( backgroundMusic , backgroundMusic_options )
    
    if(go_to_menu==1)then
      function del_loading()
        loading_screen_previous:removeSelf()
      end
      go_to_menu = 0
      loading_screen_previous = display.newImageRect(loading_ground, "images/loading.png", 560, 927 )
      loading_ground:insert(loading_screen_previous)
      sceneGroup:insert(loading_screen_previous)
      loading_screen_previous.x = 150
      loading_screen_previous.y = 250
      transition.to(loading_screen_previous, {time=1000, x=loading_screen_previous.x, y=loading_screen_previous.y+950, rotation=0,onComplete=del_loading})
    end
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen
        -- Insert code here to make the scene come alive
        -- Example: start timers, begin animation, play audio, etc.
        
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view
     
    -- Called prior to the removal of scene's view
    -- Insert code here to clean up the scene
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene