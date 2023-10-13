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

* Edit terrain in-game on a large scale.
* Copy and paste structures, even between planets.
* Many [tools](https://github.com/Silverfeelin/Starbound-WEdit/wiki/Features) accessible from a [compact interface](https://github.com/Silverfeelin/Starbound-WEdit/wiki/Compact-Interface).
* Configure settings in a Quickbar interface.

A full list of features with their usage can be found on [WEdit's Wiki](https://github.com/Silverfeelin/Starbound-WEdit/wiki).

### xWEdit features

* Place tiles in mid-air, with no need for block adjacency! *Requires* [xSB-2](https://github.com/FezzedOne/xSB-2) xClient in single-player, and *both* xClient and xServer in multiplayer.
* Support for the tile collision modifiers added in the xSB-2 and [OpenStarbound](https://github.com/OpenStarbound/OpenStarbound) clients. Tools that support these modifiers will say so in the `/debug` interface (which also tells you how to switch the modifier). In multiplayer, this also *requires* an xServer or OpenStarbound server.

## Wiki

WEdit's Wiki covers just about everything you need to know and do to use xWEdit, aside from the new xWEdit features, which should be largely self-explanatory.
https://github.com/Silverfeelin/Starbound-WEdit/wiki

## Planned

See the [Issues page](https://github.com/FezzedOne/xWEdit/labels/enhancement), as well as [WEdit's Issues](https://github.com/Silverfeelin/Starbound-WEdit/labels/enhancement). You can post your own suggestions here too!

## Potential Issues

* On non-xServer servers, blocks cannot be placed directly in front of or behind empty space, when there are no adjacent blocks on the same layer. Some actions may not yield the result you expected initially because of this. The script tries to work around this issue by running the same actions multiple times.
* Server lag can cause synchronization issues; the script continues working while the world hasn't updated yet. You can compensate by slowing down WEdit in the [settings](https://github.com/Silverfeelin/Starbound-WEdit/wiki/Settings-Interface). The tile prediction in xSB-2 and OpenStarbound should help with this though.
* The Undo Tool should not be relied upon; it's probably pretty buggy. It is recommended to **back up worlds** before making any major changes!

## Contributing

If you have any suggestions or feedback that might help improve this mod, please do post them by creating a [new Issue](https://github.com/FezzedOne/xWEdit/issues/new) (or for Silverfeelin's original, create a new Issue [here](https://github.com/Silverfeelin/Starbound-WEdit/issues/new)).

You can also create pull requests to contribute directly to the mod!

## Licenses

xWEdit, like WEdit, is licensed under the MIT licence. Please see: [LICENSE](https://github.com/Silverfeelin/Starbound-WEdit/blob/master/LICENSE).


Most of the icons used for the tools are courtesy of [Yusuke Kamiyamane](http://p.yusukekamiyamane.com/about/), and can be found in his [Fugue Icons](http://p.yusukekamiyamane.com/) pack. Some have been modified slightly to fit better into the game.
Fugue Icons falls under the [Creative Commons 3.0 license](http://creativecommons.org/licenses/by/3.0/).
