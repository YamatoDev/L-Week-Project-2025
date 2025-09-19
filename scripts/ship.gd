class_name Ship extends Node3D

var radar: Radar: set = _set_radar, get = _get_radar
@export var ray: Marker3D
@export var rotation_speed: float

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

# func _process(_delta: float) -> void:f
# 	if (ray.is_colliding()):
# 		var body: Area3D = ray.get_collider()
# 		if (!hit_bodies.has(body)):
# 			ping_radar(body)
			
# 	pass

func ping_radar(body: Area3D) -> void:
	hit_bodies.push_back(body)

	# TODO: Implement at radar itself
	
	var local_position = to_local(body.global_position)
	var radar_scale = -0.03125

	var radar_x = local_position.x / radar_scale
	var radar_z = local_position.z / radar_scale

	radar.add_ping(radar_x, radar_z)

	await get_tree().create_timer(2.0).timeout

	# Garbage
	hit_bodies.remove_at(hit_bodies.find(body))

	pass

func on_area_entered(area: Area3D) -> void:
	if (area != $Area3D):
		ping_radar(area)
