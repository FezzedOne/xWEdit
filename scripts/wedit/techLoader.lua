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

    if xsb then
        message.setHandler("/overreach", function(_, sameClient, rawArgs)
            if sameClient then
                local args = table.pack(chat.parseArguments(rawArgs))
                local overreachState = player.overreach()
                if args[1] == "" then args[1] = nil end
                if args[1] == "on" or args[1] == "enable" then
                    player.toggleOverreach(true)
                elseif args[1] == "off" or args[1] == "disable" then
                    player.toggleOverreach(false)
                elseif args[1] then
                    return "Bad argument. Syntax is ^cyan,font=unifont;/overreach [on/off/enabled/disabled]^reset;, where not passing an argument switches the player's overreach mode to its opposite state."
                else
                    player.toggleOverreach(not overreachState)
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
                local args = table.pack(chat.parseArguments(rawArgs))
                local itemPickupState = player.itemPickupsIgnored()
                if args[1] == "" then args[1] = nil end
                if args[1] == "on" or args[1] == "enable" then
                    player.setIgnoreItemPickups(true)
                elseif args[1] == "off" or args[1] == "disable" then
                    player.setIgnoreItemPickups(false)
                elseif args[1] then
                    return "Bad argument. Syntax is ^cyan,font=unifont;/ignorepickups [on/off/enabled/disabled]^reset;, where not passing an argument switches the player's item pickup mode to its opposite state."
                else
                    player.setIgnoreItemPickups(not itemPickupState)
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
                local args = table.pack(chat.parseArguments(rawArgs))
                local shipUpdateState = player.shipUpdatesIgnored()
                if args[1] == "" then args[1] = nil end
                if args[1] == "on" or args[1] == "enable" then
                    player.setIgnoreShipUpdates(true)
                elseif args[1] == "off" or args[1] == "disable" then
                    player.setIgnoreShipUpdates(false)
                elseif args[1] then
                    return "Bad argument. Syntax is ^cyan,font=unifont;/ignoreshipupdates [on/off/enabled/disabled]^reset;, where not passing an argument switches the player's shipworld update mode to its opposite state."
                else
                    player.setIgnoreShipUpdates(not shipUpdateState)
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
                local args = table.pack(chat.parseArguments(rawArgs))
                local inWorldRespawnState = player.inWorldRespawn()
                if args[1] == "" then args[1] = nil end
                if args[1] == "on" or args[1] == "enable" then
                    player.toggleInWorldRespawn(true)
                elseif args[1] == "off" or args[1] == "disable" then
                    player.toggleInWorldRespawn(false)
                elseif args[1] then
                    return "Bad argument. Syntax is ^cyan,font=unifont;/respawninworld [on/off/enabled/disabled]^reset;, where not passing an argument switches the player's in-world respawn mode to its opposite state."
                else
                    player.toggleInWorldRespawn(not inWorldRespawnState)
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
                local args = table.pack(chat.parseArguments(rawArgs))
                local techOverrideState = player.techOverridesIgnored()
                if args[1] == "" then args[1] = nil end
                if args[1] == "on" or args[1] == "enable" then
                    player.setTechOverridesIgnored(true)
                elseif args[1] == "off" or args[1] == "disable" then
                    player.setTechOverridesIgnored(false)
                elseif args[1] then
                    return "Bad argument. Syntax is ^cyan,font=unifont;/alwaysallowtechs [on/off/enabled/disabled]^reset;, where not passing an argument switches the player's tech restriction mode to its opposite state."
                else
                    player.setTechOverridesIgnored(not techOverrideState)
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
                local args = table.pack(chat.parseArguments(rawArgs))
                local nudityState = player.nudityIgnored()
                if args[1] == "" then args[1] = nil end
                if args[1] == "on" or args[1] == "enable" then
                    player.setNudityIgnored(true)
                elseif args[1] == "off" or args[1] == "disable" then
                    player.setNudityIgnored(false)
                elseif args[1] then
                    return "Bad argument. Syntax is ^cyan,font=unifont;/ignorenudity [on/off/enabled/disabled]^reset;, where not passing an argument switches the player's nudity effect bypass mode to its opposite state."
                else
                    player.setNudityIgnored(not nudityState)
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
                local args = table.pack(chat.parseArguments(rawArgs))
                local fastWarpState = player.fastWarp()
                if args[1] == "" then args[1] = nil end
                if args[1] == "on" or args[1] == "enable" then
                    player.toggleFastWarp(true)
                elseif args[1] == "off" or args[1] == "disable" then
                    player.toggleFastWarp(false)
                elseif args[1] then
                    return "Bad argument. Syntax is ^cyan,font=unifont;/fastwarp [on/off/enabled/disabled]^reset;, where not passing an argument switches the player's fast warping mode mode to its opposite state."
                else
                    player.toggleFastWarp(not fastWarpState)
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
