extends Node
class_name SpeedComponent

signal timer_finished

enum Speed {
	VERY_FAST = 4,
	FAST = 6,
	NORMAL = 8,
	SLOW = 12,
	VERY_SLOW = 16,
	EXTREMELY_SLOW = 24
}

@export var speed := Speed.NORMAL

var timer = Timer.new()
var timer_ready = false
var label : get = _get_label

func _ready():
	timer.timeout.connect(_on_timeout)
	reset()


func reset():
	timer.start(float(speed))

func _on_timeout():
	timer_ready = true


func _get_label():
	match speed:
		Speed.VERY_FAST:
			return "Very Fast"
		Speed.FAST:
			return "Fast"
		Speed.NORMAL:
			return "Normal"
		Speed.SLOW:
			return "Slow"
		Speed.VERY_SLOW:
			return "Very Slow"
		Speed.EXTREMELY_SLOW:
			return "Extremely Slow"

