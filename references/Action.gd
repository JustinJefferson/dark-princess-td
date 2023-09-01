extends RefCounted
class_name Action

var actor = null
var target = null
var effect = null

func duplicate() -> Action:
	var new_action = Action.new()
	new_action.actor = actor
	new_action.target = target
	new_action.effect = effect
	return new_action
