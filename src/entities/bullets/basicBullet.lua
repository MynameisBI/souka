local Bullet = require 'src.entities.bullets.bullet'

local BasicBullet = class('BasicBullet', Bullet)

function BasicBullet:initialize(x, y, dir)
	Bullet.initialize(self, x, y, dir, 320)
	self.damage = 3
end

function BasicBullet:draw()
	love.graphics.setColor(0, 1, 0)
	love.graphics.circle('fill', self.x, self.y, 10)
end

function BasicBullet:onCollision(collision)
	if collision.other.entity:hasTag('enemy') then
		local enemy = collision.other.entity
		enemy:takeDamage(self.damage)

		self:destroy('collider')
	end
end

return BasicBullet