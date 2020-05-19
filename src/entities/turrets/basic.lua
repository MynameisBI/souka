local Turret = require 'src.entities.turrets.turret'
local Bullet = require 'src.entities.bullets.basicBullet'

local Basic = class('Basic', Turret)

function Basic:initialize(x, y)
	Turret.initialize(self, x, y, 160, 0.25)
end

function Basic:draw()
	love.graphics.setColor(0.7, 0.7, 0.8)
	love.graphics.rectangle('fill', self.x-20, self.y-20, 40, 40)
end

function Basic:attack(target, dir)
	local bullet = Bullet(self.x, self.y, dir, 340, 4)
	table.insert(GS.current().entities, bullet)

	bullet:destroy('collider', 2)
end

return Basic