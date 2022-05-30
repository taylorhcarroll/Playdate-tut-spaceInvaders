local pd <const> = playdate
local gfx <const> = pd.graphics

class('Enemy').extends(gfx.sprite)

function Enemy:init(x, y, moveSpeed)
    local playerImage = gfx.image.new("images/goblin")
    self:setImage(playerImage)
    self:moveTo(x, y)
    self:add()

    -- allows bullets to interact with enemy
    -- 0,0 is top left of sprite, the third argument gets the size of the enemy to make the collision box the size of entire sprite
    self:setCollideRect(0,0, self:getSize())

    self.moveSpeed = moveSpeed
end

function Enemy:update()
    self:moveBy(-self.moveSpeed, 0)
    
end

-- so that enemies don't get stuck on top of each other
function Enemy:collisionResponse()
    return "overlap"
end