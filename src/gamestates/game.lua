local Enemy = require 'src.entities.enemies.enemy'
local Base = require 'src.entities.base'
local Upgrader = require 'src.entities.upgrader'

local Game = {}

local PATH = {
	{x = 40, y = 40}, {x = 40, y = 150}, {x = 200, y = 150},
	{x = 200, y = 300}, {x = 275, y = 300},
}

function Game:enter()
	self.World = bump.newCustomWorld()
	self.toBeRemoveColliders = {}

	self.suit = suit.new()

	self.timer = Timer.new()

	self.entities = {}
	self.entities[1] = Base:new(150, 100)
	self.entities[2] = Base:new(250, 200)
	self.entities[3] = Base:new(350, 200)
	self.entities[4] = Base:new(300, 300)
	self.entities[5] = Base:new(400, 400)
	self.entities['upgrader'] = Upgrader()

	self.timer:every(0.4, function() self:spawn() end)
end

function Game:update(dt)
	for _, collider in pairs(self.toBeRemoveColliders) do
		if self.World:hasItem(collider) then
			self.World:remove(collider)
		end
	end
	self.toBeRemoveColliders = {}

	self.timer:update(dt)

	for _, entity in pairs(self.entities) do entity:update(dt) end
end

function Game:draw()
	for _, entity in pairs(self.entities) do entity:draw() end

	self.suit:draw()

	love.graphics.setColor(1, 1, 1)
	love.graphics.print(tostring(#self.World:getItems()))
	--local items = self.World:getItems()
	--for _, item in pairs(items) do
		--local x, y, w, h = self.World:getRect(item)
		--love.graphics.rectangle('line', x, y, w, h)
	--end
end

function Game:findEntityWithTag(tag)
	for _, entity in pairs(self.entities) do
		if entity.tag == tag then
			return entity
		end
	end
end

function Game:findEntitiesWithTag(tag)
	local entities = {}
	for _, entity in pairs(self.entities) do
		if entity.tag == tag then
			entities[#entities+1] = entity
		end
	end
	return entities
end

function Game:spawn()
	local enemy = Enemy(PATH)
	table.insert(self.entities, enemy)
end

return Game