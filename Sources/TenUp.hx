package;

import kha.Button;
import kha.Color;
import kha.Font;
import kha.FontStyle;
import kha.Game;
import kha.HighscoreList;
import kha.Key;
import kha.Loader;
import kha.LoadingScreen;
import kha.Music;
import kha.Painter;
import kha.Scene;
import kha.Scheduler;
import kha.Score;
import kha.Configuration;
import kha.Tile;
import kha.Tilemap;

enum Mode {
	Game;
	Pause;
	Highscore;
	EnterHighscore;
}

class TenUp extends Game {
	static var instance: TenUp;
	var music : Music;
	var tileColissions : Array<Tile>;
	var map : Array<Array<Int>>;
	var originalmap : Array<Array<Int>>;
	var highscoreName : String;
	var shiftPressed : Bool;
	private var font: Font;
	
	public var currentGameTime(default, null) : Float;
	var lastTime : Float;
	
	public var mode(default, null) : Mode;
	
	public function new() {
		super("10Up", false);
		instance = this;
		shiftPressed = false;
		highscoreName = "";
		mode = Mode.Game;
		crosshair = new Crosshair();
	}
	
	public static function getInstance(): TenUp {
		return instance;
	}
	
	public function pause(): Void {
		if (nextPlayer()) mode = Pause;
	}
	
	public override function init(): Void {
		Configuration.setScreen(new LoadingScreen());
		Loader.the.loadRoom("level1", initLevel);
	}

	public function initLevel(): Void {
		font = Loader.the.loadFont("Arial", new FontStyle(false, false, false), 12);
		tileColissions = new Array<Tile>();
		for (i in 0...140) {
			tileColissions.push(new Tile(i, isCollidable(i)));
		}
		var blob = Loader.the.getBlob("level.map");
		var levelWidth: Int = blob.readS32BE();
		var levelHeight: Int = blob.readS32BE();
		originalmap = new Array<Array<Int>>();
		for (x in 0...levelWidth) {
			originalmap.push(new Array<Int>());
			for (y in 0...levelHeight) {
				originalmap[x].push(blob.readS32BE());
			}
		}
		map = new Array<Array<Int>>();
		for (x in 0...originalmap.length) {
			map.push(new Array<Int>());
			for (y in 0...originalmap[0].length) {
				map[x].push(0);
			}
		}
		music = Loader.the.getMusic("level1");
		startGame();
	}
	
	public function startGame() {
		Scene.the.clear();
		Scene.the.setBackgroundColor(Color.fromBytes(255, 255, 255));
		Player.init();
		var tilemap : Tilemap = new Tilemap("sml_tiles", 32, 32, map, tileColissions);
		Scene.the.setColissionMap(tilemap);
		Scene.the.addBackgroundTilemap(tilemap, 1);
		var TILE_WIDTH : Int = 32;
		var TILE_HEIGHT : Int = 32;
		for (x in 0...originalmap.length) {
			for (y in 0...originalmap[0].length) {
				switch (originalmap[x][y]) {
				case 15:
					map[x][y] = 0;
					Scene.the.addHero(new PlayerAgent(x * TILE_WIDTH, y * TILE_HEIGHT));
				case 16:
					map[x][y] = 0;
					Scene.the.addHero(new PlayerProfessor(x * TILE_WIDTH, y * TILE_HEIGHT));
				case 17:
					map[x][y] = 0;
					Scene.the.addHero(new PlayerBullie(x * TILE_WIDTH, y * TILE_HEIGHT));
				case 18:
					map[x][y] = 0;
					Scene.the.addHero(new PlayerBlondie(x * TILE_WIDTH, y * TILE_HEIGHT));
				case 46:
					map[x][y] = 0;
					Scene.the.addEnemy(new Coin(x * TILE_WIDTH, y * TILE_HEIGHT));
				case 52:
					map[x][y] = 52;
					Scene.the.addEnemy(new Exit(x * TILE_WIDTH, y * TILE_HEIGHT));
				case 56:
					map[x][y] = 1;
					Scene.the.addEnemy((new BonusBlock(x * TILE_WIDTH, y * TILE_HEIGHT)));
				default:
					map[x][y] = originalmap[x][y];
				}
			}
		}
		music.play();
		Player.getPlayer(0).setCurrent();
		//Player.getInstance().reset();
		Configuration.setScreen(this);
		currentGameTime = 0;
		lastTime = Scheduler.time();
	}
	
	public function showHighscore() {
		Scene.the.clear();
		mode = Mode.EnterHighscore;
		music.stop();
	}
	
	private static function isCollidable(tilenumber : Int) : Bool {
		switch (tilenumber) {
		case 1: return true;
		case 6: return true;
		case 7: return true;
		case 8: return true;
		case 26: return true;
		case 33: return true;
		case 39: return true;
		case 48: return true;
		case 49: return true;
		case 50: return true;
		case 53: return true;
		case 56: return true;
		case 60: return true;
		case 61: return true;
		case 62: return true;
		case 63: return true;
		case 64: return true;
		case 65: return true;
		case 67: return true;
		case 68: return true;
		case 70: return true;
		case 74: return true;
		case 75: return true;
		case 76: return true;
		case 77: return true;
		case 84: return true;
		case 86: return true;
		case 87: return true;
		default:
			return false;
		}
	}
	
	public override function update() {
		var currentTime = Scheduler.time();
		if (mode == Game) {
			var lastGameTime = currentGameTime;
			currentGameTime += currentTime - lastTime;
			Player.current().elapse(currentGameTime - lastGameTime);
		}
		if (mode != Pause) {
			super.update();
		}
		if (mode == Game && Player.current() != null) {
			Scene.the.camx = Std.int(Player.current().x) + Std.int(Player.current().width / 2);
		}
		else if (mode == Pause) {
			var aimx = Std.int(Player.current().x) + Std.int(Player.current().width / 2);
			var camspeed: Int = 5;
			if (Scene.the.camx > aimx) {
				Scene.the.camx -= camspeed;
				if (Scene.the.camx < aimx) Scene.the.camx = aimx; 
			}
			else if (Scene.the.camx < aimx) {
				Scene.the.camx += camspeed;
				if (Scene.the.camx > aimx) Scene.the.camx = aimx; 
			}
		}
		lastTime = currentTime;
	}
	
	public override function render(painter : Painter) {
		//if (Player.getInstance() == null) return;
		painter.setFont(font);
		switch (mode) {
		case Highscore:
			painter.setColor(Color.fromBytes(255, 255, 255));
			painter.fillRect(0, 0, width, height);
			painter.setColor(Color.fromBytes(0, 0, 0));
			var i : Int = 0;
			while (i < 10 && i < getHighscores().getScores().length) {
				var score : Score = getHighscores().getScores()[i];
				painter.drawString(Std.string(i + 1) + ": " + score.getName(), 100, i * 30 + 100);
				painter.drawString(" -           " + Std.string(score.getScore()), 200, i * 30 + 100);
				++i;
			}
			//break;
		case EnterHighscore:
			painter.setColor(Color.fromBytes(255, 255, 255));
			painter.fillRect(0, 0, width, height);
			painter.setColor(Color.fromBytes(0, 0, 0));
			painter.drawString("Enter your name", width / 2 - 100, 200);
			painter.drawString(highscoreName, width / 2 - 50, 250);
			//break;
		case Game, Pause:
			super.render(painter);
			painter.translate(0, 0);
			//painter.setColor(Color.fromBytes(0, 0, 0));
			//painter.drawString("Score: " + Std.string(Player.getInstance().getScore()), 20, 25);
			//painter.drawString("Round: " + Std.string(Player.getInstance().getRound()), width - 100, 25);
			
			drawPlayerInfo(painter, 0, 20, 460, Color.fromBytes(255, 0, 0));
			drawPlayerInfo(painter, 1, 80, 460, Color.fromBytes(0, 255, 0));
			drawPlayerInfo(painter, 2, 140, 460, Color.fromBytes(0, 0, 255));
			drawPlayerInfo(painter, 3, 200, 460, Color.fromBytes(255, 255, 0));
			
			crosshair.render( painter );
			
			if (mode == Pause) {
				painter.setColor(Color.fromBytes(0, 0, 0));
				painter.setFont(font);
				painter.drawString("Pause", width / 2 - font.stringWidth("Pause") / 2, height / 2 - font.getHeight() / 2);
			}
		}
	}
	
	private function drawPlayerInfo(painter: Painter, index: Int, x: Float, y: Float, color: Color): Void {
		if (Player.getPlayerIndex() == index) {
			painter.setColor(Color.fromBytes(255, 255, 255));
			painter.fillRect(x - 5, y - 5, 50, 50);
		}
		painter.setColor(color);
		painter.fillRect(x, y, 40, 40);
		painter.setColor(Color.fromBytes(50, 50, 50));
		painter.fillRect(x, y + 30, 40, 10);
		painter.setColor(Color.fromBytes(0, 255, 255));
		painter.fillRect(x, y + 30, Player.getPlayer(index).timeLeft() * 4, 10);
	}

	override public function buttonDown(button : Button) : Void {
		switch (mode) {
		case Game:
			switch (button) {
			case UP:
				Player.current().setUp();
			case LEFT:
				Player.current().left = true;
			case RIGHT:
				Player.current().right = true;
			case BUTTON_1:
				Player.current().prepareSpecialAbilityA(currentGameTime);
			case BUTTON_2:
				Player.current().prepareSpecialAbilityB(currentGameTime);
			default:
			}
		case Pause:
			switch (button) {
				case LEFT:
					prevPlayer();
				case RIGHT:
					nextPlayer();
				default:
			}
		default:
		}
	}
	
	override public function buttonUp(button : Button) : Void {
		switch (mode) {
		case Game:
			switch (button) {
			case UP:
				Player.current().up = false;
			case LEFT:
				Player.current().left = false;
			case RIGHT:
				Player.current().right = false;
			case BUTTON_1:
				Player.current().useSpecialAbilityA(currentGameTime);
			case BUTTON_2:
				Player.current().useSpecialAbilityB(currentGameTime);
			default:
			}
		default:
		}
	}
	
	private function nextPlayer(): Bool {
		var count: Int = 0;
		var index = Player.getPlayerIndex();
		while (true) {
			++index;
			if (index > 3) index = 0;
			var player = Player.getPlayer(index);
			++count;
			if (!player.isSleeping()) {
				player.setCurrent();
				return true;
			}
			if (count > 4) return false;
		}
		return false;
	}
	
	private function prevPlayer(): Bool {
		var count: Int = 0;
		var index = Player.getPlayerIndex();
		while (true) {
			--index;
			if (index < 0) index = 3;
			var player = Player.getPlayer(index);
			++count;
			if (!player.isSleeping()) {
				player.setCurrent();
				return true;
			}
			if (count > 4) return false;
		}
		return false;
	}
	
	override public function keyDown(key : Key, char : String) : Void {
		if (key == Key.CHAR) {
			if (mode == Mode.Game) {
				if (char == " ") {
					mode = Pause;
					Player.current().right = false;
					Player.current().left = false;
					Player.current().up = false;
				}
			}
			else if (mode == Mode.Pause) {
				if (char == " ") {
					mode = Game;
				}
			}
			else if (mode == Mode.EnterHighscore) {
				if (highscoreName.length < 20) highscoreName += shiftPressed ? char.toUpperCase() : char.toLowerCase();
			}
		}
		else {
			if (highscoreName.length > 0) {
				switch (key) {
				case ENTER:
					//getHighscores().addScore(highscoreName, Player.getInstance().getScore());
					mode = Mode.Highscore;
				case BACKSPACE:
					highscoreName = highscoreName.substr(0, highscoreName.length - 1);
				default:
				}
			}
			if (key == SHIFT) shiftPressed = true;
		}
	}
	
	override public function keyUp(key : Key, char : String) : Void {
		if (key != null && key == Key.SHIFT) shiftPressed = false;
	}
	
	public var crosshair(default, null) : Crosshair;
	var mouseX : Int;
	var mouseY : Int;
	override public function mouseMove(x:Int, y:Int) : Void {
		var vx = mouseX - x;
		var vy = mouseY - y;
		//var vl = Math.sqrt( vx * vx + vy * vy );
		
		crosshair.changeAngle( Math.PI * vy / height );
		
		mouseX = x;
		mouseY = y;
	}
}