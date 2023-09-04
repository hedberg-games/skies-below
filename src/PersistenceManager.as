package  
{
	import org.flixel.FlxSave;
	public class PersistenceManager 
	{
		
		public static var unlockedLevels:Array = [2];
		public static var collectedShinies:Array = [];
		
		public static function collectShiny(shiny:Shiny) {
			collectedShinies.push(shiny.base);
			saveGame();
		}
		public static function countCollectedShinies(mapNumber:int):int {
			var counter = 0;
			for (var i:int = 0; i < collectedShinies.length; i++) 
			{
				if (collectedShinies[i].worldNumber == mapNumber)
					counter++;
			}
			return counter;
		}
		
		private static var _save:FlxSave = null;
		private static var _saveBound:Boolean = false;
		
		public static function saveGame():void {
			if (_save == null){
				_save = new FlxSave();
				_saveBound = _save.bind("tableFlip");
			}
			if(_saveBound){
				_save.data.unlockedLevels = unlockedLevels;
				_save.data.collectedShinies = collectedShinies;
			}
		}
		public static function loadGame():Boolean {
			if (_save == null){
				_save = new FlxSave();
				_saveBound = _save.bind("tableFlip");
			}
			if(_saveBound && _save.data.unlockedLevels){
				unlockedLevels = _save.data.unlockedLevels;
				for (var i:int = 0; i < _save.data.collectedShinies.length; i++) 
				{
					collectedShinies.push(new ShinyBase(_save.data.collectedShinies[i].x, _save.data.collectedShinies[i].y, _save.data.collectedShinies[i].worldNumber));
				}
				//collectedShinies = ;
				return true;
			}
			return false;
		}
	}

}