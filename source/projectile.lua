local pd <const> = playdate
local gfx <const> = pd.graphics

class('Projectile').extends(gfx.sprite)

-- this chunk sets up the image for the basic bullet, moved out of the init func so as to not redraw it every time it's called
projectileSize = 4
projectileImage = gfx.image.new(projectileSize * 2, projectileSize * 2)
-- allows us to draw directly on an image instead of the screen
gfx.pushContext(projectileImage)
    gfx.drawCircleAtPoint(projectileSize, projectileSize, projectileSize)
gfx.popContext()

function Projectile:init(x, y, speed)
    self:setImage(projectileImage)
    -- this property added to use moveWithCollisions
    self:setCollideRect(0, 0, self:getSize())
    self.speed = speed
    self:moveTo(x, y)
    self:add()
end

-- collisions is added to allow bullets to hit enemies
-- self.speed is added at a constant rate to self.x to move the bullet across the screen
-- moveWithCollisions returns 4 things: "actual x", "actual y", which are the actual x&y the sprite 
    -- ends up after taking collisons into consideration and "collisions" which is an array of things 
    -- that the sprite has collided with, and "length", the length of that collision array
-- we will capture these 4 things into local vars and check if a collision has occured by just checking if the length
    -- of the array is > 0, if so, we'll loop through collisions array
-- in this specific case, since at any point the bullet could technically collide with multiple enemies at once
    -- and the only thing we collide with are enemies, the "collisions" array just contains a list of all enemies it has touched at any given moment
-- "collisions" is a table filled with multiple fields, in this case only concerned with "other" field
function Projectile:update()
    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x + self.speed, self.y)
    if length > 0 then
        for index, collision in pairs(collisions) do
            local collidedObject = collision['other']
            if collidedObject:isa(Enemy) then
                collidedObject:remove()
                incrementScore()
                setShakeAmount(5)
            end
        end
        -- remove bullet if it's collided with enemy
        self:remove()
    -- despawn bullet if it flies offscreen for performance integrity
    elseif  actualX > 400 then
        self:remove()
    end
end



