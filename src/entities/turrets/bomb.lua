local Turret = require 'src.entities.turrets.turret'
local BombTurret = require 'src.entities.bullets.bombBullet'

local Bomb = class('Bomb', Turret)

function Bomb:initialize(x, y)
	Turret.initialize(self, x, y, 170, 0.6)
end

function Bomb:attack(target, dir)
	local bullet = BombTurret(self.x, self.y, dir)
	table.insert(GS.current().entities, bullet)

	bullet:destroy('collider', 2)
end

return Bomb