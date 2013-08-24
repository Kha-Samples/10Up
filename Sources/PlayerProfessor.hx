package;

class PlayerProfessor extends Player {
	public function new(x: Float, y: Float) {
		super(x, y, "jumpman2");
		Player.setPlayer(1, this);
	}
}
