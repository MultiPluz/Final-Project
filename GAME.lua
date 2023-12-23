local composer  = require( "composer" )
local widget    = require( "widget" )     
local physics   = require( "physics" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here

-- -------------------------------------------------------------------------------

function loading_menu()
    function loading_phase2()
      transition.to(loading_screen, {time=1000, x=loading_screen.x, y=loading_screen.y, rotation=0,onComplete=loading_phase3})
    end
    function loading_phase3()
        farBackground:removeSelf()
        nearBackground:removeSelf()
        foreground:removeSelf()
        lastground:removeSelf()
        loading_screen:removeSelf()
        composer.gotoScene( "menu", options )
    end
         
    
    loading_screen = display.newImageRect(loading_ground, "images/loading.png", 560, 927 )
    loading_ground:insert(loading_screen)
    loading_screen.x = 150
    loading_screen.y = -700
    transition.to(loading_screen, {time=1000, x=loading_screen.x, y=250, rotation=0,onComplete=loading_phase2})
    go_to_menu=1
end

-- "scene:create()"
function scene:create( event )
    composer.removeScene("menu")
    local sceneGroup = self.view
    otherground:insert(sceneGroup)
    timer.allowInterationsWithinFrame = true
    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    
    --test used code to menu
    local b_Press = function( event )
            --msgtxt.text = "Press"
            
    end
    
    -- 按鈕觸發放開事件
    local b_Release = function( event )
            --msgtxt.text = "Release"
            timer.cancelAll()
            transition.cancelAll()
            audio.stop()
            local function sound_del()
              audio.dispose(Button_Sound)
            end
            local Button_Sound = audio.loadSound( "sound/button.mp3" )
            local play_Button_Sound = audio.play( Button_Sound , {onComplete=sound_del})
            loading_menu()
    end
    --]]
    
    -- 設定按鈕屬性(所有的屬性均是選擇性的，可不設定)
    local button = widget.newButton
    {
            width = 60,
            height = 60,
            defaultFile = "images/Menu.png",          -- 未按按鈕時顯示的圖片
            overFile = "images/Menu_pressed.png",             -- 按下按鈕時顯示的圖片
            --label = "MENU",                              -- 按鈕上顯示的文字
            font = native.systemFont,                     -- 按鈕使用字型
            labelColor = { default = { 0.7, 0.5, 0.3 } },       -- 按鈕字體顏色   
            fontSize = 20,                                -- 按鈕文字字體大小
            emboss = true,                                -- 立體效果
            onPress = b_Press,                        -- 觸發按下按鈕事件要執行的函式
            onRelease = b_Release,                    -- 觸發放開按鈕事件要執行的函式
    }
    -- 按鈕物件位置
    button.x = 280; button.y = 20
    
    
    --Game initial setting
    physics.start()
    physics.setGravity( 0,0)
    math.randomseed(os.time())            --randseed setting
    farBackground = display.newGroup()  
    nearBackground = display.newGroup()  --this will overlay 'farBackground'  
    foreground = display.newGroup()  --and this will overlay 'nearBackground'
    lastground = display.newGroup()
    
    lastground:insert(button)
    
    sceneGroup:insert(farBackground)
    sceneGroup:insert(nearBackground)
    sceneGroup:insert(foreground)
    sceneGroup:insert(lastground)
    
    Total_score=0       --Score text
    score_title  = display.newText(lastground,"Score :  ",160,22,system.nativeFont,20)  --display score title
    score_number = display.newText(lastground,Total_score,200,22,system.nativeFont,20)  --display score
    score_title:setFillColor( 1, 1, 1 )
    score_number:setFillColor( 1, 1, 1 )
    
    
    local background = display.newImageRect(farBackground, "images/grass2.jpg", 850, 560 )
    background.x = 223
    background.y = 242
    
    --[[
    background1 = display.newImageRect(farBackground, "images/background.png", 350, 1050 )
    background1.x = 160
    background1.y = 0
    background2 = display.newImageRect(farBackground, "images/background2.png", 350, 1050 )
    background2.x = 160
    background2.y = -1050
    background3 = display.newImageRect(farBackground, "images/background2.png", 350, 1050 )
    background3.x = 160
    background3.y = 1050
    ]]--
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)
        
        --standard variable setting
        function std_setting()
          --1.PLAYersetting
          player_move_length = 65
          player_life =3
          player_invincibilityTime = 1500
           --2.SHOOTING
          shoot_time = 300
          Ballistic_number = 1
          bullet_move_length=200
          bullet_rand_y = 10
          
          
          --3.ENERMY
          boss_spawn_countdown=30
          boss_spawn_countdown_cycle=30
          boss_spawn_countdown_cycle_change=-5
          boss_spawn_countdown_display = display.newText(foreground,boss_spawn_countdown,20,22,system.nativeFont,20)  --display score
          boss_spawn_countdown_display:setFillColor( 1, 1, 1 )
          boss_level=1
          respawn_time1=1500  --for enermy1
          respawn_time2=1500  --for enermy2
        end
        
        function test_setting()
          --1.PLAYersetting
          player_move_length = 200
          player_life =2
          player_invincibilityTime = 1000
           --2.SHOOTING
          shoot_time = 180
          Ballistic_number = 20
          bullet_move_length =300
          bullet_rand_y = 10
          
          
          --3.ENERMY
          boss_spawn_countdown=10
          boss_spawn_countdown_cycle=10
          boss_spawn_countdown_cycle_change=-1
          boss_spawn_countdown_display = display.newText(foreground,boss_spawn_countdown,20,22,system.nativeFont,20)  --display score
          boss_spawn_countdown_display:setFillColor( 1, 1, 1 )
          boss_level=1
          respawn_time1=500  --for enermy1
          respawn_time2=500  --for enermy2
        end
        
        
        
        mode = 1    --select game mode   -1 std    -0 test
        if(mode==1)then
          std_setting()
        else
          test_setting()
        end
        
        
        
        
        
        
        --Score Title relocate
        local scoretitle_reference_x = 1;
        local function scoretitle_relocate()
          if(math.log10(Total_score)>=scoretitle_reference_x)then
            scoretitle_reference_x = scoretitle_reference_x + 1
            score_title.x = score_title.x - 5
          end
        end
        timer.performWithDelay(100,scoretitle_relocate,-1)
        
        --create a player
        ---------------------------
        -- Shapes (hitbox)
        ---------------------------
        local shape_1 = { 0.5,-22, -15,-15, -20.5,4, -11.5,18.5, 4.5,21, 18,11, 21,-4.5, 15,-15.5 }
        shape_1.density = 1; shape_1.friction = 0.3; shape_1.bounce = 0.2; 
        local PlayerCollisionFilter = { categoryBits=4, maskBits=9 }
        
        local player = display.newImageRect(nearBackground, "images/character.png", 70, 47 )
        player.x = 161
        player.y = 426
        physics.addBody( player, 
            {density=shape_1.density, friction=shape_1.friction, bounce=shape_1.bounce, shape=shape_1,filter=PlayerCollisionFilter}
        )


        
        
        
        
        
        
        
        
        
        
        sceneGroup:insert(player)
        player.isInvincible = false
        player.x = 150
        player.y = 420
        player.name = "player"
        
        
        end_x=player.x
        end_y=player.y
        player.life=player_life
        player.life_display = display.newText(nearBackground,player.life,player.x,player.y+40,system.nativeFont,10)
        player.life_display:setFillColor( 1, 1, 1 )
        
        
        
        
         
        player.speed = 500
        function move( event )
            end_x = event.x
            end_y = event.y
            if(end_x <= 0)then
              end_x = 0
            end
            if(end_x >= 320)then
              end_x = 320
            end
            if(end_y <= -100)then
              end_y = -100
            end
            if(end_y >= 580)then
              end_y = 580
            end
        end
        
        
        function run()
            local a = (end_x - player.x)
            local b = (end_y - player.y)
            local length = math.sqrt(math.pow(a,2)+ math.pow(b,2))
            if(length<=player_move_length)then
              new_x = end_x
              new_y = end_y
            else
              new_x = player.x + math.ceil(a/length*player_move_length)
              new_y = player.y + math.ceil(b/length*player_move_length)
            end
            transition.to(player, {time=500, x=new_x, y=new_y, rotation=0})
            transition.to(player.life_display, {time=500, x=new_x, y=new_y+40, rotation=0})
        end
        
        timer.performWithDelay(50,run,-1,"player_move")
        Runtime:addEventListener( "touch", move ,"player_destination")
        
        -- add the event listener to the player
        local function GAME_OVER()
          timer.cancelAll()
          transition.cancelAll()
          if(boss_exist==0)then
            audio.pause(playBackgroundMusic)
          else
            audio.pause(play_Boss_fight_Sound)
          end
          
          
          local function clear_sound()
            local function sound_del()
              audio.dispose(Game_Over_Sound)
              if(boss_exist==0)then
                audio.resume(playBackgroundMusic)
              else
                audio.resume(play_Boss_fight_Sound)
              end
            end
            local Game_Over_Sound = audio.loadSound( "sound/game_over.mp3" )
            local play_Game_Over_Sound = audio.play( Game_Over_Sound , {onComplete=sound_del})
          end
          
          local bad_end = display.newImageRect(lastground, "images/Game_over.png", 400, 400 )
          bad_end.x = 160
          bad_end.y = -500
          transition.to(bad_end, {time=3000, x=bad_end.x, y=250, rotation=0,onComplete=clear_sound})
        end
        
        local function onGlobalCollision( event )
            
                local function invincible_stop()
                  event.isBodyActive = true
                end
                if(event.object1 and event.object2)then
                  if(event.object1.name == "player" and event.object2.name == "enermy" and player.isInvincible==false) then
                      if(player.life==1)then
                        timer.cancel("shoot")
                        event.object1.life_display:removeSelf()
                        event.object1:removeSelf()
                        event.object1 = nil
                        GAME_OVER()
                      else
                        timer.pause("shoot")
                        event.object1.isInvincible=true
                        event.object1.alpha=0.5
                        player.life=player.life-1
                        player.life_display.text=player.life
                        timer.performWithDelay(player_invincibilityTime, function()
                            event.object1.isInvincible = false
                            event.object1.alpha = 1 
                            timer.resume("shoot")
                        end)
                      end
                  elseif(event.object1.name == "enermy" and event.object2.name == "player" and player.isInvincible==false) then
                      if(player.life==1)then
                        timer.cancel("shoot")
                        event.object2.life_display:removeSelf()
                        event.object2:removeSelf()
                        event.object2 = nil
                        GAME_OVER()
                      else
                        timer.pause("shoot")
                        event.object2.isInvincible=true
                        event.object2.alpha=0.5
                        player.life=player.life-1
                        player.life_display.text=player.life
                        timer.performWithDelay(player_invincibilityTime, function()
                            event.object2.isInvincible = false
                            event.object2.alpha = 1 
                            timer.resume("shoot")
                        end)
                      end
                  end
                end
           
        end
        
        
        Runtime:addEventListener( "collision", onGlobalCollision )
        
        --Shooting system
        local function shoot_n_times()
            bullet_x = player.x 
            bullet_y = player.y -15
            bullet_life_time =bullet_move_length*4 --millisecond
            bullet_distance = 6
            local BulletCollisionFilter = { categoryBits=2, maskBits=1 }
            local bullet = {} 
            local shape_1 = { 0.240758121013641,-7.35187339782715, -5.31479740142822,-5.50002193450928, -6.42590808868408,1.90738534927368, -2.72220468521118,5.61108875274658, 2.83335065841675,6.35182952880859, 6.53705406188965,2.27775573730469, 7.27779483795166,-1.42594790458679, 5.05557298660278,-5.50002193450928 }
            shape_1.density = 1; shape_1.friction = 0.3; shape_1.bounce = 0.2; 
            
            local shape_2 = { 0.611128449440002,-14.0185403823853, -4.20368623733521,4.87034797668457, 1.72223949432373,12.6481256484985, 3.20372104644775,9.31479263305664 }
            shape_2.density = 1; shape_2.friction = 0.3; shape_2.bounce = 0.2; 
            
            
            
            
            
            
            

            
            local regerence_x = (-(Ballistic_number-1)*bullet_distance)
            for i =1,Ballistic_number,1 do
                local select = math.random(100)
                if (select>50)then
                    bullet[i] = display.newImageRect(nearBackground, "images/bullet_1.png", 30, 30 )
                    physics.addBody( bullet[i],{density=shape_1.density, friction=shape_1.friction, bounce=shape_1.bounce, shape=shape_1,filter=BulletCollisionFilter})
                else
                    bullet[i] = display.newImageRect(nearBackground, "images/bullet_2.png", 30, 30 )
                    physics.addBody( bullet[i],{density=shape_2.density, friction=shape_2.friction, bounce=shape_2.bounce, shape=shape_2,filter=BulletCollisionFilter})
                    
                end

                bullet[i].name = "bullet"
                bullet[i].x = bullet_x 
                bullet[i].y = bullet_y + math.random(bullet_rand_y)
                bullet[i].time = bullet_life_time;
                function del()
                  if(bullet[i])then
                    bullet[i]:removeSelf()
                    bullet[i]= nil
                  end                     
                end   
               local reference_y = math.sqrt(math.pow(bullet_move_length,2)-math.pow(regerence_x,2))
               transition.to(bullet[i], {time=bullet_life_time, x=bullet[i].x+regerence_x, y=bullet[i].y-reference_y, rotation=0,onComplete=del})
                
                
                local function onColl(x)
                         if(x.phase=="began") then
                            bullet[i]:removeSelf()
                            bullet[i] = nil
                         end
                end
                bullet[i]:addEventListener("collision",onColl)
                regerence_x = regerence_x + 2*bullet_distance
            end
        
        end
        
        timer.performWithDelay( shoot_time, shoot_n_times,-1 ,"shoot")






        --enermy initial setting 
        item_wait_spawn=0
        current_x=0
        current_y=0
        
        current2_x = 0
        current2_y = 0
        item2_wait_spawn = 0
        
        current3_x = 0
        current3_y = 0
        item3_wait_spawn = 0
        
        boss_exist = 0
        
        
        
        local function enermy1_spawn()
            ---------------------------
            -- Shapes
            ---------------------------
            
            local shape_1 = { -0.347778916358948,-14.4130201339722, -12.0869102478027,-8.76084613800049, -13.3912572860718,4.28263282775879, -7.3043007850647,12.1087198257446, 6.60874319076538,12.5435028076172, 13.5652647018433,3.41306734085083, 12.6956996917725,-6.58693313598633, 7.04352569580078,-11.8043241500854 }
            shape_1.density = 1; shape_1.friction = 0.3; shape_1.bounce = 0.2; 
            local enermyCollisionFilter = { categoryBits=1, maskBits=6 }
            local enermy = display.newImageRect(nearBackground, "images/enermy1.png", 50, 50 )
            enermy.x = math.random( 300 ); enermy.y = -150
            physics.addBody( enermy, 
                {density=shape_1.density, friction=shape_1.friction, bounce=shape_1.bounce, shape=shape_1,filter=enermyCollisionFilter}
            )

            
            enermy.name = "enermy"
            enermy.x = math.random( 300 ); enermy.y = -150
            local life = 7*boss_level
            local score = 100
            local move_time = 15000
            local life_display = display.newText(nearBackground,life,enermy.x,enermy.y+23,system.nativeFont,10)
            life_display:setFillColor( 1, 1, 1 )
            function del()
              if(enermy)then
                enermy:removeSelf()
                enermy= nil
              end                     
            end   
            function del_number()
              if(life_display)then
                life_display:removeSelf()
                life_display= nil
              end                     
            end
            
        
            local movingdis=math.random(-300,300)
            transition.to(enermy, {time=move_time, x=enermy.x+ movingdis, y=enermy.y+800, rotation=0,onComplete=del})
            transition.to(life_display, {time=move_time, x=life_display.x+ movingdis+0.5,y=life_display.y+800+23, rotation=0,onComplete=del_number})
        
        local function onColl(x)
                   if(x.phase=="began") then
                      life = life-1
                      life_display.text = life
                      
                      
                      if(life <=0) then
                          Total_score = Total_score + score
                          score_number.text = Total_score
                          if(boss_exist==0)then
                            boss_spawn_countdown=boss_spawn_countdown-1
                            boss_spawn_countdown_display.text = boss_spawn_countdown
                            if(boss_spawn_countdown<=5)then
                              boss_spawn_countdown_display:setFillColor( 1, 0.4, 0.4)
                            end
                          end
                          
                          
                          item_wait_spawn = item_wait_spawn + 1
                          current_x = enermy.x
                          current_y = enermy.y
                          
                          local function sound_del()
                            audio.dispose(DeathSound)
                          end
                          local DeathSound = audio.loadSound( "sound/enermy_death.mp3" )
                          local playDeathSound = audio.play( DeathSound , {onComplete=sound_del})
                          
                          life_display:removeSelf()
                          life_display = nil
                          enermy:removeSelf()
                          enermy = nil
                      end
                  end
             end
             enermy:addEventListener("collision",onColl)
             
        end
        
        timer.performWithDelay( respawn_time1,enermy1_spawn,-1 ,"enermy spawn1")
        
        
        --item3_wait_spawn=0
        --current3_x=0
        --current3_y=0
        local function enermy2_spawn()
            
            ---------------------------
            -- Shapes
            ---------------------------
            local shape_1 = { -0.347778916358948,-14.4130201339722, -12.0869102478027,-8.76084613800049, -13.3912572860718,4.28263282775879, -7.3043007850647,12.1087198257446, 6.60874319076538,12.5435028076172, 13.5652647018433,3.41306734085083, 12.6956996917725,-6.58693313598633, 7.04352569580078,-11.8043241500854 }
            shape_1.density = 1; shape_1.friction = 0.3; shape_1.bounce = 0.2;
            local enermy = display.newImageRect(nearBackground, "images/enermy2.png", 50, 50 )
            local enermyCollisionFilter = { categoryBits=1, maskBits=6 }
            physics.addBody( enermy,
                {density=shape_1.density, friction=shape_1.friction, bounce=shape_1.bounce, shape=shape_1,filter=enermyCollisionFilter}
            )

            
            
            enermy.count=0
            enermy.name = "enermy"
            enermy.x = math.random( 300 ); enermy.y = -150
            local life = 4*boss_level
            local score = 100
            local move_time = 10000
            local life_display = display.newText(nearBackground,life,enermy.x,enermy.y+20,system.nativeFont,10)
            life_display:setFillColor( 1, 1, 1 ) 
            function del()
              if(enermy)then
                enermy:removeSelf()
                enermy= nil
              end                     
            end   
            function del_number()
              if(life_display)then
                life_display:removeSelf()
                life_display= nil
              end                     
            end   
            local movingdis=math.random(-300,300)
            transition.to(enermy, {time=move_time, x=enermy.x+movingdis, y=enermy.y+800, rotation=0,onComplete=del})
            transition.to(life_display, {time=move_time, x=life_display.x+movingdis+0.5, y=life_display.y+800+20, rotation=0,onComplete=del_number})
        
        local function onColl(x)
                   if(x.phase=="began") then
                      life = life-1
                      life_display.text = life
                      
                      
                      if(life <=0) then
                          Total_score = Total_score + score
                          score_number.text = Total_score
                          if(boss_exist==0)then
                            boss_spawn_countdown=boss_spawn_countdown-1
                            boss_spawn_countdown_display.text = boss_spawn_countdown
                            if(boss_spawn_countdown<=5)then
                              boss_spawn_countdown_display:setFillColor( 1, 0.4, 0.4)
                            end
                          end
                          current2_x = enermy.x
                          current2_y = enermy.y
                          item2_wait_spawn = item2_wait_spawn + 1
                          
                          --item_wait_spawn = item_wait_spawn + 1
                          --current_x = enermy.x
                          --current_y = enermy.y
                          
                          local function sound_del()
                            audio.dispose(DeathSound)
                          end
                          local DeathSound = audio.loadSound( "sound/enermy_death.mp3" )
                          local playDeathSound = audio.play( DeathSound , {onComplete=sound_del})
                          
                          life_display:removeSelf()
                          life_display = nil
                          enermy:removeSelf()
                          enermy = nil
                      end
                  end
             end
             enermy:addEventListener("collision",onColl)
        end
        
        
        timer.performWithDelay( respawn_time2, enermy2_spawn,-1 ,"enermy spawn2")
        
        local function boss_spawn()
        if(boss_spawn_countdown<=0 and boss_exist == 0)then
          boss_exist = 1
          audio.pause(playBackgroundMusic)
          function Boss_Come_sound_del()
            audio.dispose(Boss_Come_Sound)
            if(go_to_menu==0)then
              Boss_fight_Sound = audio.loadStream( "sound/boss_fight.mp3" )
              Boss_fight_Sound_options =
              {
                --channel = 31,
                loops = -1,
                --duration = 30000,
                --fadein = 5000,
                --onComplete = callbackListener
              }
             play_Boss_fight_Sound = audio.play( Boss_fight_Sound , Boss_fight_Sound_options )
            end
          end
          Boss_Come_Sound = audio.loadSound( "sound/boss_come.mp3" )
          Boss_Come_Sound_options =
              {
                --channel = 31,
                --loops = 0,
                duration = 3000,
                fadein = 1500,
                onComplete = Boss_Come_sound_del
              }
          play_Boss_Come_Sound = audio.play( Boss_Come_Sound ,Boss_Come_Sound_options)
          boss_spawn_countdown=boss_spawn_countdown_cycle+boss_spawn_countdown_cycle_change*boss_level
          boss_spawn_countdown_display.text = boss_spawn_countdown
          boss_spawn_countdown_display:setFillColor( 1, 1, 1)
          --local enermy = display.newCircle(nearBackground,0,0,20+2*boss_level)
          ---------------------------
          -- Shapes
          ---------------------------
          



          local enermyCollisionFilter = { categoryBits=1, maskBits=6 }
          local shape_1 = { -1.74070596694946,-39.8889312744141, -42.4814453125,13.4443998336792, -25.444408416748,37.888843536377, -1.74070596694946,43.814769744873, 16.7778129577637,40.1110649108887, 31.5926265716553,32.7036590576172, 39.0000343322754,17.888843536377, 41.9629974365234,13.4443998336792 }
          shape_1.density = 1; shape_1.friction = 0.3; shape_1.bounce = 0.2; 
          
          
          local enermy = display.newImageRect(nearBackground, "images/boss.png", 90, 90 )
          enermy.x = 159
          enermy.y = 230

          physics.addBody( enermy, 
              {density=shape_1.density, friction=shape_1.friction, bounce=shape_1.bounce, shape=shape_1,filter=enermyCollisionFilter}
          )
          --***************
          enermy.name = "enermy"
          enermy.x = 200; enermy.y = -150
          enermy.reacttime = 2000 - 100*(boss_level-1)
          enermy.count = 0
          local life = math.ceil(50*math.pow(boss_level,2))
          local boss_move_length = 150+5*(boss_level-1)
          local score = 3000
          
          
          local life_display = display.newText(foreground,life,enermy.x,enermy.y+60,system.nativeFont,10)
          life_display:setFillColor( 1, 1, 1 ) 
          local function boss_move()
              local a = (player.x - enermy.x)
              local b = (player.y - enermy.y)
              local length = math.sqrt(math.pow(a,2)+ math.pow(b,2))
              
              
              local boss_new_x = enermy.x
              local boss_new_y = enermy.y
              boss_new_x = enermy.x + math.ceil(a/length*boss_move_length)
              boss_new_y = enermy.y + math.ceil(b/length*boss_move_length)
              
              transition.to(enermy, {time=enermy.reacttime, x=boss_new_x, y=boss_new_y, rotation=0})            
              transition.to(life_display, {time=enermy.reacttime, x=boss_new_x, y=boss_new_y+60, rotation=0})
          end
          
          local boss_move = timer.performWithDelay(enermy.reacttime,boss_move,-1)
          
          local function onColl(x)
                 if(x.phase=="began") then
                    life = life-1
                    life_display.text = life
                    
                    
                    if(life <=0) then
                        audio.stop(play_Boss_fight_Sound)
                        timer.cancel(boss_move)
                        Total_score = Total_score + score
                        score_number.text = Total_score
                        
                        current3_x = enermy.x
                        current3_y = enermy.y
                        item3_wait_spawn = item3_wait_spawn + 1
                        local function sound_del()
                          audio.dispose(DeathSound)
                        end
                        local DeathSound = audio.loadSound( "sound/enermy_death.mp3" )
                        local playDeathSound = audio.play( DeathSound , {onComplete=sound_del})
                        
                        life_display:removeSelf()
                        life_display = nil
                        enermy:removeSelf()
                        enermy = nil
                        function GAME_CLEAR()
                          local function clear_sound()
                            local function sound_del()
                              audio.dispose(Game_Clear_Sound)
                              audio.resume(playBackgroundMusic)
                            end
                            local Game_Clear_Sound = audio.loadSound( "sound/game_clear.mp3" )
                            local play_Game_Clear_Sound = audio.play( Game_Clear_Sound , {onComplete=sound_del})
                          end
                          good_end = display.newImageRect(lastground, "images/Game_clear.png", 450, 450 )
                          good_end.x = 160
                          good_end.y = -500
                          transition.to(good_end, {time=3000, x=good_end.x, y=250, rotation=0,onComplete=clear_sound})
                          
                        end
                        if(boss_level==3)then
                          timer.cancelAll()
                          transition.cancelAll()
                          GAME_CLEAR()
                        else
                          audio.resume(playBackgroundMusic)
                        end
                        boss_level = boss_level + 1
                        boss_exist = 0
                    end
                end
          end
          enermy:addEventListener("collision",onColl)
        end
        
      end
      
      timer.performWithDelay( 1000, boss_spawn,-1 ,"boss spawn")
      
      
      
      --drop item
      
      local function item_spawn_1()
          local spawn_sucess=0
          if(item_wait_spawn>=1 and spawn_sucess==0)then
              local a=math.random(100)
              if(a<=100)then
                local item_life_time =2500
                local shape_1 = { 2.69569945335388,-13.0434703826904, -10.3477792739868,-5.21738290786743, -7.3043007850647,9.56522655487061, 0.521786332130432,14.3478355407715, 8.34787368774414,8.26087856292725, 13.5652647018433,-2.60868716239929 }
                shape_1.density = 1; shape_1.friction = 0.3; shape_1.bounce = 0.2;                
                local item = display.newImageRect(nearBackground, "images/item1.png", 35, 35 )
                local itemCollisionFilter = { categoryBits=8, maskBits=4 }
                physics.addBody( item, 
                    {density=shape_1.density, friction=shape_1.friction, bounce=shape_1.bounce, shape=shape_1,filter=itemCollisionFilter}
                )

                item.name ="item"
                item.x=current_x
                item.y=current_y+20
                
                
                spawn_sucess=1
                
                function del()
                    if(item)then
                      item:removeSelf()
                      item= nil
                    end                     
                end      
                transition.to(item, {time=item_life_time, x=item.x, y=1000, rotation=0,onComplete=del})
                local function onColl(x)
                     if(x.phase=="began") then
                            if(shoot_time >=150)then
                              shoot_time = shoot_time-math.ceil((30.0/Ballistic_number))
                              --shoot_time = shoot_time-200
                            elseif(Ballistic_number<=40)then
                              shoot_time = math.ceil(shoot_time*(Ballistic_number+1.0)/Ballistic_number)
                              Ballistic_number = Ballistic_number +1
                            end
                            local function sound_del()
                              audio.dispose(Item_get_Sound)
                            end
                            local Item_get_Sound = audio.loadSound( "sound/item_get.mp3" )
                            local play_Item_get_Sound = audio.play( Item_get_Sound , {onComplete=sound_del})
                            
                            timer.cancel("shoot")
                            timer.performWithDelay( shoot_time, shoot_n_times,-1 ,"shoot")
                            item:removeSelf()
                            item = nil
                     end
                end
                item:addEventListener("collision",onColl)
              end
              item_wait_spawn=item_wait_spawn-1
          end
      end     
      timer.performWithDelay(50,item_spawn_1,-1)
      
      local function item2_spawn()
          local spawn2_sucess=0
          if(item2_wait_spawn>=1 and spawn2_sucess==0)then
              local b=math.random(80)
              if(b<=100)then
                local item2_life_time =2800                
                ---------------------------
                -- Shapes
                ---------------------------
                local itemCollisionFilter = { categoryBits=8, maskBits=4 }
                local shape_1 = { 8.34787368774414,-15.282585144043, -4.26082229614258,-10.9347591400146, -11.2173442840576,0.36958909034729, -7.7390832901001,9.06524181365967, -0.347778916358948,12.5435028076172, 10.0870037078857,8.63045883178711, 12.6956996917725,-1.80432403087616 }
                shape_1.density = 1; shape_1.friction = 0.3; shape_1.bounce = 0.2; 
                local item2 = display.newImageRect( nearBackground,"images/item2.png", 60, 60 )
                physics.addBody( item2, 
                    {density=shape_1.density, friction=shape_1.friction, bounce=shape_1.bounce, shape=shape_1,filter=itemCollisionFilter}
                )

                
                
                
                item2.name ="item2"
                item2.x=current2_x
                item2.y=current2_y+20
                spawn2_sucess=1
                
                function del2()
                    if(item2)then
                      item2:removeSelf()
                      item2= nil
                    end                     
                end      
                transition.to(item2, {time=item2_life_time, x=item2.x, y=1000, rotation=0,onComplete=del3})
                local function onColl(x)
                     if(x.phase=="began") then
                            player_move_length=player_move_length+3
                            local function sound_del()
                              audio.dispose(Item_get_Sound)
                            end
                            local Item_get_Sound = audio.loadSound( "sound/item_get.mp3" )
                            local play_Item_get_Sound = audio.play( Item_get_Sound , {onComplete=sound_del})
                            item2:removeSelf()
                            item2 = nil
                     end
                end
                item2:addEventListener("collision",onColl)
              end
              item2_wait_spawn=item2_wait_spawn-1
          end
      end     
      timer.performWithDelay(50,item2_spawn,-1)
      
      
      local function item3_spawn()
          local spawn3_sucess=0
          if(item3_wait_spawn>=1 and spawn3_sucess==0)then
              local c=math.random(90)
              if(c<=100)then
                local item3_life_time =20000
                
                ---------------------------
                -- Shapes
                ---------------------------
                local shape_1 = { 0.956568956375122,-16.1521511077881, -4.69560527801514,-5.28258514404297, -17.3043022155762,-3.54345464706421, -8.6086483001709,6.02176332473755, -9.91299629211426,18.1956768035889, 1.8261342048645,12.9782848358154, 12.6956996917725,18.1956768035889, 11.8261346817017,6.02176332473755 }
                shape_1.density = 1; shape_1.friction = 0.3; shape_1.bounce = 0.2; 

                local shape_2 = { 8.34787368774414,9.50002384185791, 20.0870037078857,-3.54345464706421, 4.86961269378662,-7.02171564102173 }
                shape_2.density = 1; shape_2.friction = 0.3; shape_2.bounce = 0.2;
                local itemCollisionFilter = { categoryBits=8, maskBits=4 }
                
                local item3 = display.newImageRect(nearBackground, "images/item3.png", 60, 60 )
                physics.addBody( item3, 
                    {density=shape_1.density, friction=shape_1.friction, bounce=shape_1.bounce, shape=shape_1,filter=itemCollisionFilter},
                    {density=shape_2.density, friction=shape_2.friction, bounce=shape_2.bounce, shape=shape_2,filter=itemCollisionFilter}
                )
                
                item3.name ="item3"
                item3.x=current3_x
                item3.y=current3_y+20
                
                spawn3_sucess=1
                
                function del2()
                    if(item3)then
                      item3:removeSelf()
                      item3= nil
                    end                     
                end      
                transition.to(item3, {time=item3_life_time, x=item3.x, y=950, rotation=0,onComplete=del4})
                local function onColl(x)
                     if(x.phase=="began") then
                            if(bullet_move_length <=500)then
                              bullet_move_length = bullet_move_length+75
                            end
                            local function sound_del()
                              audio.dispose(Item_get_Sound)
                            end
                            local Item_get_Sound = audio.loadSound( "sound/item_get.mp3" )
                            local play_Item_get_Sound = audio.play( Item_get_Sound , {onComplete=sound_del})
                            item3:removeSelf()
                            item3 = nil
                     end
                end
                item3:addEventListener("collision",onColl)
              end
              item3_wait_spawn=item3_wait_spawn-1
          end
      end     
      timer.performWithDelay(50,item3_spawn,-1)
      
      
      --[[]]-- 
      
      timer.pause("enermy spawn1")
      timer.pause("enermy spawn2")
      transition.pauseAll()
      audio.pause(playBackgroundMusic)
      
      --loading 
      local b_Release = function( event )
              --msgtxt.text = "Release"
              --timer.resumeAll()
              
              timer.resume("enermy spawn1")
              timer.resume("enermy spawn2")
              transition.resumeAll()
              audio.resume(playBackgroundMusic)
              --影格事件觸發時執行的自定函式
              --[[
              background1.speed = 3
              background2.speed = 3
              background3.speed = 3
              local function bgmove1()
                  background1.y = background1.y + background1.speed
                  if background1.y >= 1300 then
                       background1.y = background1.y-2100
                  end
              end
              local function bgmove2()
                  background2.y = background2.y + background2.speed
                  if background2.y >= 1300 then
                       background2.y = background2.y-2100
                  end
              end
              local function bgmove3()
                  background3.y = background3.y + background3.speed
                  if background3.y >= 1300 then
                       background3.y = background3.y-2100
                  end
              end
              --影格事件監聽器，約每秒觸發30次，觸發時執行上面的自訂函式(bgmove)
              
              
              timer.performWithDelay(35,bgmove1,-1)
              timer.performWithDelay(35,bgmove2,-1)
              timer.performWithDelay(35,bgmove3,-1)
              
              ]]--
              local function sound_del()
                audio.dispose(Button_Sound)
              end
              local Button_Sound = audio.loadSound( "sound/button.mp3" )
              local play_Button_Sound = audio.play( Button_Sound , {onComplete=sound_del})
              
              Go_button:removeSelf()
              
      end
      
      
      -- 設定按鈕屬性(所有的屬性均是選擇性的，可不設定)
      Go_button = widget.newButton
      {
              width = 100,
              height = 100,
              defaultFile = "images/GO.png",          -- 未按按鈕時顯示的圖片
              overFile = "images/Go_pressed.png",             -- 按下按鈕時顯示的圖片
              --label = "GO",                              -- 按鈕上顯示的文字
              font = native.systemFont,                     -- 按鈕使用字型
              labelColor = { default = { 0.8, 0.1, 0.1 }},       -- 按鈕字體顏色   
              fontSize = 20,                                -- 按鈕文字字體大小
              emboss = true,                                -- 立體效果
              --onPress = ,                        -- 觸發按下按鈕事件要執行的函式
              onRelease = b_Release,                    -- 觸發放開按鈕事件要執行的函式
      }
      lastground:insert(Go_button)
      -- 按鈕物件位置
      Go_button.x = 160; Go_button.y = 250
      
      
      
      
      
      
      
      
      
      function del_loading()
        loading_screen_previous_game:removeSelf()
      end
      function loading_phase3()
        transition.to(loading_screen_previous_game, {time=1000, x=loading_screen_previous_game.x, y=loading_screen_previous_game.y+950, rotation=0,onComplete=del_loading})
        backgroundMusic = audio.loadStream( "sound/BGM.mp3" )
        backgroundMusic_options =
        {
            channel = 32,
            loops = -1,
            --duration = 30000,
            --fadein = 5000,
            --onComplete = callbackListener
        }
        --audio.setVolume( 0.3, { channel=32 } )
        playBackgroundMusic = audio.play( backgroundMusic , backgroundMusic_options )
      end
      loading_screen_previous_game = display.newImageRect(loading_ground, "images/loading.png", 560, 927 )
      loading_ground:insert(loading_screen_previous_game)
      sceneGroup:insert(loading_screen_previous_game)
      loading_screen_previous_game.x = 150
      loading_screen_previous_game.y = 250
      transition.to(loading_screen, {time=2000, x=loading_screen_previous_game.x, y=loading_screen_previous_game.y, rotation=0,onComplete=loading_phase3}) 
      
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen
        -- Insert code here to make the scene come alive
        -- Example: start timers, begin animation, play audio, etc.
        --background music TEST
        
        
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