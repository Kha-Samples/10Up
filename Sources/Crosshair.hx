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
	
	public var visible : Bool = false;

	public function new() {
		super(null, 0, 0, 9);
		collides = false;
		x = 1;
		y = 0;
	}
	
	var x2 : Float;
	var y2 : Float;
	@:access(Player) 
	public function setAngle( px : Float, py : Float ) {
		if (Player.current() != null) {
			var vx = px - Player.current().x;
			var vy = py - (Player.current().y - 10);
			if (Player.current().lookRight) {
				vx -= 0.5 * Player.current().width;
				if (vx < 0) {
					vx = 0;
				}
			} else {
				if ( vx > 0) {
					vx = 0;
				}
			}
			
			var vl = Math.sqrt( vx * vx + vy * vy );
			if (vl < 0.001) {
				return;
			}
			x = vx / vl;
			y = vy / vl;
		}
		
		/*
		if (angle > 0.5 * Math.PI) {
			angle = 0.5 * Math.PI;
		} else if ( angle < -0.5 * Math.PI ) {
			angle = -0.5 * Math.PI;
		}
		x = 1 * Math.cos( angle );
		y = -1 * Math.sin( angle );
		*/
	}
	
	@:access(Player) 
	override public function render(painter:Painter) : Void {
		if (visible) {
			painter.setColor( Color.fromBytes( 255, 0, 0, 150 ) );
			
			var px = Player.current().x + 50 * x + (Player.current().lookRight ? 0.5 * Player.current().width : 0);
			var py = Player.current().y + 10 + 50 * y;
			painter.drawLine( px - 10 * x, py - 10 * y, px - 2 * x, py - 2 * y );
			painter.drawLine( px + 10 * x, py + 10 * y, px + 2 * x, py + 2 * y );
			painter.drawLine( px - 10 * y, py + 10 * x, px - 2 * y, py + 2 * x );
			painter.drawLine( px + 10 * y, py - 10 * x, px + 2 * y, py - 2 * x );
		}
	}
}