# Skies Below

> A tiny game about flipping gravity and collecting shinies.

Skies Below is a short, unpolished puzzle platformer. Anyone can [play it online](https://www.hedberggames.com/prototypes/tableflip), for free.

## About

During the summer of 2014, I made a series of tiny, unpolished games, with each one going from idea to completion in only two weeks. Skies Below is the second game in that series, and the first one built using the [Flash](https://en.wikipedia.org/wiki/Adobe_Flash) game engine [Flixel](https://flixel.org/).

When Flash was [discontinued](https://en.wikipedia.org/wiki/Adobe_Flash_Player#End_of_life), I had to [change the game to use Html5](https://www.hedberggames.com/blog/table-flip-ported-to-html-5) in order to keep it alive. To do that, I migrated the game into the [Haxe](https://haxe.org/) language, using the [HaxeFlixel](https://haxeflixel.com/) game engine. This repository captures that process - showcasing both the code from before and after the end of Flash.

## Building It Yourself

To build Skies Below, you'll need a working installation of [Haxe](https://haxe.org/) and [HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/). If you don't already have one, I recommend following the [Getting Started instructions for HaxeFlixel](https://haxeflixel.com/documentation/getting-started/), which covers everything from [installing Haxe](https://haxe.org/download/) to [using Haxelib to install and setup Flixel](https://haxeflixel.com/documentation/install-haxeflixel/) to [setting up an IDE](https://haxeflixel.com/documentation/visual-studio-code/). 
> The project is already configured to support building using [VS Code](https://code.visualstudio.com/) so if that's your preferred IDE, there should be minimal setup required.

Once you have the prerequistes, you can simply clone (or fork) this repository, and use the relevant commands to build ( `lime test` on the command line, or `Build+Debug` in VS Code.) This process should work for [most build targets supported by Flixel](https://haxeflixel.com/documentation/haxeflixel-targets/).

## Contributing

While I don't have any plans (or expectations) for accepting public contributions, if you send me a pull request, I'll be happy to look it over. 

## Credits

Original code and assets created by [Hedberggames](https://www.hedberggames.com/)

No Additional Contributors

Created using the [Flixel](https://github.com/AdamAtomic/flixel) and [HaxeFlixel](https://github.com/HaxeFlixel/flixel) game engines.

## License

You're encouraged to read and learn from the code as much as you'd like. The entire repository is covered by the highly permissive [MIT license](/LICENSE.txt). 

## Footnotes

Skies Below was originally released with the name "Table Flip", which was not a good fit for a bunch of reasons. That name may occasionally appear in older documentation/code.