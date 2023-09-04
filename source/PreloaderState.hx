package;

import flixel.*;
import flixel.ui.FlxButton;

// A simple initialization scene
class PreloaderState extends FlxState
{
	override public function create()
	{
		super.create();
		MapManager.init();
		FlxG.mouse.visible = true;
		// The "Click to Play" button works around a flash bug where keyboard input was sometimes not captured
		// TODO: Assess whether this workaround is useful in HTML5 builds (might be browser-specific)
		add(new FlxButton(20, 20, "Click to play", play));
	}

	public function play()
	{
		FlxG.switchState(new PlayState());
		FlxG.mouse.visible = false;
	}
}
