extends Node3D

@export var spaceScreen: PhotographyScreen

func _ready() -> void:
	add_to_group("Player")

#func _process(delta: float) -> void:
	#print(global_position)

func on_interact():
	spaceScreen._Activate()
