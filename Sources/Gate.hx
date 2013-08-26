package;

import kha.Loader;
import kha.Sprite;

class Gate extends Sprite {
	public function new(x: Float, y: Float) {
		super(Loader.the.getImage("gate"), 10, 10);
		this.x = x;
		this.y = y;
	}
}
