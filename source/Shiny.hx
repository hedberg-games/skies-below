package;

import flixel.*;

// A collectable object, encapsulated in a sprite.
class Shiny extends FlxSprite
{
	// The ShinyBase uniquely identifies this shiny, and is used by the save system to track which one the player has collected.
	private var _base:ShinyBase;

	public var base(get, default):ShinyBase;

	public function get_base():ShinyBase
	{
		return _base;
	}

	private var spriteSheet = "assets/art/shiny.png";

	public function new(x:Int, y:Int, worldNumber:Int)
	{
		_base = new ShinyBase(x, y, worldNumber);
		// As always, the x and y provided to the constructor is in (8x8) tiles, rather than pixels.
		super(x * 8, y * 8);
		loadGraphic(spriteSheet, true, 8, 8);
		// Shinies have a simple idle animation, to suggest to the player to go interact with them.
		animation.add("idle", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 13);
		animation.play("idle");
	}
}
