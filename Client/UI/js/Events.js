if(typeof Events === 'undefined') {
	Events = {
		_events: [],
		_eventsGame: [],
		Subscribe: function(event, func) {
			console.log('Registering event handler for ' + event);
			Events._events.push({event: event, func: func});
		},
		Trigger: function() {
			let args = [...arguments];
			let event = args[0];
			args.splice(0, 1);

			for (let index = 0; index < Events._events.length; index++) {
				const handler = Events._events[index];
				if (handler.event === event) {
					handler.func.apply(this, args);
				}
			}
		},
		Call: function() {
			let args = [...arguments];
			let event = args[0];
			args.splice(0, 1);

			console.log('NW Event:', event, args);

			for (let index = 0; index < Events._eventsGame.length; index++) {
				const handler = Events._eventsGame[index];
				if (handler.event === event) {
					handler.func.apply(this, args);
				}
			}
		},
		SubscribeGame: function(event, func) {
			Events._eventsGame.push({event: event, func: func});
		}
	}
}

EventsWrapper = {
	_events: {},
	_debouncedEvent: {},
	Subscribe: function(event, func) {
		if (typeof EventsWrapper._events[event] === "undefined") {
			Events.Subscribe(event, EventsWrapper.Handle.bind(this, event));
		}

		EventsWrapper._events[event] = func;
	},
	Handle: function() {
		let args = [...arguments];
		let event = args[0];
		args.splice(0, 1);

		if (EventsWrapper._events[event]) {
			EventsWrapper._events[event].apply(this, args);
		}
	},
	Call: function() {
		Events.Call(...arguments);
	},
	CallDebounced: function() {
		let args = [...arguments];
		let id = args[0];
		args.splice(0, 1);

		EventsWrapper._debouncedEvent[id] = {time: Date.now(), args: args};
	},
	HandleDebouncedEvent: function() {
		setTimeout(EventsWrapper.HandleDebouncedEvent, 25);

		for(let index in EventsWrapper._debouncedEvent) {
			const event = EventsWrapper._debouncedEvent[index];
			if (event.time < Date.now() - 50) {
				Events.Call(...event.args);
				delete EventsWrapper._debouncedEvent[index];
			}
		}
	}
}

setTimeout(EventsWrapper.HandleDebouncedEvent, 25);
