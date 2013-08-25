package projectiles;

import kha.Image;
import kha.Loader;
import kha.Painter;
import kha.Rectangle;
import kha.Scene;
import kha.Sprite;


class FistOfDoom extends Projectile {
	var owner: PlayerBullie;
	var hasHit : List<Sprite>;
	
	var lastx : Float;
	var relx : Float;
	var rely : Float;
	
	public function new(owner: PlayerBullie, width:Int = 0, height:Int = 01) {
		if (owner.z == 9) owner.z = 8;
		super(Loader.the.getImage("fist"), width, height, owner.z + 1);
		
		this.owner = owner;
		
		isPiercing.set( DESTRUCTIBLE_STRUCTURES );
		isPiercing.set( CREATURES );
		
		collides = false;
		speedx = -2;
		speedy = 0;
		accx = 0;
		accy = 0;
		relx = owner.width - width;
		rely = 0.5 * owner.height;
		updatePosition();
	}
	
	private function updatePosition(): Void {
		x = (owner.x - owner.collider.x);
		if (owner.lookRight) {
			x += relx;
		} else {
			x += owner.width;
			x -= relx;
			x -= width;
		}
		y = (owner.y - owner.collider.y) + rely;
		lastx = x;
	}
	
	public function releaseDoom() : Void {
		collides = true;
		speedx = 0;
		accx = 1;
		hasHit = new List();
	}
	
	override public function hit(sprite: Sprite): Void {
		if (sprite != owner && collides) {
			if (!Lambda.has(hasHit, sprite)) {
				trace ( 'fist dmg: $creatureDamage' );
				super.hit(sprite);
				hasHit.push(sprite);
			}
		}
	}
	
	@:access(PlayerBullie)
	override public function remove(): Void {
		super.remove();
		owner.fistOfDoom = null;
	}
	
	var dmgSpeed : Float = 0;
	
	override public function update():Void {
		relx += x - lastx;
		
		if ( relx <= 0 ) {
			relx = 0;
			speedx = 0;
			//trace ( '    relx: $relx' );
		} else {
			if (accx > 0) {
				dmgSpeed = speedx;
				if ( relx >= owner.width ) {
					accx = 0;
					speedx = 0;
				}
			} else if (relx >= owner.width && speedx == 0) {
				remove();
			}
			
			creatureDamage = Math.round( ( (owner.lookRight ? owner.speedx : -owner.speedx) + dmgSpeed ) * 5.0 );
			stuctureDamage = creatureDamage;
			//trace ( 'relspeed: $dmgSpeed' );
			//trace ( 'absspeed: ${( (owner.lookRight ? owner.speedx : -owner.speedx) + speedx )}' );
			//trace ( '     dmg: $creatureDamage' );
			//trace ( '    relx: $relx' );
		}
		updatePosition();
		super.update();
	}
	
	override public function render(painter: Painter): Void {
		if (owner.lookRight) {
			painter.drawImage2(image, 0, 0, width, height, (owner.x - owner.collider.x) + relx, (owner.y - owner.collider.y) + rely, width, height, rotation);
		} else {
			painter.drawImage2(image, 0, 0, width, height, (owner.x - owner.collider.x) + owner.width - relx, (owner.y - owner.collider.y) + rely, -width, height, rotation);
		}
		var rect = collisionRect();
		painter.setColor( kha.Color.fromBytes( 255, 0, 0) );
		painter.drawRect( rect.x, rect.y, rect.width, rect.height );//*/
	}
}