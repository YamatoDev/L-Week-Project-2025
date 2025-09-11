extends Camera3D

var mouse = Vector2()
var flipped := false

func _input(event):
	if event is InputEventMouse:
		mouse = event.position
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_selection()
	
	if Input.is_action_pressed("change_cam"):
		_toggle_camera_rotation() 

func get_selection():
	var worldspace = get_world_3d().direct_space_state
	var start = project_ray_origin(mouse)
	var end = start + project_ray_normal(mouse) * 1000
	var result = worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(start, end))
	print(result)
	if result and result.collider.has_method("on_interact"):
		result.collider.on_interact()


func _toggle_camera_rotation() -> void:
	flipped = !flipped
	if flipped:
		$".".rotation_degrees.y = 90
	else:
		$".".rotation_degrees.y = -90
