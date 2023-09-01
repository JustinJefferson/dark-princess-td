extends Timer
class_name TravelTimer

const time_length = 3.0

var adventurer = null
var to_floor = 0

func start_travel():
	start(time_length)
