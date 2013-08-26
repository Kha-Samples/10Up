package;

import kha.Loader;
import kha.Sprite;

class Gate extends Sprite {
	public function new(x: Float, y: Float) {
		super(Loader.the.getImage("gate"), 16 * 2, 96 * 2);
		this.x = x;
		this.y = y;
		accy = 0;
	}
}
