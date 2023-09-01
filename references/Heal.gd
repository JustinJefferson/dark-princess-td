extends Action
class_name Heal

var amount = 0

func duplicate() -> Action:
	var new_heal = Heal.new()
	new_heal.actor = actor
	new_heal.target = target
	new_heal.effect = effect
	new_heal.amount = amount
	return new_heal
