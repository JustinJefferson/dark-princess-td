extends ActionComponent
class_name HealComponent

@export var base_lvl_amount := 5
@export var max_lvl_amount := 25
var amount: int


func _ready():
	amount = base_lvl_amount


func create_action() -> Action:
	var heal = Heal.new()
	heal.amount = amount
	return heal


func update(level: int, max_level: int):
	var percentage : float = float(level) / float(max_level)
	var extra_amount : float = float(max_lvl_amount - base_lvl_amount) * percentage
	amount = base_lvl_amount + int(extra_amount)
