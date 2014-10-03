require("tile")
require("enemy")

imageData = love.image.newImageData("map2.png")

tiles = {}
enemies = {}
items = {}

function love.load() 
	-- load image data into a 2d array of block objects
	for i = 1, imageData:getWidth() - 1 do
		tiles[i] = {}
		enemies[i] = {}

		for j = 1, imageData:getHeight() - 1 do 
			-- we encode info in each channel
			-- red contains enemy info: 0 for no enemies, anything else will be a type of enemy
			-- green contains terrain info
			-- blue contains item info
			r, g, b, a = imageData:getPixel(i, j)

			tiles[i][j] = Tile.create( tileTypes[g], 2 * TILE_HEIGHT )

			if r ~= 0 then
				enemies[i][j] = Enemy.create( enemyTypes[r] )
			end
		end
	end
end

function love.draw()
	love.graphics.push()
	love.graphics.translate(400, 0)

	for i = 1, table.getn(tiles) do
		for j = 1, table.getn(tiles[i]) do 
			local leftX, leftY = getLeft(i, j)

			tiles[i][j]:draw( leftX, leftY )

			if enemies[i][j] ~= nil then
				enemies[i][j]:draw( leftX, leftY )
			end
		end
	end

	love.graphics.pop()
end

function getIsoX( x, y ) 
	return (x - y) * TILE_WIDTH / 2
end

function getIsoY( x, y )
	return (x + y) * TILE_HEIGHT / 2
end

function getLeft( x, y )
	return getIsoX(x, y) , getIsoY(x, y) + TILE_HEIGHT / 2;
end

function getTop( x, y )
	return getIsoX(x, y) + TILE_WIDTH / 2 , getIsoY(x, y);
end

function getRight( x, y )
	return getIsoX(x, y) + TILE_WIDTH , getIsoY(x, y) + TILE_HEIGHT / 2;
end

function getBottom( x, y )
	return getIsoX(x, y) + TILE_WIDTH / 2 , getIsoY(x, y) + TILE_HEIGHT;
end