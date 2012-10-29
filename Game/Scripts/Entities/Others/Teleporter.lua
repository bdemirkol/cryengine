Teleporter = {
	Editor =
	{
		Icon = "AreaTrigger.bmp",
	},
	Properties =
	{
		teleportDirX = 0,
		teleportDirY = 0,
		teleportDirZ = 0,
		object_3DModel = "Editor/Objects/T.cgf",
	},
}

--- called when entity is spawned
function Teleporter:OnInit()
	self:OnReset();
end


-- called when property changes
function Teleporter:OnPropertyChange()
	self:OnReset();
end

function Teleporter:OnReset()
	if (self.Properties.object_MyModel ~= "") then
		self:LoadObject(0, self.Properties.object_3DModel);
	end
end

function Teleporter:IsUsable(user)
	return 1;
end

function Teleporter:OnUsed(user)
	--check   "user" is valid
	--if (not user) then
	--	return 0;
	--end
	--computer target position from current+teleprot
	--local vCurPos = {}
	--user:GetWorldPos(vCurPos);
	local vTargetDir = {};
	vTargetDir.x = self.Properties.teleportDirX;
	vTargetDir.y = self.Properties.teleportDirY;
	vTargetDir.z = self.Properties.teleportDirZ;
	--local vTargetPos = vecAdd(vCurPos, vTargetDir);
	--user:SetWorldPos(vTargetPos);
	user.actor:TeleportTo(vTargetDir);
end
