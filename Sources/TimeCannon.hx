package ;

import kha.Animation;
import kha.Image;
import kha.math.Vector2;
import kha.Painter;
import kha.Rotation;
import kha.Sprite;


class TimeCannon extends Sprite {
	public var rightAnim(default, null) : Animation;
	public var leftAnim(default, null) : Animation;
	public function new() {
		super(kha.Loader.the.getImage("timecannon"), 44, 20, 4);
		
		rightAnim = new Animation( [0, 1, 2, 2, 1, 0], 30 );
		leftAnim = new Animation( [3, 4, 5, 5, 4, 3], 30 );
		
		rotation = new Rotation(new Vector2( width-4, 0.5 * height ), -0.5);
	}
	
	override public function render(painter:Painter):Void {
		painter.drawImage2(image, Std.int(animation.get() * width) % image.width, Math.floor(animation.get() * width / image.width) * height, width, height, Math.round(x - collider.x), Math.round(y - collider.y), width, height, rotation);
	}
}