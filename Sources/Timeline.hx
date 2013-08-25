package;

import kha.Scheduler;

class TimeEvent {
	public var time: Float;
	public var action: Void -> Void;
	
	public function new(time: Float, action: Void -> Void) {
		this.time = time;
		this.action = action;
	}
}

class Timeline {
	private var events: Array<TimeEvent>;
	
	public function new() {
		events = new Array<TimeEvent>();
	}
	
	public function add(time: Float, action: Void -> Void): Void {
		events.push(new TimeEvent(time, action));
	}

	public function update(time: Float) {
		while (events.length > 0) {
			var event = events[0];
			if (event.time <= time) {
				event.action();
				events.remove(event);
			}
			else break;
		}
	}
}
