TILE_HEIGHT = 16
TILE_WIDTH = 32

imageData = love.image.newImageData("map2.png")

-- value of pixel in map determines block type
-- use value as index to get block type
blockTypes = {[0] = "ground", [255] = "wall"}

function love.load() 

end

function love.draw()
	love.graphics.push()
	love.graphics.translate(400, 0)

	for i = 1, imageData:getWidth() - 1 do
		for j = 1, imageData:getHeight() - 1 do 
			local leftX, leftY = getLeft(i, j)
			local topX, topY = getTop(i, j)
			local rightX, rightY = getRight(i, j)
			local bottomX, bottomY = getBottom(i, j)

			r, g, b, a = imageData:getPixel(i, j)
			

			local tileHeight = 0;

			-- for now, just assume the image is greyscale
			if blockTypes[r] == "ground" then
				love.graphics.setColor(i + j, i + j, i + j, a)
			elseif blockTypes[r] == "wall" then
				tileHeight = 1 * TILE_HEIGHT;
				love.graphics.setColor(255, 255, 255)
			end

			-- TODO: don't draw a single polygon; draw each face. this will let us apply textures or shading more easily later
			love.graphics.polygon("fill", leftX, leftY - tileHeight, topX, topY - tileHeight, rightX, rightY - tileHeight, rightX, rightY, bottomX, bottomY, leftX, leftY)
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