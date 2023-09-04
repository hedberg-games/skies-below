package  
{
	import Maps.*;
	public class MapManager 
	{
		//init MUST be called first- no static constructors :(
		public static function init() {
			var hasSave = PersistenceManager.loadGame();
			if (hasSave) {
				CurrentMap = new WorldHub();
				setSpawn(2);
			}
			else{
				CurrentMap = new TutorialMap();
				setSpawn(1);
			}
			
			reconcileExits();
		}
		
		public static var CurrentMap:MapBase;
		//Note: The worldHub makes this more complicated- it will need custom spawn locations.
		//		Also will need to detect which goal is used
		
		public static var SpawnX:int;
		public static var SpawnY:int;
		
		public static function changeMap(exit:Exit):void {
			//Control which map is loaded (WorldHub)
			
			if (CurrentMap is WorldHub) {
				//TODO: More robust routing?
				if(exit.Destination == 2)
					CurrentMap = new TutorialMap();
				if(exit.Destination == 3)
					CurrentMap = new CollectablesMap();	
				if(exit.Destination == 4)
					CurrentMap = new CollectablesMap();	
				if(exit.Destination == 5)
					CurrentMap = new Skychaser1Map();
				//6 is not in world hub
				//if(exit.Destination == 6)
				//	CurrentMap = new Skychaser1Map();
				if(exit.Destination == 7)
					CurrentMap = new Skychaser2Map();
				if(exit.Destination == 8)
					CurrentMap = new Skychaser2Map();
				if(exit.Destination == 9)
					CurrentMap = new Skychaser2Map();
			}
			else {
				if (exit.Destination == 6) {
					if (CurrentMap is Skychaser1Map) {
						CurrentMap = new Skychaser2Map();
					}
					else {
						CurrentMap = new Skychaser1Map();
					}
				}
				else{
					CurrentMap = new WorldHub();
			
					}
			}
			//Unlock a new level once you've taken the newest exit!
			var shouldAdd:Boolean = true;
			for (var i:int = 0; i < PersistenceManager.unlockedLevels.length; i++) 
			{
				if (PersistenceManager.unlockedLevels[i] == exit.Destination +1) {
					shouldAdd = false;
				}
			}
			
			if(shouldAdd)
			{
				PersistenceManager.unlockedLevels.push(exit.Destination + 1);
				PersistenceManager.saveGame();
			}
			setSpawn(exit.Destination);
			reconcileExits();
		}
		
		public static function resetMap() {
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
		
		private static function setSpawn(sourceDoor:int) {
			for (var i:int = 0; i < CurrentMap.Exits.length; i++) 
			{
				var exit = CurrentMap.Exits.members[i] as Exit;
				if (exit.Destination == sourceDoor) {
					SpawnX = exit.SpawnX;
					SpawnY = exit.SpawnY;
				}
			}
			//CurrentMap.Exits
		}
		private static function reconcileExits() {
			var toRemove:Array = [];
			for (var i:int = 0; i < CurrentMap.Exits.length; i++) 
			{
				var exit = CurrentMap.Exits.members[i] as Exit;
				var remove:Boolean = true;
				for (var j:int = 0; j < PersistenceManager.unlockedLevels.length ; j++) 
				{
					if (exit.Destination == PersistenceManager.unlockedLevels[j])
					remove = false;
				}
				if (remove) {
					toRemove.push(exit);
				}				
			}
			for (var k:int = 0; k < toRemove.length; k++) 
			{
				//Unpleasant to look at, but it works
				//Simply removes one item, that matches toRemove[k]
				CurrentMap.Exits.members.splice(CurrentMap.Exits.members.indexOf(toRemove[k]), 1);
			}
		}
	}

}