package levels;

import kha.gui.TextItem;
import kha.Loader;
import kha.Scene;

class Level1 extends Level {
	public function new() {
		super();
		var timeline = new Timeline();
		timeline.add(10, addSoldier);
		timeline.add(12, addSoldier);
		timeline.add(14, addSoldier);
		timeline.add(16, addSoldier);
		timeline.add(18, addSoldier);
		timeline.add(20, addSoldier);
		setTimeline(timeline);
		enemies = new Array();
	}
	
	var enemies : Array<Enemy>;
	
	private function addSoldier(): Void {
		var enemy = new Enemy(20, 200);
		enemy.update();
		enemies.push(enemy);
		Scene.the.addEnemy(enemy);
	}
	
	override private function checkVictory(): Bool {
		var door = doors[0];
		if (door.health < 75) {
			return false;
		}
		
		var doorX = door.x + door.width;
		for (i in 0...Player.getPlayerCount()) {
			var player = Player.getPlayer(i);
			if (player.x < doorX) {
				return false;
			}
		}
		
		if (door.opened) {
			door.opened = false;
			return false;
		}
		
		for (enemy in enemies) {
			if (!enemy.isKilled() && enemy.x > doorX) {
				return false;
			}
		}
		
		return true;
	}
	
	var state = 0;
	override public function updateMissionBriefing(time:Float): Bool {
		if (anyKey) {
			state++;
			switch (state) {
				case 1:
					var sprite = new kha.Sprite( Loader.the.getImage("level1briefing0") );
					sprite.x = 0.5 * (TenUp.instance.width - sprite.width);
					sprite.y = 40;
					missionBriefingSprites.push( sprite );
					var sprite = new kha.Sprite( Loader.the.getImage("level1briefing1") );
					sprite.x = 0.5 * (TenUp.instance.width - sprite.width);
					sprite.y = 50;
					missionBriefingSprites.push( sprite );
				case 2:
					missionBriefingSprites = new Array();
					var sprite = new kha.Sprite( Loader.the.getImage("level1briefing0") );
					sprite.x = 0.5 * (TenUp.instance.width - sprite.width);
					sprite.y = 40;
					missionBriefingSprites.push( sprite );
					var sprite = new kha.Sprite( Loader.the.getImage("level1briefing2") );
					sprite.x = 0.5 * (TenUp.instance.width - sprite.width);
					sprite.y = 50;
					missionBriefingSprites.push( sprite );
					// TODO: play SOUND!!!
				case 3:
					missionBriefingSprites = new Array();
					var sprite = new kha.Sprite( Loader.the.getImage("level1briefing0") );
					sprite.x = 0.5 * (TenUp.instance.width - sprite.width);
					sprite.y = 40;
					missionBriefingSprites.push( sprite );
					var sprite = new kha.Sprite( Loader.the.getImage("level1briefing3") );
					sprite.x = 0.5 * (TenUp.instance.width - sprite.width);
					sprite.y = 50;
					missionBriefingSprites.push( sprite );
				default:
					return true;
			}
		}
		return false;
	}
}
