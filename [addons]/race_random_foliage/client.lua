local r = getResourceRootElement(getThisResource())

addEventHandler( "onClientResourceStart", r,
function()
	setWorldSpecialPropertyEnabled("randomfoliage", false)
	--outputChatBox("Randomfoliage disabled")
end)

addEventHandler( "onClientResourceStop", r,
function()
	setWorldSpecialPropertyEnabled("randomfoliage", true)
	--outputChatBox("Randomfoliage enabled")
end)

addEvent ( "onClientMapStarting", true )
addEventHandler("onClientMapStarting", getRootElement(),
function()
	setWorldSpecialPropertyEnabled("randomfoliage", false)
	--outputChatBox("Randomfoliage disabled")
end)
