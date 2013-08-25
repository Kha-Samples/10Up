package;

import kha.Animation;
import kha.Loader;
import kha.Scene;
import kha.Sprite;

class Door extends DestructibleSprite {
	private var opened = false;
	private var openAnim: Animation;
	private var closedAnim: Animation;
	private var crackedAnim: Animation;
	private var destroyedAnim: Animation;
	
	public function new(x: Int, y: Int) {
		super(Loader.the.getImage("door"), 32, 64, 0);
		this.x = x;
		this.y = y;
		accy = 0;
		closedAnim = Animation.create(0);
		openAnim = Animation.create(1);
		crackedAnim = Animation.create(2);
		destroyedAnim = Animation.create(3);
		setAnimation(closedAnim);
		health = 100;
	}
	
	override private function set_health(value:Int):Int {
		if (opened) return _health;
		
		if ( value <= 0 ) {
			setAnimation(destroyedAnim);
		} else if ( value < _health ) {
			trace ( 'new health: $value' );
			// TODO: pain cry
			if (value < 75) {
				setAnimation(crackedAnim);
			}
		}
		return super.set_health(value);
	}
	
	public override function hit(sprite: Sprite) {
		if (opened) return;
		if (health <= 0) return;
		if (sprite.x < x + collisionRect().width / 2) sprite.x = x - sprite.collisionRect().width - 1;
		else if ( Std.is(sprite, Player) ) {
			opened = true;
			setAnimation(openAnim);
		}
	}
}