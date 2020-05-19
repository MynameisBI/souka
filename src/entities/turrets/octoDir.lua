local Turret = require 'src.entities.turrets.turret'
local Bullet = require 'src.entities.bullets.basicBullet'

local OctoDir = class('OctoDir', Turret)

function OctoDir:initialize(x, y)
	Turret.initialize(self, x, y, 160, 0.4)
end

function OctoDir:draw()
	love.graphics.setColor(0.3, 0.5, 0.8)
	love.graphics.rectangle('fill', self.x-20, self.y-20, 40, 40)
end

function OctoDir:attack(target, dir)
	for i = 1, 8 do
		local angle = math.pi*2 / 8 * i
		local bullet = Bullet(self.x, self.y, Vector(0, -1):rotated(angle), 340, 4)
		table.insert(GS.current().entities, bullet)

		bullet:destroy('collider', 2)
	end
end

return OctoDir