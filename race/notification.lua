addEventHandler("onClientResourceStart", getRootElement(),
    function(res)
        createTrayNotification("(" .. getResourceName(res) .. ") just started.", "default" )
        outputChatBox("#389583[RACE] #FFFFFF".. getResourceName(res) .. " #389583just started#FFFFFF.", 56, 149, 131, true)
    end
)