package;

import kha.Loader;
import kha.math.Random;
import kha.Painter;
import kha.Scene;
import kha.Sprite;

class Window extends Sprite {
	private var visible = true;
	
	public function new(x: Float, y: Float) {
		super(Loader.the.getImage("window"), 16 * 2, 80 * 2);
		this.x = x;
		this.y = y;
		accy = 0;
	}
	
	override public function hit(sprite: Sprite): Void {
		if (visible) {
			visible = false;
			for (i in 0...100) Scene.the.addOther(new Glass(x + Random.getUpTo(16 * 2), y + Random.getUpTo(16 * 2)));
		}
	}
	
	override public function render(painter: Painter): Void {
		if (visible) super.render(painter);
	}
}
