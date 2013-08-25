package;

class Level {
	private var timeline: Timeline;
	
	public function new() {
		
	}
	
	public function setTimeline(timeline: Timeline): Void {
		this.timeline = timeline;
	}
	
	public function update(time: Float) {
		timeline.update(time);
	}
}