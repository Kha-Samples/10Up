package;

class Jumpman4 extends Jumpman {
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman4");
		Jumpman.setJumpman(3, this);
	}
}
