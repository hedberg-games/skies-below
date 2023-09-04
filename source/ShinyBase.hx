package;

// A simple data-only object that uniquely identifies a particular shiny.
class ShinyBase
{
	public var worldNumber:Int;
	public var x:Int;
	public var y:Int;

	public function new(_x:Int, _y:Int, _worldNumber:Int)
	{
		x = _x;
		y = _y;
		worldNumber = _worldNumber;
	}

	// Two shinies in the exact same place are defined to be same shiny (useful for comparing shinies stored in different lists)
	public function compare(obj:ShinyBase):Bool
	{
		return obj.x == x && obj.y == y && obj.worldNumber == worldNumber;
	}
}
