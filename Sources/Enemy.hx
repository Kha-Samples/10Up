package;

import kha.Animation;
import kha.Image;
import kha.Loader;
import kha.math.Random;
import kha.math.Vector2;
import kha.Rectangle;
import kha.Sprite;
import projectiles.PistolProjectile;

class Enemy extends DestructibleSprite {
	private var killed: Bool;
	private var walkLeft: Animation;
	private var walkRight: Animation;
	private var standLeft: Animation;
	private var standRight: Animation;
	private var seen: Array<Player>;
	private var heard: Array<Player>;
	private var distances: Array<Float>;
	private var focus: Player = null;
	private var nextShootTime: Float = 0;
	
	public function new(x: Float, y: Float) {
		super(Loader.the.getImage("enemy"), 16 * 4, 16 * 4, 0);
		killed = false;
		this.x = x;
		this.y = y;
		health = 50;
		walkLeft = new Animation([2, 3, 4, 3], 6);
		walkRight = new Animation([7, 8, 9, 8], 6);
		standLeft = Animation.create(5);
		standRight = Animation.create(6);
		setAnimation(walkRight);
		speedx = 3;
		seen = new Array<Player>();
		heard = new Array<Player>();
		distances = new Array<Float>();
	}
	
	override private function set_health(value:Int):Int {
		if ( value <= 0 ) {
			kill();
		} else if ( value < _health ) {
			trace ( 'new health: $value' );
			// TODO: pain cry
		}
		return super.set_health(value);
	}

	public function kill() {
		killed = true;
	}
	
	public function isKilled(): Bool {
		return killed;
	}
	
	public override function hit(sprite: Sprite) {
		//Jumpman.getInstance().hitEnemy(this);
	}
	
	private function tryToShoot(): Void {
		if (TenUp.getInstance().currentGameTime > nextShootTime) {
			var projectile = new PistolProjectile(new Vector2(focus.x, focus.y).sub(new Vector2(x, y)), 5, 5, this.z);
			projectile.x = x;
			projectile.y = y;
			kha.Scene.the.addProjectile(projectile);
			nextShootTime = TenUp.getInstance().currentGameTime + 2 + Random.getUpTo(2);
		}
	}
	
	override public function update(): Void {
		super.update();
		var watchRect = new Rectangle(x, y - 30, 300, 50);
		for (i in 0...4) {
			var player = Player.getPlayer(i);
			distances[i] = new Vector2(x, y).sub(new Vector2(player.x, player.y)).length;
			if (watchRect.collision(player.collisionRect())) seen.push(player);
			if (player.walking && distances[i] < 100) heard.push(player);
		}
		
		focus = null;
		if (seen.length > 0) {
			var minDistance: Float = 999999999;
			var nearest: Player = null;
			for (player in seen) {
				if (distances[player.index] < minDistance) {
					minDistance = distances[player.index];
					nearest = player;
				}
			}
			focus = nearest;
		}
		else {
			var minDistance: Float = 999999999;
			var nearest: Player = null;
			for (player in heard) {
				if (distances[player.index] < minDistance) {
					minDistance = distances[player.index];
					nearest = player;
				}
			}
			focus = nearest;
		}
		if (focus != null) tryToShoot();
	}
}
