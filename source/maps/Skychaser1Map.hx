package maps;

import flash.display.BitmapData;
import openfl.utils.Assets;

class Skychaser1Map extends MapBase
{
	// Both Skychaser 1 and 2 share the same tileset
	public function get_tileSet():BitmapData
	{
		return Assets.getBitmapData("assets/art/SkyChaser.png");
	}

	public function get_tileLayout():String
	{
		return Assets.getText("assets/levels/Skychaser1_Collision.csv");
	}

	public function get_spawnLayout():String
	{
		return Assets.getText("assets/levels/Skychaser1_Spawn.csv");
	}

	public function get_shinyLayout():String
	{
		return Assets.getText("assets/levels/Skychaser1_Shiny.csv");
	}

	// There are more background tiles in Skychaser tileset than the Tutorial
	public function get_collisionIndex()
	{
		return 50;
	}

	public function get_mapNumber()
	{
		return 3;
	}

	public function new()
	{
		super();
	}
}
