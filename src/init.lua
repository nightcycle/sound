local packages = script.Parent

local maidConstructor = require(packages:WaitForChild('maid'))

local sounds = {}
for i, soundGroup in ipairs(game:WaitForChild("SoundService"):GetChildren()) do
	for _, soundInst in ipairs(soundGroup:GetChildren()) do
		if soundInst:IsA("Sound") then
			soundInst.SoundGroup = soundGroup
			sounds[soundGroup.Name.."/"..soundInst.Name] = soundInst
		end
	end
end

local Object = {}
Object.__index = Object

function Object:Destroy()
	self._maid:Destroy()
end

function Object:Play()
	self.Instance:Play()
end

function Object:Fire()
	self.Instance.PlayOnRemove = true
	self:Destroy()
end

function Object:Resume()
	self.Instance:Resume()
end

function Object:Pause()
	self.Instance:Pause()
end

function Object:Stop()
	self.Instance:Stop()
end

local constructor = {}

function constructor.new(soundKey, parentInst)
	local self = setmetatable({}, Object)

	self.Instance = sounds[soundKey]:Clone()
	self._maid:GiveTask(self.Instance)
	if parentInst then
		self.Instance.Parent = parentInst
	end
	self._maid = maidConstructor.new()
	self._maid:GiveTask(self)

	return self
end

return constructor