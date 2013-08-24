package;

import kha.Animation;
import kha.Image;
import kha.Loader;
import kha.Rectangle;
import kha.Scene;
import kha.Sound;
import kha.Sprite;

class BonusBlock extends Sprite {
	static var theimage: Image;
	static var sound: Sound;
	var downcount: Int;
	var washit: Bool;
	static var onehit: Bool = false;
	static var initialized = false;
	
	static function init() {
		if (!initialized) {
			BonusBlock.theimage = Loader.the.getImage("bonusblock");
			sound = Loader.the.getSound("coin");
			initialized = true;
		}
	}
	
	public function new(x : Float, y : Float) {
		init();
		super(BonusBlock.theimage, Std.int(BonusBlock.theimage.width / 2), BonusBlock.theimage.height, 0);
		this.x = x;
		this.y = y;
		accy = 0;
		washit = false;
		downcount = 0;
		collider = new Rectangle(0, 0, BonusBlock.theimage.width / 2, BonusBlock.theimage.height + 14);
	}
	
	public override function update() {
		if (downcount > 0) {
			--downcount;
			if (downcount == 0) {
				y += 20;
				onehit = false;
			}
		}
	}
	
	public override function hit(sprite : Sprite) {
		if (!washit && !onehit && downcount == 0 && sprite.speedy < 0) {
			sound.play();
			y -= 20;
			downcount = 8;
			onehit = true;
			washit = true;
			Scene.the.addEnemy(new BlockCoin(x + width / 2, y));
			setAnimation(Animation.create(1));
			Jumpman.getInstance().selectCoin();
		}
	}
}