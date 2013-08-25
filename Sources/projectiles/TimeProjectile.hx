package projectiles;

import kha.Direction;
import kha.Image;
import kha.math.Vector2;
import kha.Painter;
import kha.Scene;
import kha.Sprite;

class TimeProjectile extends Projectile {
	public function new(dir: Vector2, width:Int=0, height:Int=0, z:Int=1) {
		super(null, width, height, z);
		
		isTimeWeapon = true;
		speedx = 10 * dir.x;
		speedy = 10 * dir.y;
		accx = 0;
		accy = 0;
	}
	
	override public function render(painter:Painter):Void {
		painter.setColor( kha.Color.fromBytes(0, 255, 0) );
		painter.fillRect( x, y, width, height );
	}
}