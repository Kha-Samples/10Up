package;

class PlayerAgent extends Player {
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman");
		Player.setPlayer(0, this);
	}
}
