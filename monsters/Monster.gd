extends Node2D

static var max_level = 10

signal action_ready(actor)

@export var label := ""
@export var type : Resource
@export var health : HealthComponent
@export var action_component : ActionComponent
@export var speed : SpeedComponent
@export_range(1, 3)
var size = 1
@export_range(0, 100)
var cost = 25

var level = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	if speed != null:
		speed.timer_finished.connect(_on_speed_timer_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_action() -> Action:
	var action = action_component.create_action()
	action.actor = self
	return action


func handle_action(action: Action):
	if health != null:
		if action is Attack:
			health.damage(action)
		elif action is Heal:
			health.heal(action)
	
	if action.effect != null:
		# Handle effect here
		pass


func reset():
	if speed != null:
		speed.reset()


func level_up():
	level += 1
	if level > max_level:
		level = max_level
	
	if health != null:
		health.update(level, max_level)
	
	if action_component != null:
		action_component.update(level, max_level)


func is_action_ready():
	if speed:
		return speed.timer.is_stopped()
	return false


func _on_speed_timer_finished():
	emit_signal("action_ready", self)


