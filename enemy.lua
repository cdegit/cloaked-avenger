Enemy = {}
Enemy.__index = Enemy

enemyTypes = {[255] = "blob"}

function Enemy.create(enemyType)
   local enemy = {}             
   setmetatable(enemy, Enemy)  
   enemy.type = enemyType     
   return enemy
end

function Enemy:draw( leftX, leftY )
	love.graphics.push()
	love.graphics.translate(leftX, leftY)
	love.graphics.polygon("fill", 0, 0, TILE_WIDTH / 2, -TILE_HEIGHT / 2, TILE_WIDTH, 0, TILE_WIDTH / 2, TILE_HEIGHT / 2)
	love.graphics.pop()
end