extends MarginContainer

@export var floor_tab : Button
@export var monster_tab : Button
@export var spell_tab : Button
@export var menu : PanelContainer
@export var info_panel : PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	floor_tab.toggled.connect(_on_floor_tab_pressed)
	monster_tab.toggled.connect(_on_monster_tab_pressed)
	menu.button_hovered_entered.connect(_on_button_hovered_entered)
	menu.button_hovered_exited.connect(_on_button_hovered_exited)
	menu.visible = false
	info_panel.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_hovered_entered(info):
	info_panel.display_info(info)
	info_panel.visible = true


func _on_button_hovered_exited():
	info_panel.visible = false


func _toggle_tabs(pressed_button: Button, is_pressed, action_scenes: Array):
	var buttons = [floor_tab, monster_tab, spell_tab]
	for button in buttons:
		if button != pressed_button:
			button.button_pressed = false
	
	if is_pressed:
		menu.setup(action_scenes)
		menu.visible = true
	else:
		_hide()


func _hide():
	menu.visible = false
	info_panel.visible = false


func _on_floor_tab_pressed(is_pressed):
	_toggle_tabs(floor_tab, is_pressed, PlayerData.floor_scenes)


func _on_monster_tab_pressed(is_pressed):
	_toggle_tabs(monster_tab, is_pressed, PlayerData.monster_scenes)
