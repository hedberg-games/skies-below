package 
{
	import org.flixel.*;
	public class Main extends FlxGame
	{
		public function Main() {
			var width = 320;
			var height = 240;
			var zoom = Math.max(Math.floor(Math.min(stage.stageWidth / width, stage.stageHeight / height)), 1);
			
			super(width, height, PreloaderState, zoom);
		}
		
		
	}
	
}