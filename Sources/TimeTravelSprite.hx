package ;

import kha.Animation;
import kha.Direction;
import kha.Image;
import kha.math.Vector2;
import kha.Rectangle;
import kha.Scene;
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
	
	var customFields : Map<String, Dynamic>;
	
	public function new( time : Float, source : TimeTravelSprite ) {
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
		
		customFields = new Map<String,Dynamic>();
		source.saveCustomFieldsForTimeLeap( customFields );
	}
	
	public function apply(dest : TimeTravelSprite) : Void {
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
		
		dest.restoreCustomFieldsFromTimeLeap( customFields );
	}
}

class TimeTravelSprite extends Sprite {
	var snapshotCounter : Int = 0;
	var timeTravelInfos : List<TimedSpriteInfo>;
	public var isTimeLeaping(default, null) : Bool = false;
	public var isUseable(default, null) : Bool = false;
	public var isLiftable(default, null) : Bool = false;
	
	public function new(image:Image, width:Int=0, height:Int=0, z:Int=1) {
		super(image, width, height, z);
		
		timeTravelInfos = new List();
	}
	
	public var center(get, never) : Vector2;
	@:noCompletion @:extern private inline function get_center() : Vector2 {
		return new Vector2(Math.round(x - collider.x) + 0.5 * width, Math.round(y - collider.y) + 0.5 * height);
	}
	
	public function useFrom( dir : Direction ) { }
	
	override public function update():Void {
		super.update();
		
		if ( TenUp.getInstance().mode == Game ) {
			if ( isTimeLeaping ) {
				if ( timeTravelInfos.length > 1 ) {
					var timeStep = timeTravelInfos.last();
					timeTravelInfos.remove( timeStep );
					timeStep.apply( this );
					collides = false;
					isTimeLeaping = true;
				} else {
					var timeStep = timeTravelInfos.last();
					timeStep.apply( this );
					isTimeLeaping = false;
					collides = true;
				}
			} else {
				if (snapshotCounter == 0) {
					snapshotCounter = 1;
					var currentTime = TenUp.getInstance().currentGameTime;
					var checkTime = currentTime - 10;
					while ( timeTravelInfos.length > 0 && timeTravelInfos.first().time < checkTime ) {
						timeTravelInfos.pop();
					}
					timeTravelInfos.add( new TimedSpriteInfo( currentTime, this ) );
				} else {
					snapshotCounter = (snapshotCounter + 1) % 4;
				}
			}
		}
	}
	
	private function saveCustomFieldsForTimeLeap( storage : Map < String, Dynamic > ) : Void { }
	private function restoreCustomFieldsFromTimeLeap( storage : Map < String, Dynamic > ) : Void { }
	
	static var timeLeapingSprite : TimeTravelSprite;
	public function timeLeap() : Void {
		collides = false;
		isTimeLeaping = true;
	}
}