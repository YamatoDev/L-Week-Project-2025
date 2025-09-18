extends Node3D

@export var radar_init: Radar
@export var ship: Ship

func _ready() -> void:
	print(radar_init)
	ship.radar = radar_init
	print(ship.radar)
