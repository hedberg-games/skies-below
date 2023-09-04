package  
{
	import org.flixel.*;
	public class Shiny extends FlxSprite
	{
		private var _base:ShinyBase;
		public function get base():ShinyBase {
			return _base;
		}
		
		[Embed(source="../art/Shiny.png")]
		private var spriteSheet:Class;
		
		
		public function Shiny(x:int, y:int, worldNumber:int) 
		{
			_base = new ShinyBase(x, y, worldNumber);
			super(x*8, y*8);
			this.loadGraphic(spriteSheet, true, false, 8, 8);
			this.addAnimation("idle", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 13);
			this.play("idle");
		}
		
	}

}