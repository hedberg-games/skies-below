package maps;

import flash.display.BitmapData;
import openfl.utils.Assets;

class WorldHub extends MapBase
{
	// The World Hub has a unique tileset
	public function get_tileSet():BitmapData
	{
		return Assets.getBitmapData("assets/art/WorldHubTileSet.png");
	}

	public function get_tileLayout():String
	{
		return Assets.getText("assets/levels/Hub_Collision.csv");
	}

	public function get_spawnLayout():String
	{
		return Assets.getText("assets/levels/Hub_Spawn.csv");
	}

	public function get_shinyLayout():String
	{
		return Assets.getText("assets/levels/Hub_Shiny.csv");
	}

	// The WorldHub tileset has only 1 row of background tiles
	public function get_collisionIndex()
	{
		return 10;
	}

	public function get_mapNumber()
	{
		return 1;
	}

	public function new()
	{
		super();
	}
}
