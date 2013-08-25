package;

import kha.Loader;
import kha.Scene;
import kha.Sprite;

class Door extends Sprite {
	public function new(x: Int, y: Int) {
		super(Loader.the.getImage("door"), 32, 64, 0);
		this.x = x;
		this.y = y;
		accy = 0;
	}
	
	public override function hit(sprite: Sprite) {
		
	}
}