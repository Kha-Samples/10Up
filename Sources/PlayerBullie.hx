package;

class PlayerBullie extends Player {
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman3");
		Player.setPlayer(2, this);
	}
}
