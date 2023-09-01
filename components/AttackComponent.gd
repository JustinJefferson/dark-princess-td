extends ActionComponent
class_name AttackComponent

@export var base_lvl_damage := 5
@export var max_lvl_damage := 25
var damage : int


func _ready():
	damage = base_lvl_damage


func create_action() -> Action:
	var attack = Attack.new()
	attack.damage = damage
	return attack


func update(level: int, max_level: int):
	var percentage : float = float(level) / float(max_level)
	var extra_dmg : float = float(max_lvl_damage - base_lvl_damage) * percentage
	damage = base_lvl_damage + int(extra_dmg)
