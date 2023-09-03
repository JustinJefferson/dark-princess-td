extends CenterContainer

signal hover_entered(info)
signal hover_exited()

@export var button : Button
@export var scene_ref : PackedScene
var sprite : set = _set_sprite, get = _get_sprite
var label : set = _set_label, get = _get_label
var info := {}


# Called when the node enters the scene tree for the first time.
func _ready():
	button.mouse_entered.connect(_on_action_hover_entered)
	button.mouse_exited.connect(_on_action_hover_exited)
	if scene_ref:
		_set_info(scene_ref.instantiate())
		for key in info:
			print(info[key])


func set_scene_ref(packed_scene: PackedScene):
	scene_ref = packed_scene
	if packed_scene != null:
		_set_info(packed_scene.instantiate())


func _set_info(scene: Node): 
	info = {
		"label": scene.get("label"),
		"type": scene.get("type"),
		"health": _find_health_info(scene),
		"attack": _find_attack_info(scene),
		"heal": _find_heal_info(scene),
		"speed": _find_speed_info(scene),
		"size": scene.get("size"),
		"slots": scene.get("slots"),
		"max_level": scene.get("max_level")
	}
	
	if info["label"]:
		button.text = info["label"]
	else:
		button.text = ""
	


func _find_health_info(scene: Node):
	var component = scene.get("health")
	if component is HealthComponent:
		return component.base_lvl_health
	return null


func _find_attack_info(scene: Node):
	var component = scene.get("action_component")
	if component is AttackComponent:
		return component.base_lvl_damage
	return null


func _find_heal_info(scene: Node):
	var component = scene.get("action_component")
	if component is HealComponent:
		return component.base_lvl_amount
	return null


func _find_speed_info(scene: Node):
	var component = scene.get("speed")
	if component is SpeedComponent:
		return component.label
	return null


func _set_sprite(sprite: Texture2D):
	button.icon = sprite


func _get_sprite() -> Texture2D:
	return button.icon


func _set_label(label: String):
	button.text = label


func _get_label() -> String:
	return button.text


func _get_type() -> Resource:
	if info.has("type") and info["type"] is Type:
		print(info["type"].label)
		return info["type"]
	return null


func _on_action_hover_entered():
	hover_entered.emit(info)


func _on_action_hover_exited():
	hover_exited.emit()
