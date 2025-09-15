class_name Ship extends Node3D

@export var radar: Radar
@export var ray: Marker3D
@export var rotation_speed: float

var hit_bodies: Array = []

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	ray.rotate_y(-deg_to_rad(rotation_speed * delta))
	radar.rotate_sweep(-ray.rotation_degrees.y)

# func _process(_delta: float) -> void:
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
