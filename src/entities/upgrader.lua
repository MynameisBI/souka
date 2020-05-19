local Upgrader = class('Upgrader', Entity)

local radius = 45
local bigButtonSize = 30
local smallButtonSize = 20

function Upgrader:initialize()
	Entity.initialize(self)
	self.base = nil
end

function Upgrader:update(dt)
	if self.base ~= nil then
		local backButtonAngle, options = self.base:getUpgradeOptions()

		-- Show back options
		local backButtonPos = Vector(self.base.x, self.base.y) +
				Vector(0, -radius):rotated(backButtonAngle)

		if GS.current().suit:Button('B',
				backButtonPos.x - smallButtonSize/2, backButtonPos.y - smallButtonSize/2,
				smallButtonSize, smallButtonSize).hit then
			self.base = nil
			return
		end

		-- Show upgrade options
		for i = 1, #options do
			local buttonPos = Vector(self.base.x, self.base.y) +
					Vector(0, -radius):rotated(options[i].angle)

			if GS.current().suit:Button(tostring(i),
					buttonPos.x - bigButtonSize/2, buttonPos.y - bigButtonSize/2,
					bigButtonSize, bigButtonSize).hit then
				options[i].execute()

				self.base = nil
				return
			end
		end
	end
end

function Upgrader:inspect(base)
	self.base = base
end

function Upgrader:isInspecting()
	if self.base == nil then
		return false
	else
		return true
	end
end

return Upgrader