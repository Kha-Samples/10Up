package;

import kha.Painter;
import kha.Sprite;

class Level {
	private static var instance: Level;
	private var timeline: Timeline;
	
	public var doors(default, null) : Array<Door>;
	public var cars(default, null): Array<Car>;
	public var computers(default, null): Array<Computer>;
	public var gates(default, null): Array<Gate>;
	public var gatters(default, null): Array<Gatter>;
	public var timeTravelSprites(default, null) : Array<TimeTravelSprite>;
	public var destructibleSprites(default, null) : Array<DestructibleSprite>;
	
	public function new() {
		doors = new Array();
		cars = new Array();
		computers = new Array();
		gates = new Array();
		gatters = new Array();
		timeTravelSprites = new Array();
		destructibleSprites = new Array();
		instance = this;
		missionBriefingSprites = new Array();
	}
	
	public static var the(get, null): Level;
	
	private static function get_the(): Level {
		return instance;
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
	
	@:noCompletion var _anyKey: Bool = true;
	public var anyKey(get, set) : Bool;
	@:noCompletion private function set_anyKey( value : Bool ) : Bool {
		return _anyKey = value;
	}
	@:noCompletion private function get_anyKey() : Bool {
		var r = _anyKey;
		_anyKey = false;
		return r;
	}
	public function updateMissionBriefing(time: Float) : Bool { return true; }
	private var missionBriefingSprites : Array<Sprite>;
	public function renderMissionBriefing(painter: Painter) : Void {
		painter.translate(0, 0);
		for ( sprite in missionBriefingSprites ) {
			sprite.render(painter);
		}
	}
	
	private function checkVictory() : Bool { return false; }
}