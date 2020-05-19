local Turret = require 'src.entities.turrets.turret'
local Bullet = require 'src.entities.bullets.shotgunBullet'

local Shotgun = class('Shotgun', Turret)

function Shotgun:initialize(x, y)
	Turret.initialize(self, x, y, 100, 0.8)
end

function Shotgun:attack(target, dir)
	local spread = math.pi/12

	self:shoot(dir:rotated(spread))
	self:shoot(dir)
	self:shoot(dir:rotated(-spread))
end

function Shotgun:shoot(dir)
	local bullet = Bullet(self.x, self.y, dir, 300)
	table.insert(GS.current().entities, bullet)

	bullet:destroy('collider', 2)
end

return Shotgun