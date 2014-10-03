require("tile")

imageData = love.image.newImageData("map2.png")

-- value of pixel in map determines block type
-- use value as index to get block type
tileTypes = {[0] = "floor", [255] = "wall"}

tiles = {}
enemies = {}
items = {}

function love.load() 
	-- load image data into a 2d array of block objects
	for i = 1, imageData:getWidth() - 1 do
		tiles[i] = {}
		for j = 1, imageData:getHeight() - 1 do 
			r, g, b, a = imageData:getPixel(i, j)

			tiles[i][j] = Tile.create( tileTypes[r], 2 * TILE_HEIGHT )
		end
	end
end

function love.draw()
	love.graphics.push()
	love.graphics.translate(400, 0)

	for i = 1, table.getn(tiles) do
		for j = 1, table.getn(tiles[i]) do 
			local leftX, leftY = getLeft(i, j)
			local topX, topY = getTop(i, j)
			local rightX, rightY = getRight(i, j)
			local bottomX, bottomY = getBottom(i, j)

			tiles[i][j]:draw( leftX, leftY, topX, topY, rightX, rightY, bottomX, bottomY )
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