package;

import kha.Assets;
import kha2d.Animation;
import kha.math.Vector2;
import kha.Rotation;
import kha2d.Sprite;

class GrapleHook extends Sprite {
	public var rightAnim(default, null) : Animation;
	public var leftAnim(default, null) : Animation;
	
	public function new() {
		super(Assets.images.graplehook, 22, 13, 4);
		rightAnim = Animation.create(0);
		leftAnim = Animation.create(1);
		angle = -0.5;
		originX = 22 / 2;
		originY = 13 / 2;
	}
}
