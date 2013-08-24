package;

import kha.Animation;
import kha.Direction;
import kha.Loader;
import kha.Music;
import kha.Rectangle;
import kha.Sound;
import kha.Sprite;

class Jumpman extends Sprite {
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
	private static var currentPlayer = null;
	private static var jumpmans: Array<Jumpman>;
	
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
		jumpcount = 0;
		stompsound = Loader.the.getSound("stomp");
		jumpsound = Loader.the.getSound("jump");
		diesound = Loader.the.getSound("die");
	}
	
	
	public static function init(): Void {
		jumpmans = new Array<Jumpman>();
	}
	
	public static function getJumpman(index: Int): Jumpman {
		return jumpmans[index];
	}
	
	public static function getJumpmanIndex(): Int {
		for (i in 0...4) {
			if (jumpmans[i] == currentPlayer) return i;
		}
		return -1;
	}
	
	public static function setJumpman(index: Int, jumpman: Jumpman): Void {
		jumpmans[index] = jumpman;
	}
	
	public static function current() {
		return currentPlayer;
	}
	
	public function setCurrent() {
		currentPlayer = this;
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
			if (y > 600) {
				die();
				return;
			}
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
	
	public function die() {
		diesound.play();
		setAnimation(Animation.create(0));
		speedy = -8;
		speedx = 0;
		collides = false;
		killed = true;
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
		else die();
	}
}