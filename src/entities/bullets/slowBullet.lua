local Bullet = require 'src.entities.bullets.bullet'

local SlowBullet = class('SlowBullet', Bullet)

function SlowBullet:initialize(x, y, dir)
	Bullet.initialize(self, x, y, dir, 240)
	self.damage = 2
end

function SlowBullet:draw()
	love.graphics.setColor(0, 0, 1)
	love.graphics.circle('fill', self.x, self.y, 10)
end

function SlowBullet:onCollision(collision)
	if collision.other.entity:hasTag('enemy') then
		local enemy = collision.other.entity
		enemy:takeDamage(self.damage)
		enemy:slow(0.5, 0.4)

		self:destroy('collider')
	end
end

return SlowBullet