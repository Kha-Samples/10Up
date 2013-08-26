package;

import kha.Loader;
import kha.Sprite;

class Boss extends Sprite {
	public function new(x: Float, y: Float) {
		super(Loader.the.getImage("boss"), 10, 10);
		this.x = x;
		this.y = y;
	}
}
