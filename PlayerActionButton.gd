extends CenterContainer

@export var button : Button
@export var scene_ref : PackedScene
var sprite : set = _set_sprite, get = _get_sprite
var label : set = _set_label, get = _get_label
var type : Resource = null
var info := {}


# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = scene_ref.instantiate()
	self.label = scene.get("label")
	type = scene.get("type")
	print(type.label)


func _set_info(scene: Node):
	info = {
		"label": scene.get("label")
	}


func _set_sprite(sprite: Texture2D):
	button.icon = sprite


func _get_sprite() -> Texture2D:
	return button.icon


func _set_label(label: String):
	button.text = label


func _get_label() -> String:
	return button.text


func _get_type() -> Resource:
	if scene_ref:
		var type = scene_ref.get("type")
		if type is Type:
			print(type.label)
			return type
	return null
