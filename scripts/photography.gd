extends Node3D
class_name PhotographyScreen

@export var sound: AudioStreamPlayer3D
@export var space: Array[TextureData] = []
@export var monsters: Array[TextureData] = []
@onready var space_screen:= $SubViewport/textureholder

func _Activate() -> void:
	sound.play()
	_update_monster_data(randi_range(0, 10))

func _play_normal_material(number: int) -> void:
	space_screen.texture = space[number].texture

func _update_monster_data(args) -> void:
	if typeof(args) == TYPE_INT:
		if(args >= monsters.size()):
			_play_normal_material(randi_range(0, 2))
			return
		
		space_screen.texture = monsters[args].texture
	
	elif typeof(args) == TYPE_STRING:
		for monster in monsters:
			if monster.name == args:
				space_screen.texture = monster.texture
	
	else:
		print("not intended")
