package;

import kha.Animation;
import kha.Direction;
import kha.Loader;
import kha.Music;
import kha.Painter;
import kha.Rectangle;
import kha.Sound;
import kha.Sprite;
import projectiles.PistolProjectile;

class Player extends DestructibleSprite {
	public var left : Bool;
	public var right : Bool;
	public var up : Bool;
	var lookRight : Bool;
	var standing : Bool;
	var killed : Bool;
	var jumpcount : Int;
	var lastupcount : Int;
	var walkLeft : Animation;
	var walkRight : Animation;
	var standLeft : Animation;
	var standRight : Animation;
	var jumpLeft : Animation;
	var jumpRight : Animation;
	var stompsound : Sound;
	var jumpsound : Sound;
	var diesound : Sound;
	var score : Int;
	var round : Int;
	private var time: Float;
	private static var currentPlayer: Player = null;
	private static var jumpmans: Array<Player>;
	
	public function new(x: Float, y: Float, image: String) {
		super(Loader.the.getImage(image), 16 * 4, 16 * 4, 0);
		this.x = x;
		this.y = y;
		standing = false;
		walkLeft = new Animation([2, 3, 4, 3], 6);
		walkRight = new Animation([7, 8, 9, 8], 6);
		standLeft = Animation.create(5);
		standRight = Animation.create(6);
		jumpLeft = Animation.create(1);
		jumpRight = Animation.create(10);
		setAnimation(jumpRight);
		collider = new Rectangle(16, 32, 32, 32);
		score = 0;
		round = 1;
		up = false;
		right = false;
		left = false;
		lookRight = true;
		killed = false;
		time = 0;
		jumpcount = 0;
		stompsound = Loader.the.getSound("stomp");
		jumpsound = Loader.the.getSound("jump");
		diesound = Loader.the.getSound("die");
		health = 50;
	}
	
	public static function init(): Void {
		jumpmans = new Array<Player>();
	}
	
	public static function getPlayer(index: Int): Player {
		return jumpmans[index];
	}
	
	public static function getPlayerIndex(): Int {
		for (i in 0...4) {
			if (jumpmans[i] == currentPlayer) return i;
		}
		return -1;
	}
	
	public static function setPlayer(index: Int, jumpman: Player): Void {
		jumpmans[index] = jumpman;
	}
	
	public static function current(): Player {
		return currentPlayer;
	}
	
	public function setCurrent(): Void {
		currentPlayer = this;
	}
	
	public function timeLeft(): Float {
		return Math.max(10 - time, 0);
	}
	
	public function elapse(time: Float): Void {
		if (killed) return;
		this.time += time;
		if (this.time > 10) sleep();
	}
	
	public function reset() {
		x = y = 50;
		standing = false;
		setAnimation(jumpRight);
	}
	
	public function selectCoin() {
		score += 50;
	}
	
	public function getScore() : Int {
		return score;
	}
	
	public function getRound() : Int {
		return round;
	}
	
	public function nextRound() {
		++round;
	}
	
	public override function update() {
		if (killed && y > 600) {
			TenUp.getInstance().showHighscore();
		}
		if (lastupcount > 0) --lastupcount;
		if (!killed) {
			if (right) {
				if (standing) setAnimation(walkRight);
				speedx = 3.0 * Math.round(Math.pow(1.1, getRound()));
				lookRight = true;
			}
			else if (left) {
				if (standing) setAnimation(walkLeft);
				speedx = -3.0 * Math.round(Math.pow(1.1, getRound()));
				lookRight = false;
			}
			else {
				if (standing) setAnimation(lookRight ? standRight : standLeft);
				speedx = 0;
			}
			if (up && standing) {
				jumpsound.play();
				setAnimation(lookRight ? jumpRight : jumpLeft);
				speedy = -8.2;
			}
			else if (!standing && !up && speedy < 0 && jumpcount == 0) speedy = 0;
			
			if (!standing) setAnimation(lookRight ? jumpRight : jumpLeft);
			
			standing = false;
		}
		if (jumpcount > 0) --jumpcount;
		super.update();
	}
	
	public function setUp() {
		up = true;
		lastupcount = 8;
	}
	
	public override function hitFrom(dir : Direction) {
		if (dir == Direction.UP) {
			standing = true;
			if (lastupcount < 1) up = false;
		}
		else if (dir == Direction.DOWN) speedy = 0;
	}
	
	public function sleep() {
		diesound.play();
		setAnimation(Animation.create(0));
		speedy = 0;
		speedx = 0;
		killed = true;
		TenUp.getInstance().pause();
	}
	
	public function isSleeping(): Bool {
		return killed;
	}
	
	public function hitEnemy(enemy : Enemy) {
		if (killed) return;
		if (enemy.isKilled()) return;
		if (enemy.collisionRect().y + enemy.collisionRect().height > collisionRect().y + collisionRect().height + 4) {
			stompsound.play();
			enemy.kill();
			speedy = -8;
			jumpcount = 10;
			standing = false;
			score += 100;
		}
		else sleep();
	}
	
	override public function timeLeap() : Void {
		super.timeLeap();
		time = 0;
		killed = false;
	}
	
	public function prepareSpecialAbilityA(gameTime : Float) : Void {
		
	}
	
	public function useSpecialAbilityA(gameTime : Float) : Void {
		
	}
	
	public function prepareSpecialAbilityB(gameTime : Float) : Void {
		
	}
	
	public function useSpecialAbilityB(gameTime : Float) : Void {
		
	}
	
	override private function set_health(value:Int):Int {
		if ( value <= 0 ) {
			sleep();
		} else if ( value < health ) {
			// TODO: pain cry
		}
		return super.set_health(value);
	}
	
	// Crosshair:
	var isCrosshairVisible : Bool = false;
	var crosshairX : Float;
	var crosshairY : Float;
	
	public function updateCrosshair( mouseX : Float, mouseY : Float ) {
		if (Player.current() != null) {
			var vx = mouseX - x;
			var vy = mouseY - y + 10;
			if (Player.current().lookRight) {
				vx -= 0.5 * width;
				if (vx < 0) {
					vx = 0;
				}
			} else {
				if ( vx > 0) {
					vx = 0;
				}
			}
			
			var vl = Math.sqrt( vx * vx + vy * vy );
			if (vl < 0.001) {
				return;
			}
			crosshairX = vx / vl;
			crosshairY = vy / vl;
		}
	}
	
	
	override public function render(painter:Painter):Void {
		super.render(painter);
		if ( isCrosshairVisible ) {
			painter.setColor( kha.Color.fromBytes( 255, 0, 0, 150 ) );
			
			var px = x + 50 * crosshairX + (lookRight ? 0.5 * width : 0);
			var py = y + 10 + 50 * crosshairY;
			painter.drawLine( px - 10 * crosshairX, py - 10 * crosshairY, px - 2 * crosshairX, py - 2 * crosshairY );
			painter.drawLine( px + 10 * crosshairX, py + 10 * crosshairY, px + 2 * crosshairX, py + 2 * crosshairY );
			painter.drawLine( px - 10 * crosshairY, py + 10 * crosshairX, px - 2 * crosshairY, py + 2 * crosshairX );
			painter.drawLine( px + 10 * crosshairY, py - 10 * crosshairX, px + 2 * crosshairY, py - 2 * crosshairX );
		}
	}
}
