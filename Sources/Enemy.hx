package;

import kha.Image;
import kha.Sprite;

class Enemy extends Sprite {
	private var killed: Bool;
	
	public function new(image: Image, width: Int, height: Int) {
		super(image, width, height, 0);
		killed = false;
	}

	public function kill() {
		killed = true;
	}
	
	public function isKilled(): Bool {
		return killed;
	}
	
	public override function hit(sprite: Sprite) {
		Jumpman.getInstance().hitEnemy(this);
	}
}
