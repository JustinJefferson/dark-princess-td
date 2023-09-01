extends Node2D

@export var type : Resource
@export var health : HealthComponent
@export var action_component : ActionComponent
@export var speed : SpeedComponent
@export_range(0,3)
var slots = 3

var monsters = []
var adventurer = null
var readied_actors = []
var current_action = null

func _ready():
	if speed != null:
		speed.timer_finished.connect(_on_speed_timer_finished())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_action == null and !readied_actors.is_empty() and adventurer != null:
		var actor = readied_actors.pop_front()
		next_action(actor.create_action())
	
	#Replace this with a signal to handle animation
	if current_action:
		process_action(current_action)
	elif readied_actors.is_empty() and adventurer and adventurer.is_battle_ended():
		# signal release adventurer
		pass


func next_action(action: Action):
	if action.actor != adventurer:
		action.target = [adventurer]
	else:
		#Determine target of adventurer
		pass
	current_action = action


func process_action(action: Action):
	if action.target is Array:
		for t in action.target:
			var new_action = action.duplicate()
			new_action.target = t
			t.handle_action(action)
	elif action.target:
		action.target.handle_action(action)
	current_action = null


func place_adventurer(_adventurer):
	if adventurer == null:
		adventurer = _adventurer
		adventurer.action_ready.connect(_on_actor_action_ready)
		_check_action_ready(adventurer)
		_check_action_ready(self)
		for monster in monsters:
			_check_action_ready(monster)

func slots_available():
	var slots_used = 0
	for monster in monsters:
		slots_used += monster.size
	return slots - slots_used


func _check_action_ready(actor):
	if actor.is_action_ready():
		readied_actors.append(actor)


func create_action() -> Action:
	var action_ref = action_component.create_action()
	action_ref.actor = self
	return action_ref


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

func is_action_ready():
	if speed:
		return speed.timer.is_stopped()
	return false


func _add_readied_actor(actor):
	if adventurer and !adventurer.is_battle_ended():
		readied_actors.append(actor)


func _on_speed_timer_finished():
	_add_readied_actor(self)


func _on_actor_action_ready(actor):
	_add_readied_actor(actor)
