package ;

import kha.Animation;
import kha.Image;
import kha.Rectangle;
import kha.Sprite;

@:access(kha.Animation) 
@:access(kha.Sprite)
class TimedSpriteInfo {
	public var time(default, null) : Float;
	
	var animation : Animation;
	var collider : Rectangle;
	
	var x : Float;
	var y : Float;
	var width : Float;
	var height : Float;
	var speedx : Float;
	var speedy : Float;
	var accx : Float;
	var accy : Float;
	var maxspeedy : Float;
	var collides : Bool;
	var z : Int;
	
	public function new( time : Float, source : Sprite ) {
		this.time = time;
		
		if ( source.animation != null ) {
			animation = new Animation( [], 0 );
			animation.count = source.animation.count;
			animation.index = source.animation.index;
			animation.indices = source.animation.indices;
			animation.speeddiv = source.animation.speeddiv;
		}
		
		if ( source.collider != null ) {
			collider = new Rectangle( source.collider.x, source.collider.y, source.collider.width, source.collider.height );
		}
		
		x = source.x;
		y = source.y;
		width = source.width;
		height = source.height;
		speedx = source.speedx;
		speedy = source.speedy;
		accx = source.accx;
		accy = source.accy;
		maxspeedy = source.maxspeedy;
		collides = source.collides;
		z = source.z;
	}
	
	public function apply(dest : Sprite) : Void {
		dest.animation = animation;
		
		dest.collider = collider;
		
		dest.x = x;
		dest.y = y;
		dest.width = width;
		dest.height = height;
		dest.speedx = speedx;
		dest.speedy = speedy;
		dest.accx = accx;
		dest.accy = accy;
		dest.maxspeedy = maxspeedy;
		dest.collides = collides;
		dest.z = z;
	}
}

class TimeTravelSprite extends Sprite {
	var timeTravelInfos : List<TimedSpriteInfo>;

	public function new(image:Image, width:Int=0, height:Int=0, z:Int=1) {
		super(image, width, height, z);
		
		timeTravelInfos = new List();
	}
	
	override public function update():Void {
		super.update();
		
		if ( TenUp.getInstance().mode == Game ) {
			var currentTime = TenUp.getInstance().currentGameTime;
			var checkTime = currentTime - 10;
			while ( timeTravelInfos.length > 0 && timeTravelInfos.first().time < checkTime ) {
				timeTravelInfos.pop();
			}
			
			timeTravelInfos.add( new TimedSpriteInfo( currentTime, this ) );
		}
	}
	
	public function timeLeap() : Void {
		// TODO: animate
		var destinationTime = timeTravelInfos.pop();
		destinationTime.apply( this );
		timeTravelInfos.clear();
		timeTravelInfos.add( destinationTime );
	}
}