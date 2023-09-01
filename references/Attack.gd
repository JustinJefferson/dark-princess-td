extends Action
class_name Attack

var damage = 0 : get = _get_damage

func _get_damage() -> int:
	if actor != null and target != null:
		var multiplier = target.type.multiplier(actor.type)
		return int(damage * multiplier)
	return damage


func duplicate() -> Action:
	var new_attack = Attack.new()
	new_attack.actor = actor
	new_attack.target = target
	new_attack.effect = effect
	new_attack.damage = damage
	return new_attack

