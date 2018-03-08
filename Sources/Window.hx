package;

import kha.Assets;
import kha.graphics2.Graphics;
import kha.math.Random;
import kha2d.Scene;
import kha2d.Sprite;

class Window extends Sprite {
	private var visible2 = true;
	
	public function new(x: Float, y: Float) {
		super(Assets.images.window, 16 * 2, 80 * 2);
		this.x = x;
		this.y = y;
		accy = 0;
	}
	
	override public function hit(sprite: Sprite): Void {
		if (visible2) {
			visible2 = false;
			for (i in 0...100) Scene.the.addProjectile(new Glass(x + Random.getUpTo(16 * 2), y + Random.getUpTo(16 * 2)));
		}
	}
	
	override public function render(g: Graphics): Void {
		if (visible2) super.render(g);
	}
}
