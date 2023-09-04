package hud;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import maps.MapBase;

// A simple overlay to show the player their progress collecting shinies.
class ShinyHud extends FlxGroup
{
	// External code calls this when a shiny is picked up, so that the HUD can display the change.
	public function updateShinyCount()
	{
		currentShinyCounter.text = Std.string(PersistenceManager.countCollectedShinies(mapNumber));
	}

	private var currentShinyCounter:FlxText;
	private var totalShinyCounter:FlxText;
	private var mapNumber:Int;

	public function new(map:MapBase)
	{
		super();
		mapNumber = map.mapNumber;
		var current = PersistenceManager.countCollectedShinies(map.mapNumber);
		var total:Int = map.totalShinies;
		// x and y together is effectively a cursor position: after adding sprites/text, they will be updated to the place where the next item can be added
		var x:Int = 14;
		var y:Int = 5;
		// This shiny cannot be picked up, and is simply used for display purposes
		var icon:FlxSprite = new Shiny(1, 1, -1);
		this.add(icon);
		currentShinyCounter = new FlxText(x, y, 16, Std.string(current));
		x += 16;
		var transitionText:FlxText = new FlxText(x, y, 4, "/");
		this.add(transitionText);
		x += 4;
		totalShinyCounter = new FlxText(x, y, 16, Std.string(total));
		this.add(currentShinyCounter);
		this.add(totalShinyCounter);
		currentShinyCounter.alignment = transitionText.alignment = totalShinyCounter.alignment = "right";
		// Stick to screen:
		icon.scrollFactor.set(0, 0);
		currentShinyCounter.scrollFactor.set(0, 0);
		transitionText.scrollFactor.set(0, 0);
		totalShinyCounter.scrollFactor.set(0, 0);
	}
}
