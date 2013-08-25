package ;

import kha.Image;
import kha.Sprite;
import projectiles.Projectile;


class DestructibleSprite extends TimeTravelSprite {
	var _health : Int;
	public var health(get, set) : Int;
	public var isStucture(default, null) : Bool = false;
	
	public function new(image:Image, width:Int=0, height:Int=0, z:Int=1) {
		super(image, width, height, z);
	}
	
	/**
		Overwrite to hanlde health loss or destruction/dying.
	**/
	private function set_health(value: Int) : Int {
		return _health = value;
	}
	private inline function get_health() : Int {
		return _health;
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
	
	override private function saveCustomFieldsForTimeLeap(storage: Map<String, Dynamic>): Void {
		super.saveCustomFieldsForTimeLeap(storage);
		
		storage.set("health", _health);
	}
	override private function restoreCustomFieldsFromTimeLeap(storage: Map<String, Dynamic>): Void {
		super.restoreCustomFieldsFromTimeLeap(storage);
		
		_health = storage["health"];
	}
}