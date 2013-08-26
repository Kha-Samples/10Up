package levels;

import kha.Scene;

class Level1 extends Level {
	public function new() {
		super();
		var timeline = new Timeline();
		timeline.add(4, addSoldier);
		timeline.add(6, addSoldier);
		timeline.add(8, addSoldier);
		timeline.add(10, addSoldier);
		timeline.add(12, addSoldier);
		timeline.add(14, addSoldier);
		timeline.add(14.5, addSoldier);
		timeline.add(16, addSoldier);
		timeline.add(16.5, addSoldier);
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
}
