class_name Radar extends Node

@export var radar_sweep: TextureRect
@export var viewport: SubViewport

func _ready() -> void:
	pass

func rotate_sweep(rotation) -> void:
	radar_sweep.rotation_degrees = rotation
	pass

# offset
func add_ping(x: float, y: float) -> void:
	var ping = TextureRect.new()

	ping.texture = load("res://textures/radar_ping.png")
	ping.name = "RadarPing"
	ping.size = Vector2(16, 16)

	var center = viewport.size / 2
	var ping_offset = ping.size / 2
	
	ping.set_position(Vector2(x + center.x - ping_offset.x, y + center.y - ping_offset.y))
	ping.modulate = Color(1.0, 1.0, 1.0, 1.0)

	viewport.add_child(ping)

	var tween := create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(ping, "modulate", Color(1, 1, 1, 0), 4)

	await tween.finished
	ping.queue_free()

	pass
