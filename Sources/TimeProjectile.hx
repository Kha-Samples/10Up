package ;

import kha.Direction;
import kha.Image;
import kha.Painter;
import kha.Scene;
import kha.Sprite;

class TimeProjectile extends Sprite {
	public function new(image:Image, width:Int=0, height:Int=0, z:Int=1) {
		super(image, width, height, z);
	}
	
	override public function render(painter:Painter):Void 
	{
		painter.setColor( kha.Color.fromBytes(0, 255, 0) );
		painter.fillRect( x, y, width, height );
	}
	
	override public function hitFrom( dir:Direction ) : Void {
		Scene.the.removeProjectile(this);
	}
	
	override public function hit(sprite:Sprite) : Void {
		if ( Std.is( sprite, TimeTravelSprite ) ) {
			cast( sprite, TimeTravelSprite ).timeLeap();
		}
		Scene.the.removeProjectile(this);
	}
}