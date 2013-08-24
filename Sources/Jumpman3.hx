package;

class Jumpman3 extends Jumpman {
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman3");
		Jumpman.setJumpman(2, this);
	}
}
