class_name Ship extends Node3D

@export var radar: Radar: set = _set_radar, get = _get_radar
@export var camera: MainCamera
@export var move_speed: float

@export var ray: Marker3D
@export var rotation_speed: float
@onready var area: Area3D = $Area3D
@export var red_light: Light3D

var redlight_timer: float = 0
var redlight_flashtime: float = 0
var redlight_flashing: bool = false

var move_direction := 0
var steer_direction := 0.0
var velocity := Vector3.ZERO

var monster_active: bool = false

var hit_bodies: Array = []

func _ready() -> void:
	if (radar == null): push_error("Why is your radar fucked?")

func _set_radar(_radar: Radar) -> void:
	radar = _radar
	print("Set new Radar: ", _radar)
	print("Current Radar: ", radar)
	print(get_stack())

func _get_radar() -> Radar:
	return radar

func _physics_process(delta: float) -> void:
	ray.rotate_y(-deg_to_rad(rotation_speed * delta))
	radar.rotate_sweep(-ray.rotation_degrees.y) # ???????????

	var target_velocity = Vector3(steer_direction * abs(move_direction) * move_speed, 0.0, -move_direction * move_speed) * basis
	var delta_velocity = target_velocity - velocity
	
	velocity += delta_velocity * delta
	position += velocity * delta

func _process(delta: float) -> void:
	steer_direction = Input.get_axis("steer_left", "steer_right")

	if monster_active: redlight_flashing = true
	else: redlight_flashing = false

	if redlight_flashing:
		redlight_timer += delta
		redlight_flashtime = sin(redlight_timer * 5) * .5

		if redlight_flashtime > 0: red_light.visible = true
		else: red_light.visible = false
	else:
		redlight_timer = 0
		redlight_flashtime = 0
		red_light.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_move_forward"):
		print(1 if move_direction != 1 else 0)
		move_direction = 1 if move_direction != 1 else 0
	if event.is_action_pressed("toggle_move_backward"):
		print(-1 if move_direction != -1 else 0)
		move_direction = -1 if move_direction != -1 else 0

func ping_radar(body: Area3D) -> void:
	hit_bodies.push_back(body)

	# TODO: Implement at radar itself
	print(body)
	
	var local_position = to_local(body.global_position)
	var radar_scale = -0.0625

	var is_monster: bool = body.is_in_group("monster")
	print(is_monster)

	var radar_x = local_position.x / radar_scale
	var radar_z = local_position.z / radar_scale

	radar.add_ping(radar_x, radar_z, is_monster)

	await get_tree().create_timer(2.0).timeout

	# Garbage
	hit_bodies.remove_at(hit_bodies.find(body))

	pass

func on_area_entered(_area: Area3D) -> void:
	if (_area != $Area3D and _area != $MonsterCheck):
		ping_radar(_area)

func ship_hit():
	global_position = global_position + Vector3(randf_range(-4, 4), 0, randf_range(-4, 4))
	camera.shake(2, 0.10, 2)
