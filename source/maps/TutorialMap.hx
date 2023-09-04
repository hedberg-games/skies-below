package maps;

import flash.display.BitmapData;
import openfl.utils.Assets;

class TutorialMap extends MapBase
{
	public function get_tileSet():BitmapData
	{
		return Assets.getBitmapData("assets/art/TutorialTileMap.png");
	}

	public function get_tileLayout():String
	{
		return Assets.getText("assets/levels/Tutorial_Collision.csv");
	}

	public function get_spawnLayout():String
	{
		return Assets.getText("assets/levels/Tutorial_Spawn.csv");
	}

	public function get_shinyLayout():String
	{
		return Assets.getText("assets/levels/Tutorial_Shiny.csv");
	}

	// The Tutorial tileset uses 3 rows of background tiles
	public function get_collisionIndex()
	{
		return 30;
	}

	public function get_mapNumber()
	{
		return 0;
	}

	public function new()
	{
		super();
	}
}
