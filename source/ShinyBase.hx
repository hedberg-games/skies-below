package  
{
	public class ShinyBase 
	{
		public var worldNumber:int;
		public var x:int;
		public var y:int;
		
		public function ShinyBase(_x:int, _y:int, _worldNumber:int) {
			x = _x;
			y = _y;
			worldNumber = _worldNumber;
		}
		
		public function compare(obj:ShinyBase):Boolean {
			return obj.x == x && obj.y == y && obj.worldNumber == worldNumber;
		}
	}

}