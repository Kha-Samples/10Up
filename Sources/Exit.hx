package;

import kha.Scene;
import kha.Sprite;

class Exit extends Sprite {
	public function new(x : Int, y : Int) {
		super(null, 32, 32, 0);
		this.x = x;
		this.y = y;
		accy = 0;
	}
	
	public override function hit(sprite : Sprite) {
		Scene.the.removeEnemy(this);
		Jumpman.getInstance().nextRound();
		TenUp.getInstance().startGame();
	}
}