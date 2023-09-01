extends Node2D

@export var max_floors := 10
@export_multiline
var config = ""

var floors = []
var waiting_adventurers = []
var travel_timers : Array[TravelTimer] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _start_tower():
	if !waiting_adventurers.is_empty():
		var travel_timer = TravelTimer.new()
		travel_timer.adventurer = waiting_adventurers.pop_front()
		travel_timer.to_floor = 0
		travel_timer.timeout.connect(_on_travel_timeout)
		travel_timer.start_travel()
		travel_timers.append(travel_timer)


func _is_roof(floor_num) -> bool:
	return floor_num >= floors.size()
	

func _floor_available(floor_num) -> bool:
	if _is_roof(floor_num):
		return false
	return floors[floor_num].adventurer == null


func _on_travel_timeout():
	var timers : Array[TravelTimer] = []
	for timer in travel_timers:
		if timer.is_stopped():
			if _is_roof(timer.to_floor):
				# game over or lose a life point
				pass
			elif _floor_available(timer.to_floor):
				var tower_floor = floors[timer.to_floor]
				tower_floor.place_adventurer(timer.adventurer)
			else:
				timer.to_floor += 1
				timer.start_travel()
				timers.append(timer)
		else:
			timers.append(timer)
	travel_timers = timers
