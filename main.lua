require("a-star")

require("tile")
require("enemy")

imageData = love.image.newImageData("map2.png")

tiles = {}
enemies = {}
items = {}

mapOffset = {["x"] = 400, ["y"] = 20}

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

			tiles[i][j] = Tile.create( tileTypes[g])

			if r ~= 0 then
				enemies[i][j] = Enemy.create( enemyTypes[r] )
			end
		end
	end
end

function love.draw()
	love.graphics.push()
	love.graphics.translate(mapOffset.x, mapOffset.y)

	for i = 1, table.getn(tiles) do
		for j = 1, table.getn(tiles[i]) do 
			local leftX, leftY = getLeft(i, j)

			if (i == selectedX and j == selectedY) then
				tiles[i][j]:setSelected()
			end

			tiles[i][j]:draw( leftX, leftY )

			if enemies[i][j] ~= nil then
				enemies[i][j]:draw( leftX, leftY )
				enemies[i][j]:move( tiles, enemies, items, i, j )
			end
		end
	end

	love.graphics.pop()
end

function love.mousepressed(x, y, button)
	if button == "l" then
		selectedX, selectedY = screenToIso(x, y)
	end
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

-- http://laserbrainstudios.com/2010/08/the-basics-of-isometric-programming/
function screenToIso(x, y)
	x = x - (mapOffset.x + TILE_WIDTH) 
	y = y - mapOffset.y

	tileX = math.round((y / TILE_HEIGHT) + (x / TILE_WIDTH))
	tileY = math.floor((y / TILE_HEIGHT) - (x / TILE_WIDTH))

	return tileX, tileY
end

function math.round(input)
	lower = math.floor(input)
	if input - lower >= 0.5 then
		return math.ceil(input)
	else
		return lower
	end
end