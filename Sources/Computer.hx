package;

import kha.Loader;
import kha.Sprite;

class Computer extends Sprite {
	public function new(x: Float, y: Float ) {
		super(Loader.the.getImage("computer"), 10, 10);
		this.x = x;
		this.y = y;
	}	
}
