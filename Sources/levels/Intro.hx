package levels;

import kha.Assets;
import kha2d.Scene;
import kha2d.Sprite;

class Intro extends Level {
	public function new() {
		super();
		nextLevelNum = 1;
	}
	
	override public function checkVictory():Bool { return true; }
	
	var state = 0;
	override public function updateMissionBriefing(time:Float): Bool {
		if (anyKey) {
			state++;
			switch (state) {
				case 1:
					var logo = new Sprite( Assets.images._10up_logo );
					logo.x = 50;
					logo.y = 0.5 * TenUp.height - 0.5 * logo.height;
					missionBriefingSprites.push( logo );
					var sprite = new kha2d.Sprite( Assets.images.level1briefing0 );
					sprite.x = logo.x + logo.width + 40;
					sprite.y = 0.5 * TenUp.height - 0.5 * sprite.height;
					missionBriefingSprites.push( sprite );
					missionBriefingSprites.push( sprite );
					missionBriefingSprites.push( sprite );
					missionBriefingSprites.push( sprite );
					var sprite = new kha2d.Sprite( Assets.images.introtext1 );
					sprite.x = logo.x + logo.width + 50;
					sprite.y = 0.5 * TenUp.height - 0.5 * sprite.height;
					missionBriefingSprites.push( sprite );
				case 2:
					missionBriefingSprites = new Array();
					var logo = new Sprite( Assets.images._10up_logo );
					logo.x = 50;
					logo.y = 0.5 * TenUp.height - 0.5 * logo.height;
					missionBriefingSprites.push( logo );
					var sprite = new kha2d.Sprite( Assets.images.level1briefing0 );
					sprite.x = logo.x + logo.width + 40;
					sprite.y = 0.5 * TenUp.height - 0.5 * sprite.height;
					missionBriefingSprites.push( sprite );
					missionBriefingSprites.push( sprite );
					missionBriefingSprites.push( sprite );
					missionBriefingSprites.push( sprite );
					missionBriefingSprites.push( sprite );
					var sprite = new kha2d.Sprite( Assets.images.introtext2 );
					sprite.x = logo.x + logo.width + 50;
					sprite.y = 0.5 * TenUp.height - 0.5 * sprite.height;
					missionBriefingSprites.push( sprite );
					// TODO: play SOUND!!!
				default:
					TenUp.instance.victory();
			}
		}
		return false;
	}
}
