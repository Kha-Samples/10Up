package;

class PlayerBlondie extends Player {
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman4");
		Player.setPlayer(3, this);
	}
}
