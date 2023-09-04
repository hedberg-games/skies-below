package  
{
	import org.flixel.*;
	public class Character extends FlxSprite
	{
		//[Embed(source="../art/character.png")]
		[Embed(source="../art/newCharacter.png")]
		private var spriteSheet:Class;
		
		
		
		private var fallSpeed:Number = .3;
		private var fallDirection:int = 1;
		public function get isFlipping():Boolean {
			return _isFlipping;
		}
		public function set isFlipping(val:Boolean) {
			var animation:String = "";
			if (val) {
				animation = "fade";
			}
			else {
				animation = "flash";
			}
			if (this.getFloor() == FLOOR)
				animation += "Up";
			else
				animation += "Down";
			play(animation);
			_isFlipping = val;
		}
		
		private var _isFlipping:Boolean = false;
		
		//Constants
		private var jumpSpeed:Number = 3;
		private var speed:int = 1;
		private var maxFallSpeed:Number = 4;
		
		private function getFloor() {
			if (fallDirection > 0)
				return FLOOR;
			return CEILING;
		}
		private function getCeiling() {
			if (getFloor() == FLOOR)
				return CEILING;
			return FLOOR;
		}
		
		public function Character(x:int, y:int) 
		{
			var fadeSpeed = 40;
			super(x, y);
			this.loadGraphic(spriteSheet, true, true, 8, 8);
			this.addAnimation("idleUp", [0]);
			this.addAnimation("idleDown", [30]);
			this.addAnimation("fadeUp", [19, 18, 17, 16, 15, 14, 13, 12, 11, 10], fadeSpeed, false);
			this.addAnimation("fadeDown", [29, 28, 27, 26, 25, 24, 23, 22, 21, 20], fadeSpeed, false);
			this.addAnimation("flashUp", [10, 11, 12, 13, 14, 15, 16, 17, 18, 19], fadeSpeed*2, false);
			this.addAnimation("flashDown", [20, 21, 22, 23, 24, 25, 26, 27, 28, 29], fadeSpeed*2, false);
			this.play("idleUp");
			
		}
		
		//TODO: Flip animation
		override public function update():void 
		{
			if(!this.isFlipping){
				if (FlxG.keys.LEFT) {
					this.facing = LEFT;
					this.x -= speed;
				}
				if (FlxG.keys.RIGHT) {
					this.facing = RIGHT;
					this.x += speed;
				}
				var shouldFlip:Boolean = this.justTouched(getFloor()) && this.fallSpeed >= maxFallSpeed;
					
				if (this.isTouching(getFloor())){
					if (FlxG.keys.justPressed("SPACE"))
						this.fallSpeed = jumpSpeed * -1;
					else{
						this.fallSpeed = .1;
					}
				}
				else {
					if(this.fallSpeed < maxFallSpeed)
						this.fallSpeed += .1;
				}
				
				//bumped head on ceiling
				if (this.isTouching(getCeiling()) && this.fallSpeed < 0)
					this.fallSpeed = 0;
				
				this.y += fallSpeed * fallDirection;
				
				if (shouldFlip) {
					//TableFlip!!
					isFlipping = true;
					fallDirection = fallDirection * -1;
				}
			}
			else {
				this.y += this.fallDirection *-1;
			}
			
			super.update();
		}
	}

}