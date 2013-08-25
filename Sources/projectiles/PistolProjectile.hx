package projectiles;

import kha.Direction;
import kha.Image;
import kha.Painter;
import kha.Scene;
import kha.Sprite;

class PistolProjectile extends Projectile {
	
	public function new(image:Image, width:Int=0, height:Int=0, z:Int=1) {
		super(image, width, height, z);
		
		creatureDamage = 50;
	}
	
	override public function render(painter:Painter): Void {
		painter.setColor( kha.Color.fromBytes(20, 20, 20) );
		painter.fillRect( x, y, width, height );
	}
}