class_name LocationManager extends Node

@export_group("Objects")
@export var ship: Node3D
@export var enemyLocations: Array[Node3D] = []

@export_group("Labels")
@export var player_label: Label3D
@export var enemy_label: Label3D

var current_index: int = -1;

func _ready() -> void:
	_move_to_next_enemy()

func _process(delta: float) -> void:
	player_label.text = str(int(ship.global_position.x)) + ", " + str(int(ship.global_position.z))
	enemy_label.text = str(int(enemyLocations[current_index].global_position.x)) + ", " + str(int(enemyLocations[current_index].global_position.z))

func _move_to_next_enemy() -> void:
	if current_index + 1 < enemyLocations.size():
		current_index+=1
