extends AudioListener3D

func _ready() -> void:
	clear_current()
	make_current()
	print("Current: " + str(is_current()))
