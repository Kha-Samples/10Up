package;

import kha.Animation;
import kha.Loader;
import kha.Sprite;

class Car extends DestructibleSprite {
	private var repaired = false;
	
	public function new(x: Float, y: Float) {
		super(100, Loader.the.getImage("car"), 100 * 2, 41 * 2);
		this.x = x;
		this.y = y;
		health = 0;
		isRepairable = true;
	}
	
	override private function set_health(value: Int): Int {
		if (value == 100) {
			repaired = true;
			speedx = 20;
			setAnimation(Animation.create(1));
		}
		return super.set_health(value);
	}
}
