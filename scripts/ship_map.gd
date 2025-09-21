extends Node3D

@export var radar_init: Radar
@export var ship: Ship
@export var camera_init: Camera3D

var move_direction := 0
var steer_direction := 0.0

func _ready() -> void:
	ship.radar = radar_init
<<<<<<< Updated upstream
	ship.camera = camera_init
	
func _process(_delta: float) -> void:
	steer_direction = Input.get_axis("steer_left", "steer_right")
	
	#print(move_direction, steer_direction)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_move_forward"):
		move_direction = 1 if move_direction != 1 else 0
	if event.is_action_pressed("toggle_move_backward"):
		move_direction = -1 if move_direction != -1 else 0
=======
	print(ship.radar)

func _process(delta: float) -> void:
	move_direction = Input.get_axis("toggle_move_backward",  "toggle_move_forward")
	steer_direction = Input.get_axis("steer_left", "steer_right")
	
func _physics_process(delta: float) -> void:
	var target_velocity = Vector3(steer_direction * abs(move_direction) * 2.5, 0.0, -move_direction * 2.5) * basis
	var delta_velocity = target_velocity - velocity
	
	velocity += delta_velocity * delta
	position += velocity * delta
>>>>>>> Stashed changes
