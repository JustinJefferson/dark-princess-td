extends PanelContainer

signal button_hovered_entered(info)
signal button_hovered_exited

@export var grid : GridContainer
@export var filter_buttons : Array[Button]

var grid_button_ref = preload("res://PlayerActionButton.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	_clear_grid()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func setup(scene_arr: Array):
	_clear_grid()
	_fill_grid(scene_arr)

func _fill_grid(scene_arr: Array):
	for scene in scene_arr:
		if scene is PackedScene:
			_append_grid(scene)


func _append_grid(scene: PackedScene):
	var button = grid_button_ref.instantiate()
	button.set_scene_ref(scene)
	grid.add_child(button)
	button.hover_entered.connect(_on_button_hovered_entered)
	button.hover_exited.connect(_on_button_hovered_exited)


func _clear_grid():
	for child in grid.get_children():
		child.hover_entered.disconnect(_on_button_hovered_entered)
		child.hover_exited.disconnect(_on_button_hovered_exited)
		
		grid.remove_child(child)


func _on_button_hovered_entered(info):
	button_hovered_entered.emit(info)


func _on_button_hovered_exited():
	button_hovered_exited.emit()
