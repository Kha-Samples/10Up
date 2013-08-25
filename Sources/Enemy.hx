package;

import kha.Animation;
import kha.Image;
import kha.Loader;
import kha.Sprite;

class Enemy extends DestructibleSprite {
	private var killed: Bool;
	private var walkLeft: Animation;
	private var walkRight: Animation;
	private var standLeft: Animation;
	private var standRight: Animation;
	
	public function new(x: Float, y: Float) {
		super(Loader.the.getImage("enemy"), 16 * 4, 16 * 4, 0);
		killed = false;
		this.x = x;
		this.y = y;
		health = 50;
		walkLeft = new Animation([2, 3, 4, 3], 6);
		walkRight = new Animation([7, 8, 9, 8], 6);
		standLeft = Animation.create(5);
		standRight = Animation.create(6);
		setAnimation(walkRight);
		speedx = 3;
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
