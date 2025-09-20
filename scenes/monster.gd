extends Area3D

var ship_inside := false

func _on_area_entered(body):
	print(body.name)
	if body.name == "ship":
		print("Entered")
		ship_inside = true

func _on_area_exited(body):
	print(body.name)
	if body.name == "ship":
		print("Exited")
		ship_inside = false
