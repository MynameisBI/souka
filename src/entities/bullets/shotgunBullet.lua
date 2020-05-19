local Bullet = require 'src.entities.bullets.bullet'

local ShotgunBullet = class('ShotgunBullet', Bullet)

function ShotgunBullet:initialize(x, y, dir)
	Bullet.initialize(self, x, y, dir, 340)
	self.damage = 3
end

function ShotgunBullet:draw()
	love.graphics.setColor(0, 0, 1)
	love.graphics.circle('fill', self.x, self.y, 10)
end

function ShotgunBullet:onCollision(collision)
	if collision.other.entity:hasTag('enemy') then
		local enemy = collision.other.entity
		enemy:takeDamage(self.damage)

		self:destroy('collider')
	end
end

return ShotgunBullet