class_name LocationManager extends Node

@export_group("Objects")
@export var ship: Node3D

@export_group("Labels")
@export var player_label: Label3D

var current_index: int = -1;
func _process(_delta: float) -> void:
	player_label.text = str(int(ship.global_position.x)) + ", " + str(int(ship.global_position.z))
