package;

class Level {
	private var timeline: Timeline;
	
	public var doors(default, null) : Array<Door>;
	
	public function new() {
		doors = new Array();
	}
	
	public function setTimeline(timeline: Timeline): Void {
		this.timeline = timeline;
	}
	
	public function update(time: Float) {
		timeline.update(time);
		
		var alive: Bool = false;
		for (i in 0...Player.getPlayerCount()) {
			if (!Player.getPlayer(i).isSleeping()) {
				alive = true;
				break;
			}
		}
		
		if (!alive) {
			TenUp.getInstance().defeat();
		} else if ( checkVictory() ) {
			TenUp.getInstance().victory();
		}
	}
	
	private function checkVictory() : Bool { return false; }
}