local Entity = class('Entity')

function Entity:initialize(tag)
	self._isDestroyed = false
	self.tag = tag
end

function Entity:update(dt)
end

function Entity:draw()
end

function Entity:onCollision()
end

function Entity:hasTag(tag)
	if self.tag == tag then
		return true
	else
		return false
	end
end

function Entity:destroy(colliderKey, secondsToDestroyed)
	local destroy_ = function()
		for k, entity in pairs(GS.current().entities) do
			if entity == self then
				table.remove(GS.current().entities, k)
				self._isDestroyed = true
				break
			end
		end

		table.insert(GS.current().toBeRemoveColliders, self[colliderKey])
	end

	if secondsToDestroyed == nil then
		destroy_()
	elseif type(secondsToDestroyed) == 'number' then
		GS.current().timer:after(secondsToDestroyed, destroy_)
	else
		print('invalid argument')
	end
end

return Entity