----------------------------------------------------
-- Hax Racing 2019 / Haxardous & Marcel
----------------------------------------------------

GUIEditor = {
    label = {},
    staticimage = {}
}

isKeyStrokesShown = false;

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.staticimage[1] = guiCreateStaticImage(10, 408, 60, 60, ":sidebar/images/dot_white.png", false)
        guiSetProperty(GUIEditor.staticimage[1], "ImageColours", "tl:FF21262D tr:FF21262D bl:FF21262D br:FF21262D")

        GUIEditor.label[1] = guiCreateLabel(0, 0, 60, 60, "A", false, GUIEditor.staticimage[1])
        local font0_arialbold = guiCreateFont(":race/fonts/arialbold.ttf", 20)
        guiSetFont(GUIEditor.label[1], font0_arialbold)
        guiLabelSetColor(GUIEditor.label[1], 137, 140, 143)
        guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[1], "center")


        GUIEditor.staticimage[2] = guiCreateStaticImage(72, 408, 60, 60, ":sidebar/images/dot_white.png", false)
        guiSetProperty(GUIEditor.staticimage[2], "ImageColours", "tl:FF21262D tr:FF21262D bl:FF21262D br:FF21262D")

        GUIEditor.label[2] = guiCreateLabel(0, 0, 60, 60, "S", false, GUIEditor.staticimage[2])
        guiSetFont(GUIEditor.label[2], font0_arialbold)
        guiLabelSetColor(GUIEditor.label[2], 137, 140, 143)
        guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[2], "center")


        GUIEditor.staticimage[3] = guiCreateStaticImage(134, 408, 60, 60, ":sidebar/images/dot_white.png", false)
        guiSetProperty(GUIEditor.staticimage[3], "ImageColours", "tl:FF21262D tr:FF21262D bl:FF21262D br:FF21262D")

        GUIEditor.label[3] = guiCreateLabel(1, 0, 60, 60, "D", false, GUIEditor.staticimage[3])
        guiSetFont(GUIEditor.label[3], font0_arialbold)
        guiLabelSetColor(GUIEditor.label[3], 137, 140, 143)
        guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[3], "center")


        GUIEditor.staticimage[4] = guiCreateStaticImage(72, 346, 60, 60, ":sidebar/images/dot_white.png", false)
        guiSetProperty(GUIEditor.staticimage[4], "ImageColours", "tl:FF21262D tr:FF21262D bl:FF21262D br:FF21262D")

        GUIEditor.label[4] = guiCreateLabel(0, 0, 60, 60, "W", false, GUIEditor.staticimage[4])
        guiSetFont(GUIEditor.label[4], font0_arialbold)
        guiLabelSetColor(GUIEditor.label[4], 137, 140, 143)
        guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[4], "center")


        GUIEditor.staticimage[5] = guiCreateStaticImage(10, 470, 184, 60, ":sidebar/images/dot_white.png", false)
        guiSetProperty(GUIEditor.staticimage[5], "ImageColours", "tl:FF21262D tr:FF21262D bl:FF21262D br:FF21262D")

        GUIEditor.label[5] = guiCreateLabel(0, 0, 184, 60, "backspace", false, GUIEditor.staticimage[5])
        guiSetFont(GUIEditor.label[5], font0_arialbold)
        guiLabelSetColor(GUIEditor.label[5], 137, 140, 143)
        guiLabelSetHorizontalAlign(GUIEditor.label[5], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[5], "center")


        GUIEditor.staticimage[6] = guiCreateStaticImage(10, 532, 90, 65, ":sidebar/images/dot_white.png", false)
        guiSetProperty(GUIEditor.staticimage[6], "ImageColours", "tl:FF21262D tr:FF21262D bl:FF21262D br:FF21262D")

        GUIEditor.label[6] = guiCreateLabel(0, 0, 90, 64, "LMB", false, GUIEditor.staticimage[6])
        guiSetFont(GUIEditor.label[6], font0_arialbold)
        guiLabelSetColor(GUIEditor.label[6], 137, 140, 143)
        guiLabelSetHorizontalAlign(GUIEditor.label[6], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[6], "center")


        GUIEditor.staticimage[7] = guiCreateStaticImage(104, 532, 90, 65, ":sidebar/images/dot_white.png", false)
        guiSetProperty(GUIEditor.staticimage[7], "ImageColours", "tl:FF21262D tr:FF21262D bl:FF21262D br:FF21262D")

        GUIEditor.label[7] = guiCreateLabel(0, 0, 90, 64, "RMB", false, GUIEditor.staticimage[7])
        guiSetFont(GUIEditor.label[7], font0_arialbold)
        guiLabelSetColor(GUIEditor.label[7], 137, 140, 143)
        guiLabelSetHorizontalAlign(GUIEditor.label[7], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[7], "center")   

        guiSetVisible(GUIEditor.staticimage[1], false)
        guiSetVisible(GUIEditor.staticimage[2], false)
        guiSetVisible(GUIEditor.staticimage[3], false)
        guiSetVisible(GUIEditor.staticimage[4], false)
        guiSetVisible(GUIEditor.staticimage[5], false)
        guiSetVisible(GUIEditor.staticimage[6], false)
        guiSetVisible(GUIEditor.staticimage[7], false)
    end
)

addEventHandler( "onClientKey", root, function(button,press) 
    if button == "a" and (press) then 
        guiSetProperty(GUIEditor.staticimage[1], "ImageColours", "tl:FF3F4856 tr:FF3F4856 bl:FF3F4856 br:FF3F4856")
    elseif button == "w" and (press) then 
        guiSetProperty(GUIEditor.staticimage[4], "ImageColours", "tl:FF3F4856 tr:FF3F4856 bl:FF3F4856 br:FF3F4856")
    elseif button == "s" and (press) then 
        guiSetProperty(GUIEditor.staticimage[2], "ImageColours", "tl:FF3F4856 tr:FF3F4856 bl:FF3F4856 br:FF3F4856")
    elseif button == "d" and (press) then 
        guiSetProperty(GUIEditor.staticimage[3], "ImageColours", "tl:FF3F4856 tr:FF3F4856 bl:FF3F4856 br:FF3F4856")
    elseif button == "space" and (press) then 
        guiSetProperty(GUIEditor.staticimage[5], "ImageColours", "tl:FF3F4856 tr:FF3F4856 bl:FF3F4856 br:FF3F4856")
    elseif button == "mouse1" and (press) then 
        guiSetProperty(GUIEditor.staticimage[6], "ImageColours", "tl:FF3F4856 tr:FF3F4856 bl:FF3F4856 br:FF3F4856")
    elseif button == "mouse2" and (press) then 
        guiSetProperty(GUIEditor.staticimage[7], "ImageColours", "tl:FF3F4856 tr:FF3F4856 bl:FF3F4856 br:FF3F4856")
    end
end )



addEventHandler( "onClientKey", root, function(button,release) 
    if button == "a" and release == false then 
        guiSetProperty(GUIEditor.staticimage[1], "ImageColours", "tl:FF21262D tr:FF21262D bl:FF21262D br:FF21262D")
    elseif button == "w" and release == false then 
        guiSetProperty(GUIEditor.staticimage[4], "ImageColours", "tl:FF21262D tr:FF21262D bl:FF21262D br:FF21262D")
    elseif button == "s" and release == false then 
        guiSetProperty(GUIEditor.staticimage[2], "ImageColours", "tl:FF21262D tr:FF21262D bl:FF21262D br:FF21262D")
    elseif button == "d" and release == false then 
        guiSetProperty(GUIEditor.staticimage[3], "ImageColours", "tl:FF21262D tr:FF21262D bl:FF21262D br:FF21262D")
    elseif button == "space" and release == false then 
        guiSetProperty(GUIEditor.staticimage[5], "ImageColours", "tl:FF21262D tr:FF21262D bl:FF21262D br:FF21262D")
    elseif button == "mouse1" and release == false then 
        guiSetProperty(GUIEditor.staticimage[6], "ImageColours", "tl:FF21262D tr:FF21262D bl:FF21262D br:FF21262D")
    elseif button == "mouse2" and release == false then 
        guiSetProperty(GUIEditor.staticimage[7], "ImageColours", "tl:FF21262D tr:FF21262D bl:FF21262D br:FF21262D")
    end
end )

function showHideKeyStrokes()
    if (not isKeyStrokesShown) then
        isKeyStrokesShown = true;

        guiSetVisible(GUIEditor.staticimage[1], true)
        guiSetVisible(GUIEditor.staticimage[2], true)
        guiSetVisible(GUIEditor.staticimage[3], true)
        guiSetVisible(GUIEditor.staticimage[4], true)
        guiSetVisible(GUIEditor.staticimage[5], true)
        guiSetVisible(GUIEditor.staticimage[6], true)
        guiSetVisible(GUIEditor.staticimage[7], true)

    else
        isKeyStrokesShown = false;

        guiSetVisible(GUIEditor.staticimage[1], false)
        guiSetVisible(GUIEditor.staticimage[2], false)
        guiSetVisible(GUIEditor.staticimage[3], false)
        guiSetVisible(GUIEditor.staticimage[4], false)
        guiSetVisible(GUIEditor.staticimage[5], false)
        guiSetVisible(GUIEditor.staticimage[6], false)
        guiSetVisible(GUIEditor.staticimage[7], false)
    end
end
addCommandHandler("keystrokes", showHideKeyStrokes)

addCommandHandler( "getinfo",
	function( )
		local info = dxGetStatus( )
		for k, v in pairs( info ) do
			outputChatBox( k .. " : " .. tostring( v ) )
		end
	end
)