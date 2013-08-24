package;

class Jumpman1 extends Jumpman {
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman");
		Jumpman.setJumpman(0, this);
	}
}
