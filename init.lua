local enabled = false
local radius = 10

local function shn()
	if enabled then
		local ppos = vector.round(minetest.localplayer:get_pos())
		for x = ppos.x-radius, ppos.x+radius do
			for y = ppos.y-radius, ppos.y+radius do
				for z = ppos.z-radius, ppos.z+radius do
					local pos = {x=x,y=y,z=z}
					local dist = vector.distance(ppos,pos)
					if dist <= radius then
						local node = minetest.get_node_or_nil(pos)
						local ndef = node and minetest.get_node_def(node.name)
						if node.name ~= "air" and ndef and ndef.drawtype == "airlike" then
							minetest.add_particle({
								pos = pos,
								velocity = {x=0, y=0, z=0},
								acceleration = {x=0, y=0, z=0},
								expirationtime = 2,
								size = 10,
								collisiondetection = false,
								collision_removal = false,
								vertical = false,
								texture = "camera_btn.png^[colorize:#ff0:255",
								glow = 14
							})
						end
					end
				end
			end
		end
		minetest.after(1,shn)
	end
end

minetest.register_chatcommand("shn",{
  description = "Toggle showing hidden nodes",
  func = function(param)
	enabled = not enabled
	shn()
	return true, "Hidden nodes showing is now "..(enabled and "enabled" or "disabled")
end})
