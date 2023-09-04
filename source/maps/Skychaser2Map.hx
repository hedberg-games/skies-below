package Maps 
{
	public class Skychaser2Map extends MapBase
	{
		
		//Import .png here
		[Embed(source="../../art/SkyChaser.png")]
		protected var _tileSet: Class;
		override protected function get tileSet():Class 
		{
			return _tileSet;
		}
		//Import .csv here
		[Embed(source="../../levels/mapCSV_Skychaser2_CollisionLayer.csv", mimeType="application/octet-stream")]
		protected var _tileLayout: Class;
		override protected function get tileLayout():Class 
		{
			return _tileLayout;
		}
		
		//Import .csv for doodad spawns here
		[Embed(source="../../levels/mapCSV_Skychaser2_SpawnLayer.csv", mimeType="application/octet-stream")]
		protected var _spawnLayout: Class;
		override protected function get spawnLayout():Class 
		{
			return _spawnLayout;
		}
		
		//Import .csv for collectable spawns here
		[Embed(source="../../levels/mapCSV_Skychaser2_ShinyLayer.csv", mimeType="application/octet-stream")]
		protected var _shinyLayout: Class;
		override protected function get shinyLayout():Class 
		{
			return _shinyLayout;
		}
		
		//Store collision index
		protected var _collisionIndex:int = 50;
		override protected function get collisionIndex():int 
		{
			return _collisionIndex;
		}
		
		//Store Map Number
		override public function get mapNumber():int{
			return 4;
		}
		
		public function Skychaser2Map() {
			super();
		}
	}

}