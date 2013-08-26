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
			var focusCenter = focus.center;
			var dir = new Vector2(focusCenter.x - c.x, focusCenter.y - c.y);
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
	
	var watchCounter : Int = 0;
	override public function update(): Void {
		super.update();
		if (killed) {
			return;
		}
		if (watchCounter == 0) {
			watchCounter = 1;
			var myXmin = x - collider.x;
			var myXmax = myXmin + width;
			watchRect.x = x;
			watchRect.y = y;
			var minDistance = 99999999.0;
			for (i in 0...Player.getPlayerCount()) {
				var player = Player.getPlayer(i);
				if (player.isSleeping()) {
					if (focus == player) {
						focus = null;
					}
					continue;
				}
				var xMin = player.x - player.collider.x;
				var xMax = xMin + width;
				var xDist = Math.min( Math.abs(myXmin - xMax), Math.abs( myXmax - xMin ) );
				distances[i] = new Vector2( xDist, y - player.y ).length;
				//trace ( distances[i] );
				if (watchRect.collision(player.collisionRect())) {
					if ( focus == null || (minDistance > distances[i]) ) {
						focus = player;
						minDistance = distances[i];
					}
				} else if (player.walking && distances[i] < 500) {
					if ( focus == null || (minDistance > distances[i]) ) {
						focus = player;
						minDistance = distances[i];
					}
				}
			}
			
			if (focus != null) {
				speedx = (focus.x - x) > 0 ? 3 : -3;
				if ( minDistance > 100 ) {
					if ( Std.is( focus, PlayerBlondie ) ) {
						speedx *= 0.5;
					} else {
						tryToShoot();
					}
				} else if ( minDistance > 50 ) {
					if ( Std.is( focus, PlayerBlondie ) ) {
						speedx *= 0.5;
					}
					tryToShoot();
				} else if (minDistance < 25) {
					speedx = (focus.x - x) > 0 ? -2 : -2;
				} else {
					if ( Std.is( focus, PlayerBlondie ) ) {
						var blondie : PlayerBlondie = cast focus;
						if ( !blondie.isDancing ) {
							tryToShoot();
						}
					} else {
						tryToShoot();
					}
					speedx = 0;
				}
			} else {
				speedx = 3;
			}
		} else {
			watchCounter = (watchCounter + 1) % 30;
		}
	}
	
	override public function render(painter: Painter): Void {
		super.render(painter);
		painter.setColor( kha.Color.ColorBlack );
		if (focus != null)
		painter.drawRect( focus.x - focus.collider.x, focus.y - focus.collider.y, focus.width, focus.height );
	}
}
