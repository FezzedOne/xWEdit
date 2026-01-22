# xWEdit

xWEdit is a fork of [WEdit](https://github.com/Silverfeelin/Starbound-WEdit), the tech mod that allows you to edit the world around you on a larger scale through various functions and features not present in the game.

## Table of Contents

- [xWEdit](#xwedit)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
    - [xWEdit features](#xwedit-features)
  - [Wiki](#wiki)
  - [Planned](#planned)
  - [Potential Issues](#potential-issues)
  - [Contributing](#contributing)
  - [Licenses](#licenses)

## Features

- Edit terrain in-game on a large scale.
- Copy and paste structures, even between planets.
- Many [tools](https://github.com/Silverfeelin/Starbound-WEdit/wiki/Features) accessible from a [compact interface](https://github.com/Silverfeelin/Starbound-WEdit/wiki/Compact-Interface).
- Configure settings in a Quickbar interface.

A full list of features with their usage can be found on [WEdit's Wiki](https://github.com/Silverfeelin/Starbound-WEdit/wiki).

### xWEdit features

- No longer depends on [Remote Interfaces](https://github.com/Mehgugs/Starbound-RemoteInterfaces) ([Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=1123927966)) for the tool interfaces (as of v1.5.1.3).
- Place tiles in mid-air, with no need for block adjacency! _Requires_ [xClient](https://github.com/xStarbound/xStarbound) in single-player, and _both_ xClient and xServer in multiplayer.
- Support for the tile collision modifiers added in the xClient and [OpenStarbound](https://github.com/OpenStarbound/OpenStarbound) clients. Tools that support these modifiers will say so in the `/debug` interface (which also tells you how to switch the modifier). In multiplayer, this also _requires_ an xServer or OpenStarbound server.
- Support for _all_ materials, matmods and liquids if using xClient or OpenStarbound's client.
- Support for xClient/xServer v4.2's «creative mode» bypasses via the `/creative` command. This toggle is saved on a per-world basis to the _world file_, not to the player file. In multiplayer on an xServer server or xClient host, you need build permission on the world (or an admin account) to toggle «creative mode» if world claims/permissions are enabled.
  - The following «creative mode» features require xClient v4.2+, but do not require xServer in multiplayer:
    - Non-consumable material, liquid and object items.
    - Instant tree growth upon placement.
    - Unrestricted object placement: Allows objects to be placed in mid-air or overlapping tiles, plants or other objects.
  - The following «creative mode» features require xServer v4.2+ / hosting xClient v4.2+ but _not_ xClient on the client's end in multiplayer, or xClient v4.2+ in single-player:
    - Ability to remove tiles, plants and objects without removing objects or plants anchored to them. Note that liquids still remove hydrophobic objects (like vanilla torches) even with «creative mode» enabled, because if this exception weren't made, hydrophobic objects would still plop off anyway as soon as «creative mode» is disabled.
    - Ability to place or remove gravity-affected tiles without them falling.
    - Ability to place or remove liquids without «proccing» falling tiles or flows of liquids other than what you're placing.
    - Ability to remove unbreakable objects as if they are breakable.
  - The following «creative mode» features require _both_ xServer / hosting xClient v4.2+ _and_ xClient v4.2+ on the client's end in multiplayer, or xClient v4.2+ in single-player:
    - In-place tile replacement. Works with all xWEdit/WEdit tools and with placeable material items.
    - Mid-air tile placement with placeable material items.
    - Removal of all other tile placement restrictions.
  - _Note:_ On xClient/xServer v4.2+, xWEdit/WEdit tools now always ignore entities in the way of tile placement when placing materials, regardless of whether «creative mode» is enabled. «Creative mode» must still be enabled to use WEdit tools to replace tiles Terraria-style (without breaking objects, plants, etc.).
- Support for the following commands, all of which are only available on xClient:
  - `/overreach [on/off/enable/disable]`: Controls «overreach» mode, which allows the player to interact with any entity on-screen and removes all tool range restrictions.
  - `/ignorepickups [on/off/enable/disable]`: Controls whether the player ignores item drops instead of picking them up.
  - `/ignoreshipupdates [on/off/enable/disable]`: This command controls whether the player's shipworld is protected from world updates. World updates include removing or placing tiles and objects, painting tiles, changing wiring and modifying the contents of containers (which can result in item duping if protection is enabled!). The command applies to the _primary_ player's shipworld, even if it's not the one you originally connected with; to toggle protection for the connected shipworld, swap to the player that owns it first.
  - `/respawninworld [on/off/enable/disable]`: Controls whether the player always respawns in the same world upon death and secondary player respawning restrictions are enabled for the player.
  - `/alwaysallowtechs [on/off/enable/disable]`: Controls whether the player ignores tech restrictions applied on some instanced worlds.
  - `/ignorenudity [on/off/enable/disable]`: Controls whether the player ignores effects that force nudity.
  - `/fastwarp [on/off/enable/disable]`: Controls whether the player skips warp animations and delays when warping or beaming to another world.

## Wiki

WEdit's Wiki covers just about everything you need to know and do to use xWEdit, aside from the new xWEdit features, which should be largely self-explanatory.

- xWEdit wiki: https://github.com/FezzedOne/xWEdit/wiki
- WEdit wiki: https://github.com/Silverfeelin/Starbound-WEdit/wiki

## Planned

See the [Issues page](https://github.com/FezzedOne/xWEdit/labels/enhancement), as well as [WEdit's Issues](https://github.com/Silverfeelin/Starbound-WEdit/labels/enhancement). You can post your own suggestions here too!

## Potential Issues

- On non-xServer servers, blocks cannot be placed directly in front of or behind empty space, when there are no adjacent blocks on the same layer. Some actions may not yield the result you expected initially because of this. The script tries to work around this issue by running the same actions multiple times.
- Server lag can cause synchronization issues; the script continues working while the world hasn't updated yet. You can compensate by slowing down xWEdit in the [settings](https://github.com/Silverfeelin/Starbound-WEdit/wiki/Settings-Interface). The tile prediction feature in xStarbound and OpenStarbound should help with this though.
- The Undo Tool should not be relied upon; it's probably pretty buggy. It is recommended to **back up worlds** before making any major changes!

## Contributing

If you have any suggestions or feedback that might help improve this mod, please do post them by creating a [new Issue](https://github.com/FezzedOne/xWEdit/issues/new) (or for Silverfeelin's original, create a new Issue [here](https://github.com/Silverfeelin/Starbound-WEdit/issues/new)).

You can also create pull requests to contribute directly to the mod!

## Licenses

xWEdit, like WEdit, is licensed under the MIT licence. Please see: [LICENSE](https://github.com/Silverfeelin/Starbound-WEdit/blob/master/LICENSE).

Most of the icons used for the tools are courtesy of [Yusuke Kamiyamane](http://p.yusukekamiyamane.com/about/), and can be found in his [Fugue Icons](http://p.yusukekamiyamane.com/) pack. Some have been modified slightly to fit better into the game.
Fugue Icons falls under the [Creative Commons 3.0 license](http://creativecommons.org/licenses/by/3.0/).
