extends Node3D

@export var radar_init: Radar
@export var ship: Ship
@export var camera_init: Camera3D

var move_direction := 0
var steer_direction := 0.0

func _ready() -> void:
	ship.radar = radar_init
	ship.camera = camera_init
	
func _process(_delta: float) -> void:
	steer_direction = Input.get_axis("steer_left", "steer_right")
	
	#print(move_direction, steer_direction)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_move_forward"):
		move_direction = 1 if move_direction != 1 else 0
	if event.is_action_pressed("toggle_move_backward"):
		move_direction = -1 if move_direction != -1 else 0
