extends Node
class_name HealthComponent

signal health_depleted

@export var base_lvl_health := 10
@export var max_lvl_health := 50
var max_health := 10
var health : int


func _ready():
	max_health = base_lvl_health
	health = base_lvl_health


func damage(attack: Attack):
	health -= attack.get_damage()
	if health <= 0:
		health = 0
		emit_signal("health_depleted")
	


func heal(heal_ref: Heal):
	health += heal_ref.amount
	if health > max_health:
		health = max_health


func update(level: int, max_level: int):
	var percentage : float = float(level) / float(max_level)
	var extra_health : float = float(max_lvl_health - base_lvl_health) * percentage
	var new_health : int = base_lvl_health + int(extra_health)
	var health_gained = new_health - max_health
	max_health = new_health
	health += health_gained
