package;

import kha.Assets;
import kha.audio1.Audio;
import kha2d.Animation;
import kha.Sound;
import kha2d.Sprite;

class Car extends DestructibleSprite {
	private var repaired = false;
	private var startSound: Sound;
	
	public function new(x: Float, y: Float) {
		super(100, Assets.images.car, 100 * 2, 41 * 2, 0);
		this.x = x;
		this.y = y;
		health = 0;
		isRepairable = true;
		isLiftable = true;
		startSound = Assets.sounds.carstart;
	}
	
	override private function set_health(value: Int): Int {
		if (value == 100) {
			repaired = true;
			speedx = 20;
			setAnimation(Animation.create(1));
			Audio.play(startSound);
		}
		return super.set_health(value);
	}
}
