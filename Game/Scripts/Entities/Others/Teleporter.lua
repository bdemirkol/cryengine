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
   local function exportstring( s )
      return string.format("%q", s)
   end

   --// The Save Function
   function table.save(  tbl,filename )
      local charS,charE = "   ","\n"
      local file,err = io.open( filename, "wb" )
      if err then return err end

      -- initiate variables for save procedure
      local tables,lookup = { tbl },{ [tbl] = 1 }
      file:write( "return {"..charE )

      for idx,t in ipairs( tables ) do
         file:write( "-- Table: {"..idx.."}"..charE )
         file:write( "{"..charE )
         local thandled = {}

         for i,v in ipairs( t ) do
            thandled[i] = true
            local stype = type( v )
            -- only handle value
            if stype == "table" then
               if not lookup[v] then
                  table.insert( tables, v )
                  lookup[v] = #tables
               end
               file:write( charS.."{"..lookup[v].."},"..charE )
            elseif stype == "string" then
               file:write(  charS..exportstring( v )..","..charE )
            elseif stype == "number" then
               file:write(  charS..tostring( v )..","..charE )
            end
         end

         for i,v in pairs( t ) do
            -- escape handled values
            if (not thandled[i]) then
            
               local str = ""
               local stype = type( i )
               -- handle index
               if stype == "table" then
                  if not lookup[i] then
                     table.insert( tables,i )
                     lookup[i] = #tables
                  end
                  str = charS.."[{"..lookup[i].."}]="
               elseif stype == "string" then
                  str = charS.."["..exportstring( i ).."]="
               elseif stype == "number" then
                  str = charS.."["..tostring( i ).."]="
               end
            
               if str ~= "" then
                  stype = type( v )
                  -- handle value
                  if stype == "table" then
                     if not lookup[v] then
                        table.insert( tables,v )
                        lookup[v] = #tables
                     end
                     file:write( str.."{"..lookup[v].."},"..charE )
                  elseif stype == "string" then
                     file:write( str..exportstring( v )..","..charE )
                  elseif stype == "number" then
                     file:write( str..tostring( v )..","..charE )
                  end
               end
            end
         end
         file:write( "},"..charE )
      end
      file:write( "}" )
      file:close()
   end
   
   --// The Load Function
   function table.load( sfile )
      local ftables,err = loadfile( sfile )
      if err then return _,err end
      local tables = ftables()
      for idx = 1,#tables do
         local tolinki = {}
         for i,v in pairs( tables[idx] ) do
            if type( v ) == "table" then
               tables[idx][i] = tables[v[1]]
            end
            if type( i ) == "table" and tables[i[1]] then
               table.insert( tolinki,{ i,tables[i[1]] } )
            end
         end
         -- link indices
         for _,v in ipairs( tolinki ) do
            tables[idx][v[2]],tables[idx][v[1]] =  tables[idx][v[1]],nil
         end
      end
      return tables[1]
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
	vTargetDir.x = self.Properties.teleportDirX;
	vTargetDir.y = self.Properties.teleportDirY;
	vTargetDir.z = self.Properties.teleportDirZ;
	local vTargetPos = vecAdd(vCurPos, vTargetDir); -- seems like this does some kind of cast. keep that.
	local file = io.open("example.txt", "w")
	for i,v in pairs(vTargetPos) do 
		file:write(tostring(i).." "..tostring(v).."\n")
	end
	--(tostring(vCurPos).." "..tostring(vTargetDir).." "..tostring(vCurPos[2]));
	file:close()
	self:SetWorldPos(vTargetPos);
	
end

function Teleporter:OnUpdate()
	local vCurPos = {};
	self.GetWorldPos(vCurPos);
	vCurPos.x = vCurPos.x + 1;
	self.SetWorldPos(vCurPos);
end
	