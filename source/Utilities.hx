package;

class Utilities
{
	// A simple helper that finds the x/y position of a particular sting inside a csv file
	// FindAll controls whether every instance is returned, or only the first one
	// The return value is an array of x/y pairs. When findAll is true, it may be empty, but if it is false, a non-match returns [-1,-1]
	// (This approach means that when you look up a single value, you can always use [0] to access the result, even if the string isn't anywhere in the csv.)
	public static function FindInCsv(csv:String, value:String, findAll:Bool = false):Array<Array<Int>>
	{
		var retVal:Array<Array<Int>> = [];
		var rows = csv.split("\n");
		for (i in 0...rows.length)
		{
			var cols = rows[i].split(",");
			for (j in 0...cols.length)
			{
				if (value == cols[j])
				{
					if (!findAll)
						return [[j, i]];
					retVal.push([j, i]);
				}
			}
		}
		if (!findAll)
			return [[-1, -1]];
		return retVal;
	}
}
