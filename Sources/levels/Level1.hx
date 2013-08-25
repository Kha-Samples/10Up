package levels;

import kha.Scene;

class Level1 extends Level {
	public function new() {
		super();
		var timeline = new Timeline();
		timeline.add(5, addSoldier);
		timeline.add(6, addSoldier);
		timeline.add(7, addSoldier);
		timeline.add(8, addSoldier);
		setTimeline(timeline);
	}
	
	private function addSoldier(): Void {
		Scene.the.addEnemy(new Enemy(20, 200));
	}
}
