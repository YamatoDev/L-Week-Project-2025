class_name MainCamera extends Camera3D

var mouse = Vector2()
var flipped := false
var last_toggle_time := 0
var toggle_cooldown := 1000   # milliseconds (0.3s)
var target_y_rotation := 90.0
var rotation_speed := 5.0 # degrees per frame, adjust for smoothness

# Shaking part
@onready var original_pos: Vector3 = global_position

var shake_factor: float = 0
var shake_duration: float = 0
var shake_intensity: float = 0
var shake_frequency: float = 0
var shaking: bool = false

func _input(event):
	if event is InputEventMouse:
		mouse = event.position

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_selection()

	if Input.is_action_pressed("change_cam"):
		_try_toggle_camera_rotation()

func get_selection():
	var worldspace = get_world_3d().direct_space_state
	var start = project_ray_origin(mouse)
	var end = start + project_ray_normal(mouse) * 1000
	var result = worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(start, end))
	if result and result.collider.has_method("on_interact"):
		result.collider.on_interact()

func _try_toggle_camera_rotation():
	var now = Time.get_ticks_msec()
	if now - last_toggle_time >= toggle_cooldown:
		_toggle_camera_rotation()
		last_toggle_time = now

func _toggle_camera_rotation() -> void:
	flipped = !flipped
	target_y_rotation = 90 if flipped else -90

func _process(delta):
	# Smoothly interpolate the y rotation towards the target
	var current_y = rotation_degrees.y
	if abs(current_y - target_y_rotation) > 0.1:
		rotation_degrees.y = lerp(current_y, target_y_rotation, rotation_speed * delta)
	else:
		rotation_degrees.y = target_y_rotation

	# Shaky part
	if shaking:
		if shake_duration > 0: shake_duration -= delta # Checks if theres still a duration left on shaking
		elif shake_factor > 0: shake_factor -= delta # If not, reduce the shake factor until its zero
		else: # Then shaking is now false if shake factor is now gone
			shaking = false 
			shake_intensity = 0
			shake_frequency = 0
			
		# Actual logic of shaking
		global_position = lerp(original_pos, original_pos + Vector3(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		) * shake_factor, shake_frequency)

# Duration can be optional, along with the intensity and the frequency
# Intensity idealy should be around 0.01 to 0.5, as any more than that is too intense
# Frequency is how smooth the shaking is. 1 is rumbling, while 0.1 is a smooth shaking around.
func shake(factor: float, intensity: float = 0.0, duration: float = 0.0, frequency: float = 1):
	shake_factor = factor
	shake_duration = duration
	shake_intensity = intensity
	shake_frequency = frequency
	shaking = true
