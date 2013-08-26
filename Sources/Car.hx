package;

import kha.Loader;
import kha.Sprite;

class Car extends Sprite {
	public function new(x: Float, y: Float) {
		super(Loader.the.getImage("car"), 100 * 2, 41 * 2);
		this.x = x;
		this.y = y;
	}
}
