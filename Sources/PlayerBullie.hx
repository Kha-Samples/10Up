package;
import kha.Scene;
import kha.Sprite;
import projectiles.FistOfDoom;

class PlayerBullie extends Player {
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman3");
		Player.setPlayer(2, this);
		_health = 100;
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
			for ( i in 0...Scene.the.countHeroes() ) {
				if (Std.is( Scene.the.getHero(i), TimeTravelSprite )) {
					var hero : TimeTravelSprite = cast Scene.the.getHero(i);
					if ( hero != this && hero.isLiftable ) {
						if ( rect.collision( hero.collisionRect() ) ) {
							lifted = hero;
							return;
						}
					}
				}
			}
			for ( i in 0...Scene.the.countOthers() ) {
				if (Std.is( Scene.the.getOther(i), TimeTravelSprite )) {
					var other : TimeTravelSprite = cast Scene.the.getOther(i);
					if ( other.isLiftable ) {
						if ( rect.collision( other.collisionRect() ) ) {
							lifted = other;
							return;
						}
					}
				}
			}
			for ( i in 0...Scene.the.countEnemies() ) {
				if (Std.is( Scene.the.getEnemy(i), TimeTravelSprite )) {
					var enemy : TimeTravelSprite = cast Scene.the.getEnemy(i);
					if ( enemy.isLiftable ) {
						if ( rect.collision( enemy.collisionRect() ) ) {
							lifted = enemy;
							return;
						}
					}
				}
			}
		}
	}
	override public function useSpecialAbilityB(gameTime : Float) : Void {
		lifted = null;
	}
}
