package projectiles;

import kha.Direction;
import kha.Image;
import kha.Painter;
import kha.Scene;
import kha.Sprite;

class PistolProjectile extends Sprite {
	
	public function new(image:Image, width:Int=0, height:Int=0, z:Int=1) {
		super(image, width, height, z);
	}
	
	override public function render(painter:Painter):Void 
	{
		painter.setColor( kha.Color.fromBytes(20, 20, 20) );
		painter.fillRect( x, y, width, height );
	}
	
	override public function hitFrom( dir:Direction ) : Void {
		Scene.the.removeProjectile(this);
	}
	
	override public function hit(sprite:Sprite) : Void {
		Scene.the.removeProjectile(this);
	}
}