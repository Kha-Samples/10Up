package projectiles;

import kha.Animation;
import kha.Direction;
import kha.Image;
import kha.math.Vector2;
import kha.Loader;
import kha.Scene;
import kha.Sprite;

class TimeProjectile extends Projectile {
	public function new(dir: Vector2, z:Int=9) {
		super( Loader.the.getImage( "TimeProjectile" ), 20, 20, z);
		
		setAnimation( new Animation( [0, 1, 2, 2, 1, 0], 30 ) );
		
		isTimeWeapon = true;
		speedx = 5 * dir.x;
		speedy = 5 * dir.y;
		accx = 0;
		accy = 0;
		Loader.the.getSound("timeshot").play();
	}
}