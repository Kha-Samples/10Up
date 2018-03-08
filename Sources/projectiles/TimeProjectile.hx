package projectiles;

import kha.Assets;
import kha.audio1.Audio;
import kha2d.Animation;
import kha2d.Direction;
import kha.Image;
import kha.math.Vector2;
import kha2d.Scene;
import kha2d.Sprite;

class TimeProjectile extends Projectile {
	public function new(dir: Vector2, z:Int=9) {
		super( Assets.images.TimeProjectile, 20, 20, z);
		
		setAnimation( new Animation( [0, 1, 2, 2, 1, 0], 30 ) );
		
		isTimeWeapon = true;
		speedx = 5 * dir.x;
		speedy = 5 * dir.y;
		accx = 0;
		accy = 0;
		Audio.play(Assets.sounds.timeshot);
	}
}
