package levels;

import kha.Scene;

class Level2 extends Level {
	private var won: Bool = false;
	
	public function new() {
		super();
		var timeline = new Timeline();
		setTimeline(timeline);
	}

	public function win(): Void {
		won = true;
	}
	
	override private function checkVictory(): Bool {
		return won;
	}
}
