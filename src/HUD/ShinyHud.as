package HUD 
{
	import Maps.MapBase;
	import org.flixel.*;
	public class ShinyHud extends FlxGroup
	{
		
		public function updateShinyCount():void {
			currentShinyCounter.text = PersistenceManager.countCollectedShinies(mapNumber).toString();
		}
		
		private var currentShinyCounter:FlxText;
		private var totalShinyCounter:FlxText;
		private var mapNumber:int;
		
		public function ShinyHud(map:MapBase) 
		{
			mapNumber = map.mapNumber;
			var current:int = PersistenceManager.countCollectedShinies(map.mapNumber);
			var total:int = map.totalShinies;
			var x:int = 14;
			var y:int = 5;
			var icon:FlxSprite = new Shiny(1, 1, -1);
			
			this.add(icon);
			currentShinyCounter = new FlxText(x, y, 16, current.toString());
			x += 16;
			var transitionText:FlxText = new FlxText(x, y, 4, "/");
			this.add(transitionText);
			x += 4;
			totalShinyCounter = new FlxText(x, y, 16, total.toString());
			this.add(currentShinyCounter);
			this.add(totalShinyCounter);
			
			currentShinyCounter.alignment = transitionText.alignment = totalShinyCounter.alignment = "right";
			//Stick to screen:
			icon.scrollFactor = currentShinyCounter.scrollFactor = transitionText.scrollFactor = totalShinyCounter.scrollFactor = new FlxPoint(0,0);
		}
	}

}