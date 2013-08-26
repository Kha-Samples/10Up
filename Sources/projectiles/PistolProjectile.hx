package projectiles;

import kha.Direction;
import kha.Image;
import kha.Loader;
import kha.math.Vector2;
import kha.Painter;
import kha.Scene;
import kha.Sprite;

class PistolProjectile extends Projectile {
	
	public function new(dir: Vector2, width:Int=0, height:Int=0, z:Int=1) {
		super(null, width, height, z);
		
		speedx = 10 * dir.x;
		speedy = 10 * dir.y;
		accx = 0;
		accy = 0;
		creatureDamage = 50;
		structureDamage = 1;
		Loader.the.getSound("shot").play();
	}
	
	override public function render(painter:Painter): Void {
		painter.setColor( kha.Color.fromBytes(20, 20, 20) );
		painter.fillRect( x, y, width, height );
	}
}