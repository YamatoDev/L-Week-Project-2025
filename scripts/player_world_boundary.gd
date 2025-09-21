extends Area3D

@export var player_path: NodePath

func _ready() -> void:
	body_exited.connect(_on_body_exited)
	
func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		var pos = body.global_position
		pos.z = 0.0
		body.global_position = pos
		print("die")
