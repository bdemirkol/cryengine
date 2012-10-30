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

function Teleporter:OnPropertyChange()
	self:OnReset();
end

function Teleporter:OnReset()
	self.Activate = 1;
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
	local vCurPos = {};
	user:GetWorldPos(vCurPos);
	local vTargetDir = {}; --assign a temp vector as targetDir „type“
	local file = io.open("example.txt", "r")
    local n1, n2, n3 = io.read("*number", "*number", "*number")
	vTargetDir.x =n1;
	vTargetDir.y =n2;
	vTargetDir.z =n3;
	file:close()
	local file2 = io.open("example2.txt", "w")
	for i, l in pairs(vTargetDir) do
	     file2:write(tostring(i).." "..tostring(l).."\n")
	end
	file2:close()
	local vTargetPos = vecAdd(vCurPos, vTargetDir); -- seems like this does some kind of cast. keep that.
	--vTargetDir.x = self.Properties.teleportDirX;
	--vTargetDir.y = self.Properties.teleportDirY;
	--vTargetDir.z = self.Properties.teleportDirZ;

	--(tostring(vCurPos).." "..tostring(vTargetDir).." "..tostring(vCurPos[2]));

	self:SetWorldPos(vTargetPos);
	
end

function Teleporter:OnUpdate()
	local vCurPos = {};
	self.GetWorldPos(vCurPos);
	vCurPos.x = vCurPos.x + 1;
	self.SetWorldPos(vCurPos);
end
	