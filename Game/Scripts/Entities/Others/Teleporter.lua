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
	self:Activate(1);
	if (self.Properties.object_MyModel ~= "") then
		self:LoadObject(0, self.Properties.object_3DModel);
	end
end

function Teleporter:IsUsable(user)
	return 1;
end

function Teleporter:OnUsed(user)

end

function Teleporter:OnUpdate(dt)
	local vCurPos = {};
	self:GetWorldPos(vCurPos);
	local vTargetDir = {}; --assign a temp vector as targetDir „type“
	local file = io.open("comm/comm.txt", "r")
    local n1, n2, n3 = file:read("*number", "*number", "*number")
	file:close()
    if n1 ~= nil do
        io.remove("comm/comm.txt")
        vTargetDir.x = n1;
        vTargetDir.y = n2;
        vTargetDir.z = n3;
    end
	local vTargetPos = vecAdd(vCurPos, vTargetDir); -- seems like this does some kind of cast. keep that.
	self:SetWorldPos(vTargetPos);
end
	
