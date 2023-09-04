package  
{
	import HUD.ShinyHud;
	import Maps.MapBase;
	import Maps.TutorialMap;
	import org.flixel.*;
	public class PlayState extends FlxState
	{
		[Embed(source="../art/TileMap1.png")]
		private var TileSet:Class;
		
		//[Embed(source="../levels/mapCSV_Group1_Map1.csv", mimeType="application/octet-stream")]
		private var TileLayout:Class;
		
		private var character:Character;
		private var map:MapBase;
		private var exit:FlxSprite;
		
		private var shinyHud:ShinyHud;
		
		override public function create():void 
		{
			FlxG.flash(0xff000000, .2);
			super.create();
			map = MapManager.CurrentMap; 
			this.add(map);
			character = new Character(MapManager.SpawnX, MapManager.SpawnY);
			this.add(character);
			
			
			//Add the Exit
			this.add(map.Exits);
			
			//Add shinies (if any)
			this.add(map.Shinys);
			
			//Auto-follow with camera
			//FlxG.camera.setBounds(FlxG.camera.width * -0.5, FlxG.camera.height * -0.5, map.width+FlxG.camera.width*.5, map.height+FlxG.camera.height*.5, true);
			FlxG.camera.setBounds(0, 0,map.width, map.height, true);
			FlxG.camera.follow(character);
			
			
			//HUD for how many shinies...
			shinyHud = new ShinyHud(map);
			add(shinyHud);
		}
		
		override public function update():void 
		{
			super.update();
			if (!map.getBounds().overlaps(new FlxRect(character.x, character.y, 8,8))) {
				//Reset character position
				FlxG.fade(0xcccc5555, .3, function() {
					MapManager.resetMap();
					FlxG.resetState();
				});
			}
			if(!character.isFlipping){
				FlxG.collide(map, character);
			}
			else {
				//Setting this plays the animation
				if(!character.overlaps(map))
					character.isFlipping = false;
			}
			
			FlxG.overlap(character, map.Shinys, function(obj1, obj2) {
				var shiny = obj2 as Shiny;
				if (shiny == null)
					shiny = obj1 as Shiny;
				PersistenceManager.collectShiny(shiny);
				//Explicitly calling for performance
				shinyHud.updateShinyCount();
				map.Shinys.remove(shiny);
			});
			var self:FlxState = this;
			FlxG.overlap(character, map.Exits, function(obj1, obj2) {
				FlxG.fade(0xff000000, .3, function() {
				//TODO: more gradual transition...
					var exit = obj2 as Exit;
					if (exit == null)
						exit = obj1 as Exit;
					MapManager.changeMap(exit);
					FlxG.resetState();
				});
			});
			
			
		}
	}

}