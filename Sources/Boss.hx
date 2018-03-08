package;

import kha.Assets;
import kha2d.Sprite;

class Boss extends Sprite {
	public function new(x: Float, y: Float) {
		super(Assets.images.boss, 26 * 2, 35 * 2);
		this.x = x;
		this.y = y;
	}
}
