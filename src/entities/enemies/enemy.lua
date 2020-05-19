local Enemy = class('Enemy', Entity)

function Enemy:initialize(path)
	Entity.initialize(self, 'enemy')

	self.x, self.y = path[1].x, path[1].y

	self.timer = Timer.new()

	self.path = path
	self.pathIndex = 2
	self.speed = 50
	self.slowEffects = {}

	self.health = 12
	self.collider = Collider(self, 24, 24, function() return 'cross' end)
end

function Enemy:update(dt)
	self.timer:update(dt)

	local point = self.path[self.pathIndex]
	local vec = Vector(point.x - self.x, point.y - self.y)

	-- Move to next point
	local dir = vec:getNormalized()
	local speedRatio = self:getSpeedRatio()
	self:move(dir, speedRatio)
	self.collider:resolvePhysics(self.x, self.y)

	-- If close to next point
	local len = vec:getLength()
	if len <= 2 then
		-- if not last point, change point
		if self.pathIndex < #self.path then
			self.pathIndex = self.pathIndex + 1
		-- if last point, destroy
		elseif self.pathIndex >= #self.path then
			self:destroy('collider')
		end
	end
end

function Enemy:draw()
	love.graphics.setColor(0.4, 0.4, 0.4)
	love.graphics.circle('fill', self.x, self.y, 12)

	love.graphics.setColor(1, 1, 1)
	love.graphics.print(tostring(self.health), self.x, self.y)
end

function Enemy:move(dir, speedRatio)
	self.x = self.x + dir.x * self.speed * speedRatio * love.timer.getDelta()
	self.y = self.y + dir.y * self.speed * speedRatio * love.timer.getDelta()
end

function Enemy:takeDamage(damage)
	self.health = self.health - damage

	if self.health <= 0 and not self._isDestroyed then
		self:destroy('collider')
	end
end

function Enemy:slow(intensity, duration)
	local slowEffect = {intensity = intensity, isOver = false}
	self.timer:after(duration, function() slowEffect.isOver = true end)
	table.insert(self.slowEffects, slowEffect)
end

function Enemy:getSpeedRatio()
	local baseRatio = 1
	for _, effect in pairs(self.slowEffects) do
		if not effect.isOver then
			baseRatio = baseRatio * (1 - effect.intensity)
		end
	end
	return baseRatio
end

return Enemy