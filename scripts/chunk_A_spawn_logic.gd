extends Node3D

@export var code_manager: Code_Manager

func _ready() -> void:
	print(code_manager.id)
