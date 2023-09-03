extends PanelContainer

@export var name_label : Label
@export var group_label : Label
@export var cost_label : Label
@export var type_label : Label
@export var type_value : Label
@export var health_label : Label
@export var health_value : Label
@export var attack_label : Label
@export var attack_value : Label
@export var heal_label : Label
@export var heal_value : Label
@export var speed_label : Label
@export var speed_value : Label
@export var size_label : Label
@export var size_value : Label
@export var slots_label : Label
@export var slots_value : Label
@export var max_level_label : Label
@export var max_level_value : Label

func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func display_info(dict: Dictionary):
	if _value_exists(dict, "label"):
		name_label.text = dict["label"]
		name_label.visible = true
	else:
		name_label.visible = false
	
	if _value_exists(dict, "group"):
		group_label.text = dict["group"]
		group_label.visible = true
	else:
		group_label.visible = false
	
	if _value_exists(dict, "cost"):
		cost_label.text = String(dict["cost"])
		cost_label.visible = true
	else:
		cost_label.visible = false
	
	if _value_exists(dict, "type"):
		type_value.text = dict["type"].label
		type_label.visible = true
		type_value.visible = true
	else:
		type_label.visible = false
		type_value.visible = false
	
	
	
	_show_label(dict, "health", health_label, health_value)
	_show_label(dict, "attack", attack_label, attack_value)
	_show_label(dict, "heal", heal_label, heal_value)
	_show_label(dict, "speed", speed_label, speed_value)
	_show_label(dict, "size", size_label, size_value)
	_show_label(dict, "slots", slots_label, slots_value)
	_show_label(dict, "max_level", max_level_label, max_level_value)


func _show_label(dict: Dictionary, key: String, label: Label, value_label: Label):
	if _value_exists(dict, key):
		value_label.text = str(dict[key])
		label.visible = true
		value_label.visible = true
	else:
		label.visible = false
		value_label.visible = false


func _value_exists(dict: Dictionary, key: String) -> bool:
	return dict.has(key) and dict[key] != null
