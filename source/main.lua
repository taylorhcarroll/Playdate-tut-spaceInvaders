import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "player"
import "enemySpawner"
import "scoreDisplay"

local pd <const> = playdate
local gfx <const> = pd.graphics

function resetGame()
	resetScore()
	clearEnemies()
	stopSpawner()
	startSpawner()
end

createScoreDisplay()
Player(30, 120)
startSpawner()

function pd.update()
	gfx.sprite.update()
	pd.timer.updateTimers()
end