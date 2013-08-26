package;

import kha.Animation;
import kha.Loader;
import kha.math.Vector2;
import kha.Rotation;
import kha.Sprite;

class GrapleHook extends Sprite {
	public var rightAnim(default, null) : Animation;
	public var leftAnim(default, null) : Animation;
	
	public function new() {
		super(Loader.the.getImage("graplehook"), 22, 13, 4);
		rightAnim = Animation.create( 0 );
		leftAnim = Animation.create( 1 );
		rotation = new Rotation(new Vector2(22 / 2, 13 / 2), -0.5);
	}
}
