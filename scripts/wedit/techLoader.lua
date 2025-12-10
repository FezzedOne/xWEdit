local ini = init

-- Opens the tech loader interface, unless the player has ignored it or already has the xTech tech equipped.
init = function()
    if ini then ini() end
    if
        (not status.statusProperty("weditTechLoaderIgnored", false) and player.equippedTech("head") ~= "anarxy")
        and root.hasTech("anarxy")
    then
        player.interact("ScriptPane", "/interface/wedit/techLoader/techLoader.config")
    end

    message.setHandler("interact", function(_, sameClient, type, config)
        if sameClient then player.interact(type, config) end
    end)

    message.setHandler("/creative", function(_, sameClient, rawArgs)
        if sameClient then
            local args = chat.parseArguments(rawArgs)
            local creativeState = world.getProperty("bypassBuildChecks") == true
            local changedState = nil
            if args[1] == "" then args[1] = nil end
            if args[1] == "on" or args[1] == "enable" then
                world.setProperty("bypassBuildChecks", true)
                changedState = true
            elseif args[1] == "off" or args[1] == "disable" then
                world.setProperty("bypassBuildChecks", false)
                changedState = false
            elseif args[1] then
                if xsb then
                    return "^red;Invalid argument.^reset;\nThis command controls whether various in-game building restrictions (tile collision, object breakability, etc.) are toggled on the world for all players. In multiplayer, this requires the server to be running xServer v4.2+ and, if world claims are enabled on the server, requires build permission to toggle. Also enables mid-air tile placement and in-place tile replacement with material items, and disables material/object consumption on placement, on xClient v4.2+ if enabled on the world; mid-air placement and tile replacement require xServer (v4.2+ for tile replacement) in multiplayer. Syntax is ^cyan,font=unifont;/creative [on/off/enable/disable]^reset;."
                else
                    return "^red;Invalid argument.^reset;\nThis command controls whether various in-game building restrictions (tile collision, object breakability, etc.) are toggled on the world for all players. In multiplayer, this requires the server to be running xServer v4.2+ and, if world claims are enabled on the server, requires build permission to toggle. Syntax is ^cyan,font=unifont;/creative [on/off/enable/disable]^reset;."
                end
            else
                local statusText
                if overreachState then
                    statusText = "^red;Status:^reset; Creative building bypasses ^green;ENABLED^reset;."
                else
                    statusText = "^red;Status:^reset; Creative building bypasses ^red;DISABLED^reset;."
                end
                if xsb then
                    return "This command controls whether various in-game building restrictions (tile collision, object breakability, etc.) are toggled on the world for all players. In multiplayer, this requires the server to be running xServer v4.2+ and, if world claims are enabled on the server, requires build permission to toggle. Also enables mid-air tile placement and in-place tile replacement with material items, and disables material/object consumption on placement, on xClient v4.2+ if enabled on the world; mid-air placement and tile replacement require xServer (v4.2+ for tile replacement) in multiplayer. Syntax is ^cyan,font=unifont;/creative [on/off/enable/disable]^reset;."
                        .. "\n"
                        .. statusText
                else
                    return "This command controls whether various in-game building restrictions (tile collision, object breakability, etc.) are toggled on the world for all players. In multiplayer, this requires the server to be running xServer v4.2+ and, if world claims are enabled on the server, requires build permission to toggle. Syntax is ^cyan,font=unifont;/creative [on/off/enable/disable]^reset;."
                        .. "\n"
                        .. statusText
                end
            end
            if changedState == true then
                return "^red;[xSB]^reset; Attempted to ^green;ENABLE^reset; creative mode. Run ^cyan,font=unifont;/creative^reset; with no arguments to verify status, and ensure you have build permission on xServer."
            else
                return "^red;[xSB]^reset; Attempted to ^red;DISABLE^reset; creative mode. Run ^cyan,font=unifont;/creative^reset; with no arguments to verify status, and ensure you have build permission on xServer."
            end
        end
    end)

    if xsb then
        message.setHandler("/overreach", function(_, sameClient, rawArgs)
            if sameClient then
                local args = chat.parseArguments(rawArgs)
                local overreachState = player.overreach()
                if args[1] == "" then args[1] = nil end
                if args[1] == "on" or args[1] == "enable" then
                    player.toggleOverreach(true)
                elseif args[1] == "off" or args[1] == "disable" then
                    player.toggleOverreach(false)
                elseif args[1] then
                    return "^red;Invalid argument.^reset;\nThis command controls whether the player can interact with all entities on screen and reach across the entire screen with tools and placeables. Syntax is ^cyan,font=unifont;/overreach [on/off/enable/disable]^reset;."
                else
                    local statusText
                    if overreachState then
                        statusText = "^red;Status:^reset; Overreach mode ^green;ENABLED^reset;."
                    else
                        statusText = "^red;Status:^reset; Overreach mode ^red;DISABLED^reset;."
                    end
                    return "This command controls whether the player can interact with all entities on screen and reach across the entire screen with tools and placeables. Syntax is ^cyan,font=unifont;/overreach [on/off/enable/disable]^reset;."
                        .. "\n"
                        .. statusText
                end
                overreachState = player.overreach()
                if overreachState then
                    return "^red;[xSB]^reset; Overreach mode ^green;ENABLED^reset;."
                else
                    return "^red;[xSB]^reset; Overreach mode ^red;DISABLED^reset;."
                end
            end
        end)
        message.setHandler("/ignorepickups", function(_, sameClient, rawArgs)
            if sameClient then
                local args = chat.parseArguments(rawArgs)
                local itemPickupState = player.itemPickupsIgnored()
                if args[1] == "" then args[1] = nil end
                if args[1] == "on" or args[1] == "enable" then
                    player.setIgnoreItemPickups(true)
                elseif args[1] == "off" or args[1] == "disable" then
                    player.setIgnoreItemPickups(false)
                elseif args[1] then
                    return "^red;Invalid argument.^reset;\nThis command controls whether the player ignores item drops instead of picking them up. Syntax is ^cyan,font=unifont;/ignorepickups [on/off/enable/disable]^reset;."
                else
                    local statusText
                    if itemPickupState then
                        statusText = "^red;Status:^reset; Item pickups ^orange;IGNORED^reset;."
                    else
                        statusText = "^red;Status:^reset; Item pickups ^cyan;ALLOWED^reset;."
                    end
                    return "This command controls whether the player ignores item drops instead of picking them up. Syntax is ^cyan,font=unifont;/ignorepickups [on/off/enable/disable]^reset;."
                        .. "\n"
                        .. statusText
                end
                itemPickupState = player.itemPickupsIgnored()
                if itemPickupState then
                    return "^red;[xSB]^reset; Item pickups ^orange;IGNORED^reset;."
                else
                    return "^red;[xSB]^reset; Item pickups ^cyan;ALLOWED^reset;."
                end
            end
        end)
        message.setHandler("/ignoreshipupdates", function(_, sameClient, rawArgs)
            if sameClient then
                local args = chat.parseArguments(rawArgs)
                local shipUpdateState = player.shipUpdatesIgnored()
                if args[1] == "" then args[1] = nil end
                if args[1] == "on" or args[1] == "enable" then
                    player.setIgnoreShipUpdates(true)
                elseif args[1] == "off" or args[1] == "disable" then
                    player.setIgnoreShipUpdates(false)
                elseif args[1] then
                    return "^red;Invalid argument.^reset;\nThis command controls whether the player's shipworld is protected from world updates. World updates include removing or placing tiles and objects, painting tiles, changing wiring and modifying the contents of containers (which can result in item duping if protection is enabled!). The command applies to the ^orange;primary^reset; player's shipworld, even if it's not the one you originally connected with; to toggle protection for the connected shipworld, swap to the player that owns it first. Syntax is ^cyan,font=unifont;/ignoreshipupdates [on/off/enable/disable]^reset;."
                else
                    local statusText
                    if shipUpdateState then
                        statusText =
                            "^red;Status:^reset; Shipworld updates ^orange;IGNORED^reset; and shipworld ^green;PROTECTED^reset;."
                    else
                        statusText =
                            "^red;Status:^reset; Shipworld updates ^cyan;ALLOWED^reset; and shipworld ^orange;NOT PROTECTED^reset;."
                    end
                    return "This command controls whether the player's shipworld is protected from world updates. World updates include removing or placing tiles and objects, painting tiles, changing wiring and modifying the contents of containers (which can result in item duping if protection is enabled!). The command applies to the ^orange;primary^reset; player's shipworld, even if it's not the one you originally connected with; to toggle protection for the connected shipworld, swap to the player that owns it first. Syntax is ^cyan,font=unifont;/ignoreshipupdates [on/off/enable/disable]^reset;."
                        .. "\n"
                        .. statusText
                end
                shipUpdateState = player.shipUpdatesIgnored()
                if shipUpdateState then
                    return "^red;[xSB]^reset; Shipworld updates ^orange;IGNORED^reset; and shipworld ^green;PROTECTED^reset;."
                else
                    return "^red;[xSB]^reset; Shipworld updates ^cyan;ALLOWED^reset; and shipworld ^orange;NOT PROTECTED^reset;."
                end
            end
        end)
        message.setHandler("/respawninworld", function(_, sameClient, rawArgs)
            if sameClient then
                local args = chat.parseArguments(rawArgs)
                local inWorldRespawnState = player.inWorldRespawn()
                if args[1] == "" then args[1] = nil end
                if args[1] == "on" or args[1] == "enable" then
                    player.toggleInWorldRespawn(true)
                elseif args[1] == "off" or args[1] == "disable" then
                    player.toggleInWorldRespawn(false)
                elseif args[1] then
                    return "^red;Invalid argument.^reset;\nThis command controls whether the player always respawns in the same world upon death and secondary player respawning restrictions are enabled for the player. Syntax is ^cyan,font=unifont;/respawninworld [on/off/enable/disable]^reset;."
                else
                    local statusText
                    if inWorldRespawnState then
                        statusText =
                            "^red;Status:^reset; In-world respawning ^green;ENABLED^reset; and respawning restrictions ^orange;IGNORED^reset;."
                    else
                        statusText =
                            "^red;Status:^reset; In-world respawning ^red;DISABLED^reset; and respawning restrictions ^cyan;ENABLED^reset;."
                    end
                    return "This command controls whether the player always respawns in the same world upon death and secondary player respawning restrictions are enabled for the player. Syntax is ^cyan,font=unifont;/respawninworld [on/off/enable/disable]^reset;."
                        .. "\n"
                        .. statusText
                end
                inWorldRespawnState = player.inWorldRespawn()
                if inWorldRespawnState then
                    return "^red;[xSB]^reset; In-world respawning ^green;ENABLED^reset; and respawning restrictions ^orange;IGNORED^reset;."
                else
                    return "^red;[xSB]^reset; In-world respawning ^red;DISABLED^reset; and respawning restrictions ^cyan;ENABLED^reset;."
                end
            end
        end)
        message.setHandler("/alwaysallowtechs", function(_, sameClient, rawArgs)
            if sameClient then
                local args = chat.parseArguments(rawArgs)
                local techOverrideState = player.techOverridesIgnored()
                if args[1] == "" then args[1] = nil end
                if args[1] == "on" or args[1] == "enable" then
                    player.setTechOverridesIgnored(true)
                elseif args[1] == "off" or args[1] == "disable" then
                    player.setTechOverridesIgnored(false)
                elseif args[1] then
                    return "^red;Invalid argument.^reset;\nThis command controls whether the player ignores tech restrictions applied on some instanced worlds. Syntax is ^cyan,font=unifont;/alwaysallowtechs [on/off/enable/disable]^reset;."
                else
                    local statusText
                    if techOverrideState then
                        statusText = "^red;Status:^reset; World-specific tech restrictions ^orange;IGNORED^reset;."
                    else
                        statusText = "^red;Status:^reset; World-specific tech restrictions ^cyan;ALLOWED^reset;."
                    end
                    return "This command controls whether the player ignores tech restrictions applied on some instanced worlds. Syntax is ^cyan,font=unifont;/alwaysallowtechs [on/off/enable/disable]^reset;."
                        .. "\n"
                        .. statusText
                end
                techOverrideState = player.techOverridesIgnored()
                if techOverrideState then
                    return "^red;[xSB]^reset; World-specific tech restrictions ^orange;IGNORED^reset;."
                else
                    return "^red;[xSB]^reset; World-specific tech restrictions ^cyan;ALLOWED^reset;."
                end
            end
        end)
        message.setHandler("/ignorenudity", function(_, sameClient, rawArgs)
            if sameClient then
                local args = chat.parseArguments(rawArgs)
                local nudityState = player.nudityIgnored()
                if args[1] == "" then args[1] = nil end
                if args[1] == "on" or args[1] == "enable" then
                    player.setNudityIgnored(true)
                elseif args[1] == "off" or args[1] == "disable" then
                    player.setNudityIgnored(false)
                elseif args[1] then
                    return "^red;Invalid argument.^reset;\nThis command controls whether the player ignores effects that force nudity. Syntax is ^cyan,font=unifont;/ignorenudity [on/off/enable/disable]^reset;."
                else
                    local statusText
                    if nudityState then
                        statusText = "^red;Status:^reset; Forced nudity ^orange;IGNORED^reset;."
                    else
                        statusText = "^red;Status:^reset; Forced nudity ^cyan;ALLOWED^reset;."
                    end
                    return "This command controls whether the player ignores effects that force nudity. Syntax is ^cyan,font=unifont;/ignorenudity [on/off/enable/disable]^reset;."
                        .. "\n"
                        .. statusText
                end
                nudityState = player.nudityIgnored()
                if nudityState then
                    return "^red;[xSB]^reset; Forced nudity ^orange;IGNORED^reset;."
                else
                    return "^red;[xSB]^reset; Forced nudity ^cyan;ALLOWED^reset;."
                end
            end
        end)
        message.setHandler("/fastwarp", function(_, sameClient, rawArgs)
            if sameClient then
                local args = chat.parseArguments(rawArgs)
                local fastWarpState = player.fastWarp()
                if args[1] == "" then args[1] = nil end
                if args[1] == "on" or args[1] == "enable" then
                    player.toggleFastWarp(true)
                elseif args[1] == "off" or args[1] == "disable" then
                    player.toggleFastWarp(false)
                elseif args[1] then
                    return "^red;Invalid argument.^reset;\nThis command controls whether the player skips warp animations and delays when warping or beaming to another world. Syntax is ^cyan,font=unifont;/fastwarp [on/off/enable/disable]^reset;."
                else
                    local statusText
                    if fastWarpState then
                        statusText = "^red;Status:^reset; Fast warping ^green;ENABLED^reset;."
                    else
                        statusText = "^red;Status:^reset; Fast warping ^red;DISABLED^reset;."
                    end
                    return "This command controls whether the player skips warp animations and delays when warping or beaming to another world. Syntax is ^cyan,font=unifont;/fastwarp [on/off/enable/disable]^reset;."
                        .. "\n"
                        .. statusText
                end
                fastWarpState = player.fastWarp()
                if fastWarpState then
                    return "^red;[xSB]^reset; Fast warping ^green;ENABLED^reset;."
                else
                    return "^red;[xSB]^reset; Fast warping ^red;DISABLED^reset;."
                end
            end
        end)
    end
end
