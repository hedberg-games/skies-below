package  Maps
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
	//All specific maps inherit from this MapBase class
	public class MapBase extends FlxTilemap
	{
		//Starting position: should be set somehow
		public var Exits:FlxGroup = new FlxGroup();
		public var Shinys:FlxGroup = new FlxGroup();
		public function get totalShinies():int {
			return _totalShinies;
		}
		
		private var _totalShinies:int;
		
		
		//Import .png here
		protected function get tileSet(): Class { return null; }
		//Import .csv here
		protected function get tileLayout(): Class{return null;}
		
		//Import .csv for teleporters here
		protected function get spawnLayout(): Class { return null; }
		
		//Import .csv for collectable spawns here
		protected function get shinyLayout(): Class{return null;}
		
		//Store collision index
		protected function get collisionIndex():int { return null; }
		
		//Store Map Number
		public function get mapNumber():int{return null;}
		
		public function MapBase() {
			super();
			loadMap(new tileLayout, tileSet, 8, 8, FlxTilemap.OFF, 0, 0, collisionIndex);
			
			var layout:String = new spawnLayout;
			
			//TODO: Find a way to compile these , rather than find them at runtime
			for (var i:int = 1; i < 13; i++) 
			{
				var xy:Array = Utilities.FindInCsv(layout, i.toString());
				if (xy[0] != -1) {
					Exits.add(new Exit(xy[0], xy[1], i));
				}
			}
			
			//Add optional collectables using shinyLayout
			var arrShiny:Array = Utilities.FindInCsv(new shinyLayout, "1", true);
			this._totalShinies = arrShiny.length;
			for (var k:int = 0; k < arrShiny.length; k++) 
			{
				var x:int = arrShiny[k][0];
				var y:int = arrShiny[k][1];
				var addShiny:Boolean = true;
				for (var j:int = 0; j < PersistenceManager.collectedShinies.length; j++) 
				{
					if (new ShinyBase(x, y, mapNumber).compare(PersistenceManager.collectedShinies[j])) {
						addShiny = false;
					}
				}
				if (addShiny) {
					Shinys.add(new Shiny(x, y, mapNumber));
				}
			}
		}
	}

}