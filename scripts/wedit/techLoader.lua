local ini = init

-- Opens the tech loader interface, unless the player has ignored it or already has the xTech tech equipped.
init = function()
  if ini then ini() end
  if (not status.statusProperty("weditTechLoaderIgnored", false) and player.equippedTech("head") ~= "anarxy") and root.hasTech("anarxy") then
    player.interact("ScriptPane", "/interface/wedit/techLoader/techLoader.config")
  end
end
