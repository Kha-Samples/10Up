package ;

import kha.Animation;
import kha.Image;
import kha.math.Vector2;
import kha.Rotation;
import kha.Sprite;


class TimeCannon extends Sprite {
	public var rightAnim(default, null) : Animation;
	public var leftAnim(default, null) : Animation;
	public function new() {
		super(kha.Loader.the.getImage("timecannon"), 44, 20, 4);
		
		rightAnim = new Animation( [0, 1, 2, 2, 1, 0], 30 );
		leftAnim = new Animation( [3, 4, 5, 5, 4, 3], 30 );
		
		rotation = new Rotation(new Vector2( 35.0, 0.5 * height ), -0.5);
	}
	
}