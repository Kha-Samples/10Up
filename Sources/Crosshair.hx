package ;

import kha.Color;
import kha.Image;
import kha.Painter;
import kha.Sprite;

/**
 * ...
 * @author Ingo Jakobs
 */
class Crosshair extends Sprite {

	public function new() {
		super(null, 0, 0, 9);
		collides = false;
		changeAngle(0);
	}
	
	var angle : Float;
	public function changeAngle( diff : Float ) {
		angle += diff;
		if (angle > 0.5 * Math.PI) {
			angle = 0.5 * Math.PI;
		} else if ( angle < -0.5 * Math.PI ) {
			angle = -0.5 * Math.PI;
		}
		x = 1 * Math.cos( angle );
		y = 1 * Math.sin( angle );
	}
	
	@:access(Player) 
	override public function render(painter:Painter) : Void {
		painter.setColor( Color.fromBytes( 255, 0, 0, 150 ) );
		
		var px = Player.current().x + 0.5 * Player.current().width + (Player.current().lookRight ? 50 * x : -50 * x);
		var py = Player.current().y + 0.5 * Player.current().height + 50 * y;
		painter.drawLine( px + 10 * y, py + 10 * y, px + 2 * x, py + 2 * y );
		painter.drawLine( px + 10 * y, py + 10 * y, px + 2 * x, py + 2 * y );
	}
}