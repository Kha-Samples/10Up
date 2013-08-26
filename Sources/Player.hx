package;

import kha.Animation;
import kha.Direction;
import kha.Loader;
import kha.math.Vector2;
import kha.Music;
import kha.Painter;
import kha.Rectangle;
import kha.Scene;
import kha.Sound;
import kha.Sprite;
import projectiles.PistolProjectile;

class Player extends DestructibleSprite {
	public var left : Bool;
	public var right : Bool;
	public var up : Bool;
	public var lookRight(default, null) : Bool;
	public var walking: Bool = false;
	public var index: Int;
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
	
	var muzzlePoint : Vector2;
	
	public function new(x: Float, y: Float, image: String, width: Int, height: Int, maxHealth: Int = 50) {
		super(maxHealth, Loader.the.getImage(image), width, height, 0);
		this.x = x;
		this.y = y;
		standing = false;
		walkLeft = Animation.create(0);
		walkRight = Animation.create(0);
		standLeft = Animation.create(0);
		standRight = Animation.create(0);
		jumpLeft = Animation.create(0);
		jumpRight = Animation.create(0);
		setAnimation(jumpRight);
		collider = new Rectangle(16, 0, 32, height);
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
		crosshair = new Vector2(1, 0);
		isRepairable = true;
	}
	
	public static function init(): Void {
		jumpmans = new Array<Player>();
	}
	
	public static function getPlayerCount(): Int {
		return jumpmans.length;
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
		jumpman.index = index;
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
	
	public override function update(): Void {
		walking = false;
		if (lastupcount > 0) --lastupcount;
		if (!killed) {
			if (right) {
				if (standing) {
					setAnimation(walkRight);
					walking = true;
				}
				speedx = 3.0 * Math.round(Math.pow(1.1, getRound()));
				lookRight = true;
			}
			else if (left) {
				if (standing) {
					setAnimation(walkLeft);
					walking = true;
				}
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
		if (Player.currentPlayer == this) {
			updateCrosshair();
		}
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
		isLiftable = true;
		diesound.play();
		setAnimation(Animation.create(0));
		speedy = 0;
		speedx = 0;
		killed = true;
		if (this == currentPlayer) {
			TenUp.getInstance().pause();
		}
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
	
	override private function saveCustomFieldsForTimeLeap(storage: Map<String, Dynamic>): Void {
		super.saveCustomFieldsForTimeLeap(storage);
		
		storage.set("time", time);
		storage.set("killed", killed);
		storage.set("isLiftable", isLiftable);
	}
	override private function restoreCustomFieldsFromTimeLeap(storage: Map<String, Dynamic>): Void {
		super.restoreCustomFieldsFromTimeLeap(storage);
		
		time = storage["time"];
		killed = storage["killed"];
		isLiftable = storage["isLiftable"];
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
		} else if ( value < _health ) {
			trace ( 'new health: $value' );
			for (i in 0...30) Scene.the.addOther(new Blood(x + 20, y + 20));
			// TODO: pain cry
		} else if ( value > _health && _health <= 0 ) {
			killed = timeLeft() > 0;
			isLiftable = killed;
		}
		return super.set_health(value);
	}
	
	// Crosshair:
	var isCrosshairVisible : Bool = false;
	var crosshair : Vector2;
	
	public function updateCrosshair() {
		if (Player.current() != null) {
			var v = center;
			v.x = TenUp.instance.mouseX - v.x;
			v.y = TenUp.instance.mouseY - v.y;
			//v.y += 0.1 * height;
			if (lookRight) {
				if (v.x < 0) {
					v.x = 0;
				}
			} else {
				if ( v.x > 0) {
					v.x = 0;
				}
			}
			
			var vl = v.length;
			if (vl < 0.001) {
				return;
			}
			crosshair = v.div( vl );
		}
		updateMuzzlePoint();
	}
	
	private function updateMuzzlePoint(): Void {
		muzzlePoint = center;
		muzzlePoint.x += 0.6 * crosshair.x * width;
		muzzlePoint.y += 0.6 * crosshair.y * height;
	}
	
	override public function render(painter:Painter):Void {
		super.render(painter);
		if ( isCrosshairVisible ) {
			painter.setColor( kha.Color.fromBytes( 255, 0, 0, 150 ) );
			
			var px = muzzlePoint.x + 50 * crosshair.x;
			var py = muzzlePoint.y + 50 * crosshair.y;
			painter.drawLine( px - 10 * crosshair.x, py - 10 * crosshair.y, px - 2 * crosshair.x, py - 2 * crosshair.y );
			painter.drawLine( px + 10 * crosshair.x, py + 10 * crosshair.y, px + 2 * crosshair.x, py + 2 * crosshair.y );
			painter.drawLine( px - 10 * crosshair.y, py + 10 * crosshair.x, px - 2 * crosshair.y, py + 2 * crosshair.x );
			painter.drawLine( px + 10 * crosshair.y, py - 10 * crosshair.x, px + 2 * crosshair.y, py - 2 * crosshair.x );
			
			/*
			var rect = collisionRect();
			var c = center;
			painter.drawRect( rect.x, rect.y, rect.width, rect.height );
			painter.fillRect( c.x - 4, c.y - 4, 9, 9);
			
			painter.drawLine( muzzlePoint.x, muzzlePoint.y, muzzlePoint.x + 50 * crosshair.x, muzzlePoint.y + 50 * crosshair.y);
			painter.fillRect( muzzlePoint.x - 4, muzzlePoint.y - 4, 9, 9);//*/
		}
	}
}
