extends Resource
class_name Type

enum TypeValues{
	Generic,
	Fighter,
	Ranged,
	Mystic,
	Support
}

static var neutral = 1.0
static var weak = 2.0
static var resist = 0.5

@export var label := ""
@export var value := TypeValues.Generic

func multiplier(attack_type: Type) -> float:
	match attack_type.value:
		TypeValues.Fighter:
			return _multiplier(TypeValues.Ranged, TypeValues.Fighter)
		TypeValues.Ranged:
			return _multiplier(TypeValues.Mystic, TypeValues.Ranged)
		TypeValues.Mystic:
			return _multiplier(TypeValues.Fighter, TypeValues.Mystic)
		_:
			return neutral


func _multiplier(weak_type: TypeValues, resist_type: TypeValues) -> float:
	if value == weak_type:
		return weak
	if value == resist_type:
		return resist
	return neutral
