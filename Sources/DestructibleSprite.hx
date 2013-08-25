package ;

import kha.Image;
import kha.Sprite;
import projectiles.Projectile;


class DestructibleSprite extends TimeTravelSprite {
	var health(default, set) : Int;
	public var isStucture(default, null) : Bool = false;
	
	public function new(image:Image, width:Int=0, height:Int=0, z:Int=1) {
		super(image, width, height, z);
	}
	
	/**
		Overwrite to hanlde health loss or destruction/dying.
	**/
	private function set_health(value: Int) : Int {
		return health = value;
	}
	
	override public function hit(sprite:Sprite): Void {
		if ( Std.is(sprite, Projectile) ) {
			var projectile : Projectile = cast sprite;
			if (projectile.isTimeWeapon) {
				timeLeap();
			}
			
			var oldHealth = health;
			
			if (isStucture) {
				health -= projectile.stuctureDamage;
			} else {
				health -= projectile.creatureDamage;
			}
		}
	}
}