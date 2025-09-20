extends Area3D

@export var monster: TextureData
var ship_inside := false

func _on_area_entered(body):
	print("Entered: " + body.name)
	if body.name == "MonsterCheck":
		print("Entered")
		monster.is_active = true
		ship_inside = true

func _on_area_exited(body):
	print("Exited: " + body.name)
	if body.name == "MonsterCheck":
		print("Exited")
		monster.is_active = false
		ship_inside = false
