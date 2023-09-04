package maps;

import flash.display.BitmapData;
import flixel.group.FlxGroup;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTilemap;

// Maps are created by inheriting from MapBase, and then overriding the abstract property getters to
// define things like tilesets, the position of walls, etc.
abstract class MapBase extends FlxTilemap
{
	// Portals to other maps
	public var Exits:FlxGroup = new FlxGroup();
	// Shinies that are present in the map
	public var Shinies:FlxGroup = new FlxGroup();

	public var _totalShinies:Int;
	public var totalShinies(get, default):Int;

	public function get_totalShinies():Int
	{
		return _totalShinies;
	}

	// Required properties (and backing fields):
	// An image containing every possible 8x8 tile that can appear in this map
	public var tileSet(get, never):BitmapData;

	public abstract function get_tileSet():BitmapData;

	// A comma-seperated list of tiles, where each number represents a specific index in the tileSet.
	// This completely defines the sprites and collision properties of every tile in the map.
	// All layout files for a single map must have identical dimensions, and every cell must have a value.
	public var tileLayout(get, never):String;

	public abstract function get_tileLayout():String;

	// A comma-seperated list of exits, where each number indicates the Map Number for that exit
	// Tiles without an exit are represeted with a 0
	public var spawnLayout(get, never):String;

	public abstract function get_spawnLayout():String;

	// A comma-seperated list of collectable locations
	// Tiles where a collectable should spawn are represented with a 1, everything else should be 0
	public var shinyLayout(get, never):String;

	public abstract function get_shinyLayout():String;

	// The index in the Tileset where collisions begin
	// Every tile below this value is a "background" tile, and will not block the player's movement.
	// For simplicity, the art for the tilesets is arranged so that collision tiles always start at the beginning a each row,
	// which makes the collisionIndex a multiple of 10.
	public var collisionIndex(get, never):Int;

	public abstract function get_collisionIndex():Int;

	// Every map requires have a unique number, to distinguish it from other maps
	// Map numbers are used for connecting exits to maps, as well as telling the Map Manager which map to generate
	// Duplicating an existing map number may produce undefined behavior.
	public var mapNumber(get, never):Int;

	public abstract function get_mapNumber():Int;

	public function new()
	{
		super();
		// Populates the FlxTileMap with tiles based on the (overrideable) properties
		loadMapFromCSV(tileLayout, tileSet, 8, 8, FlxTilemapAutoTiling.OFF, 0, 0, collisionIndex);

		var layout:String = spawnLayout;

		// Add any exits that appear in this map
		// The (hardcoded) limit of only 13 distinct maps is arbitrary, and may change if new maps are added.
		for (i in 1...13)
		{
			var xy = Utilities.FindInCsv(layout, Std.string(i));
			if (xy[0][0] != -1)
			{
				Exits.add(new Exit(xy[0][0], xy[0][1], i));
			}
		}

		// Add optional collectables using shinyLayout
		var arrShiny = Utilities.FindInCsv(shinyLayout, "1", true);
		_totalShinies = arrShiny.length;
		for (i in 0...arrShiny.length)
		{
			var x:Int = arrShiny[i][0];
			var y:Int = arrShiny[i][1];
			var addShiny:Bool = true;
			for (j in 0...PersistenceManager.collectedShinies.length)
			{
				// Don't add shinies that the player has already collected
				if (new ShinyBase(x, y, mapNumber).compare(PersistenceManager.collectedShinies[j]))
				{
					addShiny = false;
				}
			}
			if (addShiny)
			{
				Shinies.add(new Shiny(x, y, mapNumber));
			}
		}
	}
}
