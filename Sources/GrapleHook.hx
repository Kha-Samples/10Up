package;

import kha.Loader;
import kha.math.Vector2;
import kha.Rotation;
import kha.Sprite;

class GrapleHook extends Sprite {
	public function new() {
		super(Loader.the.getImage("graplehook"), 22, 13, 4);
		rotation = new Rotation(new Vector2(22 / 2, 13 / 2), -0.5);
	}
}
