extends Node3D

@export var speed: float
@export var expiry: float

func _physics_process(delta: float) -> void:
	var forward = -get_global_transform().basis.z
	var change = forward * speed * delta
	
	set_global_position(global_position + change)

	expiry -= delta
	if (expiry <= 0): queue_free()

	pass
