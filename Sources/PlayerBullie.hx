package;

import kha.Scene;
import kha.Sprite;
import projectiles.FistOfDoom;

class PlayerBullie extends Player {
	public function new(x: Float, y: Float) {
		super(x, y - 8, "rowdy", 25 * 2, 52 * 2, 100);
		Player.setPlayer(2, this);
		_health = 100;
		baseSpeed = 3.0;
	}
	
	override public function hit(sprite: Sprite): Void {
		if (sprite != fistOfDoom) {
			super.hit(sprite);
		}
	}
	
	override public function sleep() {
		super.sleep();
		if (fistOfDoom != null) {
			fistOfDoom.remove();
		}
		if (lifted != null) {
			lifted = null;
		}
	}
	
	override public function update() {
		super.update();
		
		if (lifted != null) {
			var lc = lifted.center;
			var ldiffx = lifted.x - lc.x;
			var ldiffy = lifted.y - lc.y;
			var c = center;
			lifted.x = c.x + ldiffx;
			lifted.y = c.y + ldiffy - 0.5 * lifted.height;
		}
	}
	
	override public function leftButton(): String {
		return "Punch";
	}
	
	override public function rightButton(): String {
		return "Lift";
	}
	
	/**
	  Hauen
	**/
	var fistOfDoom : FistOfDoom;
	override public function prepareSpecialAbilityA(gameTime: Float): Void {
		if (fistOfDoom == null) {
			fistOfDoom = new FistOfDoom(this, 20, 20);
			Scene.the.addProjectile( fistOfDoom );
		}
	}
	
	override public function useSpecialAbilityA(gameTime : Float) : Void {
		if (fistOfDoom != null) {
			fistOfDoom.releaseDoom();
		}
	}
	
	/**
	  Heben
	**/
	var lifted : TimeTravelSprite;
	  
	override public function prepareSpecialAbilityB(gameTime: Float): Void {
		if (lifted == null) {
			var rect = collisionRect();
			for (checkSprite in TenUp.instance.level.timeTravelSprites) {
				if ( checkSprite != this && checkSprite.isLiftable ) {
					if ( rect.collision( checkSprite.collisionRect() ) ) {
						lifted = checkSprite;
						return;
					}
				}
			}
		}
	}
	override public function useSpecialAbilityB(gameTime: Float): Void {
		lifted = null;
		if (Level.the.gatters.length > 0) {
			var gatter = Level.the.gatters[0];
			var rect = collisionRect();
			rect.height += 10;
			if (gatter.collisionRect().collision(rect)) {
				gatter.fly();
			}
		}
	}
}
