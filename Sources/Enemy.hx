package;

import kha.Image;
import kha.Loader;
import kha.Sprite;

class Enemy extends Sprite {
	private var killed: Bool;
	
	public function new(x: Float, y: Float) {
		super(Loader.the.getImage("enemy"), 16 * 4, 16 * 4, 0);
		killed = false;
		this.x = x;
		this.y = y;
	}

	public function kill() {
		killed = true;
	}
	
	public function isKilled(): Bool {
		return killed;
	}
	
	public override function hit(sprite: Sprite) {
		//Jumpman.getInstance().hitEnemy(this);
	}
}
