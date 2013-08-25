package;

import kha.Image;
import kha.Loader;
import kha.Sprite;

class Enemy extends DestructibleSprite {
	private var killed: Bool;
	
	public function new(x: Float, y: Float) {
		super(Loader.the.getImage("enemy"), 16 * 4, 16 * 4, 0);
		killed = false;
		this.x = x;
		this.y = y;
		health = 50;
	}
	
	override private function set_health(value:Int):Int {
		if ( value <= 0 ) {
			kill();
		} else if ( value < _health ) {
			trace ( 'new health: $value' );
			// TODO: pain cry
		}
		return super.set_health(value);
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
