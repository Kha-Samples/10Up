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
		rightAnim = Animation.create(0);
		leftAnim = Animation.create(1);
		angle = -0.5;
		originX = 22 / 2;
		originY = 13 / 2;
	}
}
