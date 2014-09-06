package;

import kha.Animation;
import kha.graphics2.Graphics;
import kha.Image;
import kha.math.Matrix3;
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
		
		angle = -0.5;
		scaleX = width - 4;
		scaleY = 0.5 * height;
	}
	
	override public function render(g: Graphics): Void {
		g.pushTransformation(g.transformation * Matrix3.translation(x + originX, y + originY) * Matrix3.rotation(angle) * Matrix3.translation(-x - originX, -y - originY));
		g.drawScaledSubImage(image, Std.int(animation.get() * width) % image.width, Math.floor(animation.get() * width / image.width) * height, width, height, Math.round(x - collider.x), Math.round(y - collider.y), width, height);
		g.popTransformation();
	}
}
