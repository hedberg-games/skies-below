package;

import flixel.*;
import flixel.util.*;
import openfl.geom.Point;

class Character extends FlxSprite
{
	// Constants:
	private final spriteSheet:String = "assets/art/newCharacter.png";
	private final jumpSpeed:Int = 3;
	private final speed:Int = 1;
	private final maxFallSpeed:Int = 4;
	private final UpsideDownLeft:FlxDirection = UP;
	private final UpsideDownRight:FlxDirection = DOWN;

	// Variables:
	// How fast is the character currently falling (regardless of direction)
	private var fallSpeed:Float = 3;
	// The direction of gravity (1 is normal, -1 is inverted)
	private var fallDirection:Int = 1;

	// Property backing Fields (denoted byS the "_" prefix):
	private var _isFlipping:Bool;

	// Properties (getters/setters):
	// Whether the character is in the middle of a gravity change
	public var isFlipping(get, set):Bool;

	function get_isFlipping()
	{
		return _isFlipping;
	}

	function set_isFlipping(val:Bool):Bool
	{
		var animation:String = "";
		if (val)
		{
			animation = "fade";
		}
		else
		{
			animation = "flash";
		}
		if (this.getFloor() == FLOOR)
		{
			animation += "Up";
		}
		else
		{
			animation += "Down";
		}
		this.animation.play(animation);
		_isFlipping = val;

		return _isFlipping;
	}

	// Simple helper to get the "floor" relative to gravity (rather than in absolute terms)
	private function getFloor():FlxDirectionFlags
	{
		if (fallDirection < 0)
		{
			return CEILING;
		}
		return FLOOR;
	}

	// Simple helper to get the "ceiling" relative to gravity (rather than in absolute terms)
	private function getCeiling():FlxDirectionFlags
	{
		if (getFloor() == FLOOR)
		{
			return CEILING;
		}
		return FLOOR;
	}

	public function new(x:Int, y:Int)
	{
		var fadeSpeed = 40;
		super(x, y);
		loadGraphic(spriteSheet, true, 8, 8);

		// Record hardcoded animations
		// "Up" and "Down" refer to whether the character is oriented normally ("Up") or with inverted gravity ("Down")
		this.animation.add("idleUp", [0]);
		this.animation.add("idleDown", [30]);
		this.animation.add("fadeUp", [19, 18, 17, 16, 15, 14, 13, 12, 11, 10], fadeSpeed, false);
		this.animation.add("fadeDown", [29, 28, 27, 26, 25, 24, 23, 22, 21, 20], fadeSpeed, false);
		this.animation.add("flashUp", [10, 11, 12, 13, 14, 15, 16, 17, 18, 19], fadeSpeed * 2, false);
		this.animation.add("flashDown", [20, 21, 22, 23, 24, 25, 26, 27, 28, 29], fadeSpeed * 2, false);

		// Sprite can flip to face left/right
		this.setFacingFlip(RIGHT, false, false);
		this.setFacingFlip(LEFT, true, false);

		this.animation.play("idleUp");
	}

	public override function update(elapsed:Float)
	{
		// Collect any x/y changes into variable (they will be applied to the character later)
		var delta = new Point(0, 0);

		// Normal character behavior is only possible when not flipping
		if (!this.isFlipping)
		{
			if (FlxG.keys.pressed.LEFT)
			{
				this.facing = LEFT;
				delta.x = -speed;
			}
			if (FlxG.keys.pressed.RIGHT)
			{
				this.facing = RIGHT;
				delta.x = speed;
			}

			// The flip is triggered upon touching the ground after falling far enough to reach terminal velocity
			var shouldFlip:Bool = justTouched(getFloor()) && fallSpeed >= maxFallSpeed;

			// Use relative "floor", so the same code works regardless of gravity
			if (this.isTouching(getFloor()))
			{
				if (FlxG.keys.justPressed.SPACE)
				{
					fallSpeed = -jumpSpeed;
				}
				else
				{
					fallSpeed = .1;
				}
			}
			else
			{
				if (fallSpeed < maxFallSpeed)
				{
					fallSpeed += .1;
				}
			}

			// bump head on ceiling
			if (isTouching(getCeiling()) && fallSpeed < 0)
			{
				fallSpeed = 0;
			}

			delta.y += fallSpeed * fallDirection;

			if (shouldFlip)
			{
				// Setting isFlipping locks controls and triggers animation
				isFlipping = true;
				// Invert gravity
				fallDirection *= -1;
			}
		}
		else
		{
			// When flipping, simply "fall" at a fixed rate
			delta.y = fallDirection * -1;
			// External code is responsible for controlling when the character stops flipping, so nothing else to do here.
		}

		super.update(elapsed);

		// Position changes have to be applied after super.update (otherwise collisions can't tell how the object moved)
		x += delta.x;
		y += delta.y;
	}
}
