local Turret = class('Turret', Entity)

FindMode = {FIRST = 'first', LAST = 'last', CLOSE = 'close'}

function Turret:initialize(x, y, range, secondsPerAttack)
	Entity.initialize(self)
	self.x, self.y = x, y

	self.timer = Timer.new()

	self.target = nil
	self.findMode = FindMode.CLOSE
	self.range = range
	self.isAttackAvailable = true

	local attack = function()
		local target = self:getEnemy(GS.current():findEntitiesWithTag('enemy'))

		if target then
			local dir = Vector(target.x - self.x, target.y - self.y):getNormalized()
			self:attack(target, dir)
		end
	end
	attack()
	self.timer:every(secondsPerAttack, attack)
end

function Turret:update(dt)
	self.timer:update(dt)
end

function Turret:draw()
	love.graphics.setColor(0, 1, 1)
	love.graphics.rectangle('fill', self.x - 20, self.y - 20, 40, 40)
end

function Turret:getEnemy(enemies)
	local target

	if self.findMode == FindMode.CLOSE then
		local minDist = math.huge
		for _, enemy in pairs(enemies) do
			local dist = Vector(enemy.x - self.x, enemy.y - self.y):getLength()
			if dist < minDist and dist < self.range then
				minDist = dist
				target = enemy
			end
		end

	else
		print('using find mode : '..self.findMode)
	end

	return target
end

function Turret:attack(target, dir)
	print('attack at', tostring(target.x), tostring(target.y))
end

return Turret