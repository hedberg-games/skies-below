package  
{
	import Maps.MapBase;
	import org.flixel.FlxSprite;
	public class Exit extends FlxSprite
	{
		[Embed(source="../art/Exit.png")]
		protected var ExitImage:Class;
		
		public function get SpawnX():int {
			return this.x + 16;
		}
		public function get SpawnY():int {
			return this.y;
		}
		
		public var Destination:int;
		public function Exit(x:int, y:int, dest:int) 
		{
			super(x * 8, y * 8);
			Destination = dest;
			loadGraphic(ExitImage, true, false, 8, 8);
			addAnimation("idle", new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11), 40, true);
			play("idle");
		}
		
	}

}