package  
{
	public class Utilities 
	{
		//returns [x,y] location of value
		public static function FindInCsv(csv:String, value:String, findAll:Boolean = false):Array {
			var retVal = [];
			var rows:Array = [];
			rows=csv.split("\n");
			for(var i:int=0;i<rows.length;i++)
			{
				var cols:Array=rows[i].split(",");
				for (var j = 0; j < cols.length; j++) {
					if (value == cols[j]) {
						if(!findAll)
							return [j, i];
						retVal.push([j, i]);
					}
				}
			}
			if(!findAll)
				return [ -1, -1];
			return retVal;
		}
	}
}