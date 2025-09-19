extends Node3D

@export var area: Area3D
@export var asteroid_instance_path: PackedScene

@onready var shape: Shape3D = area.get_node("CollisionShape3D").shape
var shape_min: Vector3
var shape_max: Vector3

@export var spawn_cd: float
var spawn_cd_left: float

func _ready() -> void:
	shape_min = -(shape.size / 2)
	shape_max = (shape.size / 2)
	spawn_cd_left = spawn_cd
	randomize()
	
func _process(delta: float) -> void:
	if (spawn_cd_left > 0): spawn_cd_left -= delta

	if (spawn_cd_left <= 0):
		var new_asteroid = asteroid_instance_path.instantiate()
		new_asteroid.set_position(Vector3(
			randf_range(shape_min.x, shape_max.x), 
			randf_range(shape_min.y, shape_max.y),
			randf_range(shape_min.z, shape_max.z)
		))

		new_asteroid.set_rotation_degrees(Vector3(0, 0, 0))

		add_child(new_asteroid)
		
		spawn_cd_left = spawn_cd
