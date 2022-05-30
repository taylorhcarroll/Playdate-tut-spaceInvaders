import "enemy"

local pd <const> = playdate
local gfx <const> = pd.graphics

local spawnTimer

function startSpawner()
    math.randomseed(pd.getSecondsSinceEpoch())
    createTimer()    
end

-- generates random num of milliseconds (.5 - 1 second) to wait to spawn the next enemy
function createTimer()
    local spawnTime = math.random(500, 1000)
    -- 1st arg is how long to wait, 2nd srg is a callback function
    spawnTimer = pd.timer.performAfterDelay(spawnTime, function ()
        -- createTimer() called again to keep timer running
        createTimer()
        spawnEnemy()        
    end)    
end

function spawnEnemy()
    local spawnPosition = math.random(10, 230)
    -- spawn enemy slightly off screen so they walk into the player view
    Enemy(430, spawnPosition, 1)
end

function stopSpawner()
    if spawnTimer then
        spawnTimer:remove()
    end
end

function clearEnemies()
    local allSprites = gfx.sprite.getAllSprites()
    for index, sprite in pairs(allSprites) do
        if sprite:isa(Enemy) then
            sprite:remove()
        end
    end
end