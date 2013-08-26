package levels;

import kha.Scene;

class Level2 extends Level {
	public function new() {
		super();
		var timeline = new Timeline();
		timeline.add(5, addSoldier);
		timeline.add(6, addSoldier);
		timeline.add(7, addSoldier);
		timeline.add(8, addSoldier);
		setTimeline(timeline);
		enemies = new Array();
	}
	
	var enemies : Array<Enemy>;
	
	private function addSoldier(): Void {
		var enemy = new Enemy(20, 200);
		enemies.push(enemy);
		Scene.the.addEnemy(enemy);
	}
	
	override private function checkVictory(): Bool {
		return false;
	}
}
