package;

class Level {
	private var timeline: Timeline;
	
	public var doors(default, null) : Array<Door>;
	public var timeTravelSprites(default, null) : Array<TimeTravelSprite>;
	public var destructibleSprites(default, null) : Array<DestructibleSprite>;
	
	public function new() {
		doors = new Array();
		timeTravelSprites = new Array();
		destructibleSprites = new Array();
	}
	
	public function setTimeline(timeline: Timeline): Void {
		this.timeline = timeline;
	}
	
	var nextVictoryCheck : Float = 0;
	public function update(time: Float) {
		timeline.update(time);
		
		if ( nextVictoryCheck <= time ) {
			nextVictoryCheck = time + 1;
			if ( checkVictory() ) {
				TenUp.getInstance().victory();
			} else {
				var alive: Bool = false;
				for (i in 0...Player.getPlayerCount()) {
					if (!Player.getPlayer(i).isSleeping()) {
						alive = true;
						break;
					}
				}
				if (!alive) {
					TenUp.getInstance().defeat();
				}
			} 
		}
	}
	
	private function checkVictory() : Bool { return false; }
}