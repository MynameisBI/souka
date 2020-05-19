local Basic = require 'src.entities.turrets.basic'
local Bomb = require 'src.entities.turrets.bomb'
local Slow = require 'src.entities.turrets.slow'
local Shotgun = require 'src.entities.turrets.shotgun'

local OctoDir = require 'src.entities.turrets.octoDir'

local Base = class('Base', Entity)

local color = {
	normal   = {bg = {0,0,0,  0}, fg = {0,0,0,0}},
	hovered  = {bg = {0,0,0,0.4}, fg = {0,0,0,0}},
	active   = {bg = {0,0,0,0.6}, fg = {0,0,0,0}},
}

function Base:initialize(x, y)
	self.x, self.y =  x, y
	self.id = #GS.current().entities
	self.turret = nil
end

function Base:update(dt)
	if not GS.current().entities.upgrader:isInspecting() then
		if GS.current().suit:Button('', {cornerRadius = 0, color = color, id = self.id},
				self.x - 20, self.y - 20, 40, 40).hit then
			GS.current().entities.upgrader:inspect(self)
		end
	end
end

function Base:draw()
	if self.turret == nil then
		love.graphics.setColor(0.6, 0.6, 0.6)
		love.graphics.rectangle('fill', self.x-20, self.y-20, 40, 40)
	end
end

function Base:getUpgradeOptions()
	if self.turret == nil then
		return math.pi, {
			{
				sprite = nil,
				angle = -math.pi/2 - 0.18,
				execute = function()
					self.turret = Basic(self.x, self.y)
					table.insert(GS.current().entities, self.turret)
				end
			},
			{
				sprite = nil,
				angle = -math.pi/6 - 0.06,
				execute = function()
					self.turret = Bomb(self.x, self.y)
					table.insert(GS.current().entities, self.turret)
				end
			},
			{
				sprite = nil,
				angle = math.pi/6 + 0.06,
				execute = function()
					self.turret = OctoDir(self.x, self.y)
					table.insert(GS.current().entities, self.turret)
				end
			},
			{
				sprite = nil,
				angle = math.pi/2 + 0.18,
				execute = function()
					self.turret = Shotgun(self.x, self.y)
					table.insert(GS.current().entities, self.turret)
				end
			},
		}
	else

	end
end

return Base