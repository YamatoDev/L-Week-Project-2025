extends Node3D

@export var radar_init: Radar
@export var ship: Ship

func _ready() -> void:
	ship.radar = radar_init
