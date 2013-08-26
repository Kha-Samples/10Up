package;

import kha.Loader;
import kha.Sprite;

class Gatter extends Sprite {
	public function new(x: Float, y: Float) {
		super(Loader.the.getImage("gatter"), 32 * 2, 6 * 2);
		this.x = x;
		this.y = y;
		accy = 0;
	}	
}
