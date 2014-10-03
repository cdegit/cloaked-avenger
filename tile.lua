Tile = {}
Tile.__index = Tile

-- value of pixel in map determines tile type
-- use value as index to get tile type
tileTypes = {[0] = "floor", [255] = "wall"}

TILE_HEIGHT = 16
TILE_WIDTH = 32

tileHeightMap = {
	['floor'] = 0,
	['wall'] = (2 * TILE_HEIGHT)
}

tileColorMap = { 
	['floor'] = { {200, 200, 200}, {230, 210, 255}, {150, 150, 150} },
	['wall'] = { {200, 200, 200}, {255, 255, 255}, {150, 150, 150} }
}

function Tile.create(tileType, height)
   local tile = {}             
   setmetatable(tile, Tile)  
   tile.type = tileType     
   tile.height = tileHeightMap[tileType]
   return tile
end

function Tile:draw( leftX, leftY ) 
	love.graphics.push()
	love.graphics.translate(leftX, leftY)

	bottomX = TILE_WIDTH / 2
	bottomY = TILE_HEIGHT / 2
	topX = TILE_WIDTH / 2
	topY = -TILE_HEIGHT / 2
	rightX = TILE_WIDTH
	rightY = 0

	-- draw each face as its own polygon, so we can add textures / shading more easily later
	love.graphics.setColor( self:frontColor() )
	love.graphics.polygon("fill", 0, 0, 0, -self.height, bottomX, bottomY - self.height, bottomX, bottomY) -- front face

	love.graphics.setColor( self:topColor() )
	love.graphics.polygon("fill", 0, 0 - self.height, topX, topY - self.height, rightX, rightY - self.height, topX, topY - (self.height - TILE_HEIGHT)) -- top face

	love.graphics.setColor( self:sideColor() )
	love.graphics.polygon("fill", bottomX, bottomY - self.height, rightX, rightY - self.height, rightX, rightY, bottomX, bottomY) -- side face

	love.graphics.pop()

end

function Tile:frontColor()
	return tileColorMap[self.type][1]
end

function Tile:topColor() 
	return tileColorMap[self.type][2]
end

function Tile:sideColor() 
	return tileColorMap[self.type][3]
end