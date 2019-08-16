local MAX_DIST 	= 30
local MIN_DIST 	= 5
local MIN_ALPHA = 0
local carfade = true

addEventHandler("onClientRender", getRootElement(),
function()
	local camTarget = getCameraTarget()
	local tarVehicle = false
	if(camTarget == false)then return end
	if(getElementType(camTarget) == "vehicle")then
		tarVehicle = camTarget
	elseif(getElementType(camTarget) == "player")then
		tarVehicle = getPedOccupiedVehicle(camTarget)
	end
	
	if (camTarget == false or tarVehicle == false)then return end
	local posX, posY, posZ = getElementPosition(tarVehicle)
	local camX, camY, camZ = getCameraMatrix()
	local player = getElementsByType("player")
	for i = 1, #player do
		local vehicle = getPedOccupiedVehicle(player[i])
		if(vehicle ~= tarVehicle and vehicle ~= false)then
			local alpha = 255
			local x, y, z = getElementPosition(vehicle)
			local playerDist = getDistanceBetweenPoints3D(posX, posY, posZ, x, y, z)
			local camDist = getDistanceBetweenPoints3D(camX, camY, camZ, x, y, z)
			-- If distance is more or less than maximum and minimum values, then set alpha to minimum alpha.
			if(playerDist <= MIN_DIST or camDist <= MIN_DIST)then
				alpha = MIN_ALPHA
			end
			local alpha_dist = (playerDist/MAX_DIST)
			if(alpha_dist >= 0)then
				alpha = alpha_dist * 255
				if(alpha > 255)then alpha = 255 end
				if(alpha < MIN_ALPHA)then alpha = MIN_ALPHA end
			end
			if(carfade == false)then alpha = 255 end
			local state = getElementData(player[i], "state") or false
			if(state == "dead" or state == "not ready")then
				alpha = 0
			end
			setElementAlpha(vehicle, alpha)
			setElementAlpha(player[i], alpha)
		end
		if(vehicle == tarVehicle and vehicle ~= false)then
			setElementAlpha(vehicle, 255)
			setElementAlpha(player[i], 255)
		end
	end
end)

function setcarfadefunction()
	carfade = (not carfade)
	if(carfade)then
		outputChatBox("#389583[RACE] #FFFFFFCarfade is now #389583enabled#FFFFFF.", 255, 128, 0, true)
	else
		outputChatBox("#389583[RACE] #FFFFFFCarfade is now #389583disabled#FFFFFF.", 255, 128, 0, true)
	end
end
bindKey("O", "up", setcarfadefunction)
addCommandHandler("carfade", setcarfadefunction)