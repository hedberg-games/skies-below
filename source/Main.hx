package;

import flixel.FlxGame;

class Main extends FlxGame
{
	public function new()
	{
		var width:Int = 320;
		var height:Int = 240;

		//Window scaling is now handled via config, rather than the application itself
		super(width, height, PreloaderState, 60, 60, true);
	}
}
