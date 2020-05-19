local Bullet = class('Bullet', Entity)

function Bullet:initialize(x, y, dir, speed)
	self.x, self.y = x, y
	self.dir = dir
	self.speed = speed

	self.collider = Collider(self, 10, 10, function() return 'cross' end)
end

function Bullet:update(dt)
	self.x = self.x + self.dir.x * self.speed * dt
	self.y = self.y + self.dir.y * self.speed * dt

	self.collider:resolvePhysics(self.x, self.y)
end

function Bullet:draw()
	love.graphics.setColor(0.9, 0.25, 0.9)
	love.graphics.circle('fill', self.x, self.y, 10)
end

function Bullet:onCollision(collision)
	if collision.other.entity:hasTag('enemy') then
		self:destroy('collider')
	end
end

return Bullet