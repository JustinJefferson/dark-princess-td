extends Node

var floor_scenes : Array[PackedScene] = [
	preload("res://floors/impl/Flail.tscn")
]
var monster_scenes : Array[PackedScene] = [
	preload("res://monsters/impl/Goblin.tscn"),
	preload("res://monsters/impl/Imp.tscn"),
	preload("res://monsters/impl/Golem.tscn")
]


# Called when the node enters the scene tree for the first time.
func _ready():
	monster_scenes.sort_custom(_sort_by_filepath)


func _sort_by_filepath(a, b):
	if a is PackedScene and b is PackedScene:
		return a.resource_path.naturalnocasecmp_to(b.resource_path) < 0
	return false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
