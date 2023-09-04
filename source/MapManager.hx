package;

import maps.*;

class MapManager
{
	// Init must be called before using this static class
	public static function init()
	{
		var hasSave = PersistenceManager.loadGame();
		if (hasSave)
		{
			// The world hub is a reasonably safe place to spawn the character, regardless of progress.
			//	It is unlocked at the start of the game, but you return to it often during a standard playthrough
			CurrentMap = new WorldHub();
			setSpawn(2);
		}
		else
		{
			// Brand new playthroughs should start on the tutorial map
			CurrentMap = new TutorialMap();
			setSpawn(1);
		}
		reconcileExits();
	}

	public static var CurrentMap:MapBase;

	// Note: The worldHub makes this more complicated - it will need custom spawn locations.
	//      Also will need to detect which exit is used
	public static var SpawnX:Int;
	public static var SpawnY:Int;

	public static function changeMap(exit:Exit)
	{
		// The world hub has nearly every exit, so in most cases this is true.
		if (CurrentMap is WorldHub)
		{
			// The current map must be destroyed before reassignment, because it (apparently) leaks/shares some internal data (wrong tilesets, crashes, etc.)
			CurrentMap.destroy();

			// The exit destination is the authoritative source for where the player is going
			//	For the sake of finishing on time, this was hard-coded, but I'd normally prefer to use a routing system to automatically pick the right map.
			if (exit.Destination == 2)
				CurrentMap = new TutorialMap();
			if (exit.Destination == 3)
				CurrentMap = new CollectablesMap();
			if (exit.Destination == 4)
				CurrentMap = new CollectablesMap();
			if (exit.Destination == 5)
				CurrentMap = new Skychaser1Map();
			// 6 is not in world hub
			if (exit.Destination == 7)
				CurrentMap = new Skychaser2Map();
			if (exit.Destination == 8)
				CurrentMap = new Skychaser2Map();
			if (exit.Destination == 9)
				CurrentMap = new Skychaser2Map();
		}
		else
		{
			// The exits that connects skychaser 1 and 2 together use Destination #6.
			// They are an anomaly, as all other exits go to/from the world hub.
			if (exit.Destination == 6)
			{
				if (CurrentMap is Skychaser1Map)
				{
					// The current map must be destroyed before reassignment
					CurrentMap.destroy();
					CurrentMap = new Skychaser2Map();
				}
				else
				{
					// The current map must be destroyed before reassignment
					CurrentMap.destroy();
					CurrentMap = new Skychaser1Map();
				}
			}
			else
			{
				//	If we're here, we know that we're headed to the world hub (since all other cases have been handled).

				// The current map must be destroyed before reassignment
				CurrentMap.destroy();
				CurrentMap = new WorldHub();
			}
		}

		// Unlock a new level once you've taken the newest exit
		var shouldAdd:Bool = true;
		for (i in 0...PersistenceManager.unlockedLevels.length)
		{
			if (PersistenceManager.unlockedLevels[i] == exit.Destination + 1)
			{
				shouldAdd = false;
			}
		}
		if (shouldAdd)
		{
			PersistenceManager.unlockedLevels.push(exit.Destination + 1);
			PersistenceManager.saveGame();
		}

		setSpawn(exit.Destination);
		// Reconciling exits is required to remove any locked/unimplmented exits from the game world.
		reconcileExits();
	}

	// A simple helper that reloads the current map.
	// The player's position is reset, but everything else (shinies, exits, etc.) are not, thanks to the PersistenceManager
	public static function resetMap()
	{
		if (CurrentMap is TutorialMap)
			CurrentMap = new TutorialMap();
		if (CurrentMap is WorldHub)
			CurrentMap = new WorldHub();
		if (CurrentMap is CollectablesMap)
			CurrentMap = new CollectablesMap();
		if (CurrentMap is Skychaser1Map)
			CurrentMap = new Skychaser1Map();
		if (CurrentMap is Skychaser2Map)
			CurrentMap = new Skychaser2Map();
	}

	private static function setSpawn(sourceDoor:Int)
	{
		// Exits come in pairs: every pair of exits' destinations always point at each other
		// This uses that assumption to find the Exit that forms a pair with the exit the player just took, so that they can be places near it.
		for (i in 0...CurrentMap.Exits.length)
		{
			var exit = cast(CurrentMap.Exits.members[i], Exit);
			if (exit.Destination == sourceDoor)
			{
				// Position the player close to the exit that takes them back where they just came from
				//	(SpawnX in the Exit class adds a small offset to the exit's position, so the player doesn't overlap with it)
				SpawnX = exit.SpawnX;
				SpawnY = exit.SpawnY;
			}
		}
	}

	// Removes all exits that the player hasn't unlocked yet.
	private static function reconcileExits()
	{
		var toRemove = [];
		for (i in 0...CurrentMap.Exits.length)
		{
			var exit = cast(CurrentMap.Exits.members[i], Exit);
			var remove:Bool = true;
			for (j in 0...PersistenceManager.unlockedLevels.length)
			{
				if (exit.Destination == PersistenceManager.unlockedLevels[j])
					remove = false;
			}
			if (remove)
				toRemove.push(exit);
		}
		for (i in 0...toRemove.length)
		{
			CurrentMap.Exits.remove(toRemove[i]);
		}
	}
}
