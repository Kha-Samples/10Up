package;

import kha.Loader;
import kha.Sprite;

class Window extends Sprite {
	public function new(x: Float, y: Float) {
		super(Loader.the.getImage("window"), 10, 10);
		this.x = x;
		this.y = y;
	}
}
