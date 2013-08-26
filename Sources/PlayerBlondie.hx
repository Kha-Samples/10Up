package;

import kha.Animation;
import kha.Rectangle;

class PlayerBlondie extends Player {
	private var danceAnimation: Animation;
	private var repairLeftAnimation: Animation;
	private var repairRightAnimation: Animation;
	
	public function new(x: Float, y: Float) {
		super(x, y - 8, "mechanic", Std.int(410 / 10) * 2, Std.int(455 / 7) * 2);
		Player.setPlayer(3, this);
		repairAmountPerSec = 50;
		collider = new Rectangle(20, 30, 41 * 2 - 40, (65 - 1) * 2 - 30);
		walkLeft = Animation.createRange(11, 18, 4);
		walkRight = Animation.createRange(1, 8, 4);
		standLeft = Animation.create(10);
		standRight = Animation.create(0);
		jumpLeft = Animation.create(12);
		jumpRight = Animation.create(2);
		
		danceAnimation = new Animation([40,40,40,40,40,40,40,40,40,40,
41,41,41,41,41,41,41,41,41,41,
40,40,40,40,40,40,40,40,40,40,
41,41,41,41,41,41,41,41,41,41,
40,40,40,40,40,40,40,40,40,40,

42,42,42,42,42,42,42,42,42,42,
43,43,43,43,43,43,43,43,43,43,
42,42,42,42,42,42,42,42,42,42,
43,43,43,43,43,43,43,43,43,43,
40,40,40,40,40,40,40,40,40,40,

44,44,44, 45,45,45, 46,46,46, 47,47,47,
44,44,44, 45,45,45, 46,46,46, 47,47,47,
48,48,48,48,48,48,48,48,48,48,48,48,
44,44,44, 45,45,45, 46,46,46, 47,47,47,
44,44,44, 45,45,45, 46,46,46, 47,47,47,
49,49,49,49,49,49,49,49,49,49,49,49,

44,44,44, 45,45,45, 46,46,46, 47,47,47,
44,44,44, 45,45,45, 46,46,46, 47,47,47,
48,48,48,48,48,48,48,48,48,48,48,48,
44,44,44, 45,45,45, 46,46,46, 47,47,47,
44,44,44, 45,45,45, 46,46,46, 47,47,47,
49,49,49,49,49,49,49,49,49,49,49,49,

40,40,40,40,40,40,40,40,40,40,

50,50,50,50,50,50,50,50,50,
51,51,51,51,51,51,51,51,51,51,51,51,
50,50,50,50,50,50,50,50,50,
51,51,51,51,51,51,51,51,51,51,51,51,
50,50,50,50,50,50,50,50,50,
51,51,51,51,51,51,51,51,51,51,51,51,
50,50,50,50,50,50,50,50,50,
51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,

40, 40, 40, 40, 40, 40, 40, 40, 40, 40], 2);
		
		repairLeftAnimation = Animation.createRange(33, 35, 4);
		repairRightAnimation = Animation.createRange(30, 32, 4);
	}
	
	override public function zzzzzXDif(): Float {
		return 20;
	}
	
	override public function leftButton(): String {
		return "Dance";
	}
	
	override public function rightButton(): String {
		return "Repair";
	}
	
	override public function update() {
		super.update();
		
		if ( repairing != null ) {
			var amount = Math.round( repairAmountPerSec * (TenUp.instance.currentGameTime - lastRepairTime) );
			if ( amount > 0 ) {
				lastRepairTime = TenUp.instance.currentGameTime;
				repairing.health += amount;
			}
		}
		
		if (isDancing && Player.current() != this && lastDanceTime < TenUp.instance.currentGameTime) {
			isDancing = false;
			// TODO: stop dance animation
		}
	}
	
	/**
	  Tanzen
	**/
	public var isDancing(default, null) : Bool = false;
	var lastDanceTime : Float;
	override public function prepareSpecialAbilityA(gameTime : Float) : Void {
		isDancing = true;
		// TODO: start dance animation
	}
	override public function useSpecialAbilityA(gameTime : Float) : Void {
		lastDanceTime = gameTime + 7;
	}
	
	/**
	  Reparieren
	**/
	var repairAmountPerSec : Float;
	var lastRepairTime : Float;
	var repairing : DestructibleSprite;
	
	override public function prepareSpecialAbilityB(gameTime: Float): Void {
		if (repairing == null) {
			var rect = collisionRect();
			for (checkSprite in TenUp.instance.level.destructibleSprites) {
				if ( checkSprite != this && checkSprite.isRepairable ) {
					if ( rect.collision( checkSprite.collisionRect() ) ) {
						repairing = checkSprite;
						lastRepairTime = gameTime;
						if (lookRight) setAnimation(repairRightAnimation);
						else setAnimation(repairLeftAnimation);
						return;
					}
				}
			}
		}
	}
	
	override public function useSpecialAbilityB(gameTime : Float) : Void {
		if (repairing != null) {
			repairing.health += Math.round( repairAmountPerSec * (gameTime - lastRepairTime) );
			if (lookRight) setAnimation(standRight);
			else setAnimation(standLeft);
			repairing = null;
		}
	}
}
