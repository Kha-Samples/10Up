package;

import kha.Animation;
import kha.Image;
import kha.Loader;
import kha.math.Random;
import kha.math.Vector2;
import kha.Painter;
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
	
	private var watchRect : Rectangle;
	
	public function new(x: Float, y: Float) {
		super(50, Loader.the.getImage("soldier"), 22 * 2, 41 * 2, 0);
		killed = false;
		this.x = x;
		this.y = y;
		walkLeft = Animation.create(0);
		walkRight = Animation.create(0);
		standLeft = Animation.create(0);
		standRight = Animation.create(0);
		setAnimation(walkRight);
		speedx = 0;
		seen = new Array<Player>();
		heard = new Array<Player>();
		distances = new Array<Float>();
		watchRect = new Rectangle(x, y - 75, 300, 150);
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
		setAnimation(Animation.create(0));
		speedx = 0;
	}
	
	public function isKilled(): Bool {
		return killed;
	}
	
	public override function hit(sprite: Sprite) {
		//Jumpman.getInstance().hitEnemy(this);
	}
	
	@:access(projectiles.PistolProjectile) 
	private function tryToShoot(): Void {
		if (TenUp.getInstance().currentGameTime > nextShootTime) {
			var c = center;
			var dir = new Vector2(focus.x - c.x, focus.y - c.y);
			dir = dir.div( dir.length );
			var projectile = new PistolProjectile( dir, 5, 5, this.z);
			projectile.x = c.x + dir.x * width;
			projectile.y = c.y + dir.y * height;
			projectile.speedx *= 0.7;
			projectile.speedy *= 0.7;
			projectile.creatureDamage = Math.round(projectile.creatureDamage * 0.5);
			kha.Scene.the.addProjectile(projectile);
			nextShootTime = TenUp.getInstance().currentGameTime + 1 + Random.getUpTo(2) + Random.getUpTo(2);
		}
	}
	
	override public function update(): Void {
		super.update();
		if (killed) {
			return;
		}
		watchRect.x = x;
		watchRect.y = y;
		for (i in 0...Player.getPlayerCount()) {
			var player = Player.getPlayer(i);
			if (player.isSleeping()) continue;
			distances[i] = new Vector2(x, y).sub(new Vector2(player.x, player.y)).length;
			if (watchRect.collision(player.collisionRect())) seen.push(player);
			if (player.walking && distances[i] < 500) heard.push(player);
		}
		
		focus = null;
		var minDistance: Float = 999999999;
		if (seen.length > 0) {
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
			minDistance = 999999999;
			var nearest: Player = null;
			for (player in heard) {
				if (distances[player.index] < minDistance) {
					minDistance = distances[player.index];
					nearest = player;
				}
			}
			focus = nearest;
		}
		if (focus != null) {
			if ( minDistance > 75 ) {
				speedx = (focus.x - x) > 0 ? 3 : -3;
			} else {
				speedx = 0;
			}
			tryToShoot();
		} else {
			speedx = 3;
		}
	}
	
	override public function render(painter: Painter): Void {
		super.render(painter);
		painter.setColor( kha.Color.ColorBlack );
		painter.drawRect( watchRect.x, watchRect.y, watchRect.width, watchRect.height );
	}
}
