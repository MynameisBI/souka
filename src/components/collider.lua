local Collider = class('Collider')

function Collider:initialize(entity, w, h, filter, x, y)
	self.entity = entity

	self.width, self.height = w, h
	self.x, self.y = x or 0, y or 0
	self.filter = filter

	GS.current().World:add(self, entity.x - w/2 + self.x, entity.y - h/2 + self.y, w, h)
end

function Collider:getRect()
	return self.width, self.height
end

function Collider:resolvePhysics(x, y)
	local World = GS.current().World

	local ax, ay, cols, len = World:move(self,
			x - self.width/2 + self.x, y - self.height/2 + self.y, self.filter)

	for i = 1, len do
		if World:hasItem(cols[i].item) and World:hasItem(cols[i].other) then
			cols[i].item.entity:onCollision(cols[i])
			cols[i].other.entity:onCollision(cols[i])
		end
	end

	return ax + self.width/2 - self.x, ay + self.height/2 - self.y
end

return Collider