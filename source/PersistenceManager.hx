package;

import flixel.util.FlxSave;

class PersistenceManager
{
	public static var unlockedLevels:Array<Int> = [2];
	public static var collectedShinies:Array<ShinyBase> = [];

	public static function collectShiny(shiny:Shiny)
	{
		// A Shiny is composed of its in-game presence (sprite/hitbox/etc.) and its underlying data (position/id/etc.)
		// The underlying data is sufficient to identify a specific shiny, so only record that value when it is picked up.
		collectedShinies.push(shiny.base);
		saveGame();
	}

	// Gets the sum of shinies in the current map that have already been collected
	// Useful for displaying progress information in the HUD
	public static function countCollectedShinies(mapNumber:Int):Int
	{
		var counter = 0;
		for (i in 0...collectedShinies.length)
		{
			if (collectedShinies[i].worldNumber == mapNumber)
				counter++;
		}
		return counter;
	}

	public static var _save:FlxSave = null;
	public static var _saveBound:Bool = false;

	public static function saveGame()
	{
		if (_save == null)
		{
			// Flixel requies a FlxSave be bound to string before it can be used
			// There's only one save "slot", so the bind is hardcoded
			_save = new FlxSave();
			_saveBound = _save.bind("tableFlip");
		}
		// This will only be false if the underlying save system is irrecoverably broken
		// Players don't initiate the save, so rather than suddenly crashing/displaying an alert, this silently disables the save system
		if (_saveBound)
		{
			_save.data.unlockedLevels = unlockedLevels;
			_save.data.collectedShinies = collectedShinies;
			// Non-flash targets must flush the save before it's completed
			_save.flush();
		}
	}

	public static function loadGame():Bool
	{
		if (_save == null)
		{
			_save = new FlxSave();
			_saveBound = _save.bind("tableFlip");
		}
		// Exit early if the save system is broken, or if there's no data saved.
		if (_saveBound && _save.data.unlockedLevels != null)
		{
			// Data is loaded "by value" from the save, to make sure that the Arrays on this class are always safe to use (no matter what the FlxSave does internally.)
			unlockedLevels = _save.data.unlockedLevels;
			for (i in 0..._save.data.collectedShinies.length)
			{
				collectedShinies.push(new ShinyBase(_save.data.collectedShinies[i].x, _save.data.collectedShinies[i].y,
					_save.data.collectedShinies[i].worldNumber));
			}
			return true;
		}
		return false;
	}
}
