package  
{
	import org.flixel.*;
	public class PreloaderState extends FlxState
	{
		
		override public function create():void 
		{
			super.create();
			MapManager.init();
			FlxG.mouse.show();
			//this.add("This game is played with a keyboard")
			this.add(new FlxButton(20, 20, "Click to play", play));
		}
		private function play() {
			FlxG.switchState(new PlayState());
			FlxG.mouse.hide();
		}
	}

}