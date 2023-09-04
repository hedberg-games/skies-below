package;

import flixel.*;

class Exit extends FlxSprite
{
	var ExitImage = "assets/art/Exit.png";

	public var SpawnX(get, default):Int;

	public function get_SpawnX()
	{
		// After taking an exit, appear 2 tiles (2*8 pixels) to the east
		return Math.floor(this.x) + 16;
	}

	public var SpawnY(get, default):Int;

	public function get_SpawnY()
	{
		return Math.floor(this.y);
	}

	public var Destination:Int;

	public function new(x:Int, y:Int, dest:Int)
	{
		// Input x/y values are in tiles, rather than pixels, so multiply them by 8 (the size of a tile)
		super(x * 8, y * 8);
		Destination = dest;
		loadGraphic(ExitImage, true, 8, 8);
		// Exits have a simple idle animation, to suggest that the player can interact with them
		animation.add("idle", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 40, true);
		animation.play("idle");
	}
}
