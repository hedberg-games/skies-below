package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxRect;
import hud.ShinyHud;
import maps.MapBase;

class PlayState extends FlxState
{
	private var character:Character;
	private var map:MapBase;
	private var exit:FlxSprite;

	private var shinyHud:ShinyHud;

	public function new()
	{
		super();
	}

	override public function create():Void
	{
		FlxG.cameras.flash(0xff000000, .2);
		super.create();
		map = MapManager.CurrentMap;
		this.add(map);
		character = new Character(MapManager.SpawnX, MapManager.SpawnY);
		this.add(character);

		// Add the Exit
		this.add(map.Exits);

		// Add shinies (if any)
		this.add(map.Shinies);

		// Limit the camera motion to the bounds of the map, before following the player
		map.follow();
		FlxG.camera.follow(character);

		// Adds a simple Heads Up Display (HUD) to show players their shiny collection progress
		shinyHud = new ShinyHud(map);
		add(shinyHud);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (!map.getBounds().overlaps(new FlxRect(character.x, character.y, 8, 8)))
		{
			// Player is out of bounds, need to warp them back home
			// Briefly fades to a red-ish color, to hide the map being reset
			FlxG.cameras.fade(0xcccc5555, .3, function()
			{
				MapManager.resetMap();
				FlxG.resetState();
			});
		}
		// Character only collides with walls/floors when not flipping
		if (!character.isFlipping)
		{
			FlxG.collide(map, character);
		}
		else
		{
			// Flip should continue until the character comes out the other side
			// The motion and animation for that is handled inside the character update and isFlipping setter, respectively.
			if (!character.overlaps(map))
				character.isFlipping = false;
		}

		// Pickup a shiny
		FlxG.overlap(character, map.Shinies, function(obj1:FlxObject, obj2:Shiny)
		{
			var shiny = obj2;
			PersistenceManager.collectShiny(shiny);
			// Explicitly calling for performance
			shinyHud.updateShinyCount();
			map.Shinies.remove(shiny);
		});
		// Touch an exit
		FlxG.overlap(character, map.Exits, function(obj1:FlxObject, obj2:Exit)
		{
			// Fade the camera to smooth over the transition into a new map
			FlxG.cameras.fade(0xff000000, .3, function()
			{
				var exit = obj2;
				MapManager.changeMap(exit);
				FlxG.resetState();
			});
		});
	}
}
