package;

class Jumpman2 extends Jumpman {
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman2");
		Jumpman.setJumpman(1, this);
	}
}
