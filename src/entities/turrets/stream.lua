local Turret = require 'src.entities.turrets.turret'
local Bullet = require 'src.entities.bullets.basicBullet'

local Stream = class('Stream', Turret)

function Stream:initialize(x, y)
	Turret.initialize(self, x, y, 160, 0.3)
	self.timer = Timer.new()
end

function Stream:draw()
	love.graphics.setColor(0.7, 0.7, 0.8)
	love.graphics.rectangle('fill', self.x-20, self.y-20, 40, 40)
end

function Stream:attack(target, dir)
	shoot()
	self.timer:after(0.12, function() shoot() end)
	self.timer:after(0.24, function() shoot() end)
end

function Stream:shoot()
	local bullet = Bullet(self.x, self.y, dir, 340, 4)
	table.insert(GS.current().entities, bullet)

	bullet:destroy('collider', 2)
end

return Stream