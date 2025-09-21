extends Area3D

@export var monster: TextureData
@export var time_limit: float
@export var camera: MainCamera
@export var ship: Ship
@export var return_point: Node3D
#@export var audio: AudioStreamPlayer3D

var ship_inside := false
var timer : float

func _on_area_entered(body):
	print("Entered: " + body.name)
	if body.name == "MonsterCheck":
		print("Monster Active")
		monster.is_active = true
		ship_inside = true
		ship.monster_active = true
		#audio.play()

func _on_area_exited(body):
	print("Exited: " + body.name)
	if body.name == "MonsterCheck":
		print("Monster Not Active")
		monster.is_active = false
		ship_inside = false
		ship.monster_active = false
		#audio.stop()

func _process(delta: float) -> void:
	if ship_inside:
		timer += delta
		if timer >= time_limit:
			print("Caught")
			_caught_player()
			timer = 0

func _caught_player() -> void:
	ship.ship_hit()
	teleport()
	
func teleport():
	ship.global_position = return_point.global_position
