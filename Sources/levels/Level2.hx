package levels;

import kha.Loader;
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
					var sprite = new kha.Sprite( Loader.the.getImage("level2briefing1") );
					sprite.x = 0.5 * (TenUp.instance.width - sprite.width);
					sprite.y = 50;
					missionBriefingSprites.push( sprite );
				case 2:
					missionBriefingSprites = new Array();
					var sprite = new kha.Sprite( Loader.the.getImage("level1briefing0") );
					sprite.x = 0.5 * (TenUp.instance.width - sprite.width);
					sprite.y = 40;
					missionBriefingSprites.push( sprite );
					var sprite = new kha.Sprite( Loader.the.getImage("level2briefing2") );
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
					var sprite = new kha.Sprite( Loader.the.getImage("level2briefing3") );
					sprite.x = 0.5 * (TenUp.instance.width - sprite.width);
					sprite.y = 50;
					missionBriefingSprites.push( sprite );
				default:
					return true;
			}
		}
		if (state >= 2) {
			var aimx = Std.int( computers[0].x );
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
		return false;
	}
}
