local carhide = false

addEventHandler("onClientRender", root,
function()
	local player = getElementsByType("player")
	for i = 1, #player do
	    if player[i] ~= localPlayer then
		    local veh = getPedOccupiedVehicle(player[i])
		    if veh ~= false then
			    local data = getElementData(player[i],"state")
			    if carhide == true or data == "not ready" then
			        if getElementData(localPlayer, 'race.spectating') == false then
				        setElementDimension(player[i],666)
				        setElementDimension(veh,666)
				    else
					    local camTarget = getCameraTarget()
						local target = false
						if isElement (camTarget) then
					        if getElementType(camTarget) == "player" then
		                        target = getPedOccupiedVehicle(camTarget)
	                        elseif getElementType(camTarget) == "vehicle" then
		                        target = camTarget
	                        end
						end
						if veh == target then
				            setElementDimension(player[i],0)
				            setElementDimension(veh,0)
						else
						    setElementDimension(player[i],666)
				            setElementDimension(veh,666)
						end
				    end
			    elseif carhide == false or data == "dead" then
				    setElementDimension(player[i],0)
				    setElementDimension(veh,0)
			    end
		    end
	    end
	end
end)

function lagoff()
	if carhide == false then
		carhide = true
		outputChatBox("#389583[RACE] #ffffffVehicles are now #389583hidden#FFFFFF.", 255, 255, 255, true)
	else
		carhide = false
		outputChatBox("#389583[RACE] #ffffffVehicles are now #389583visible#FFFFFF.", 255, 255, 255, true)
	end
end

bindKey("lshift","down", lagoff)
addCommandHandler("carhide", lagoff)
