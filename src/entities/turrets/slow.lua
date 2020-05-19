local SlowBullet = require 'src.entities.bullets.slowBullet'
local Turret = require 'src.entities.turrets.turret'

local Slow = class('Slow', Turret)

function Slow:initialize(x, y)
	Turret.initialize(self, x, y, 180, 1)
end

function Slow:attack(target, dir)
	local bullet = SlowBullet(self.x, self.y, dir)
	table.insert(GS.current().entities, bullet)

	bullet:destroy('collider', 2)
end

return Slow