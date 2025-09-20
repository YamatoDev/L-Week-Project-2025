extends Node3D
class_name PhotographyScreen

@export var sound: AudioStreamPlayer3D
@export var space: Array[TextureData] = []
@export var monsters: Array[TextureData] = []
@onready var space_screen:= $SubViewport/textureholder

func _Activate() -> void:
	sound.play()
	
	for monster in monsters:
		if monster.is_active:
			_update_texture(monster)
			return
	
	_play_normal_material(randi_range(0, 2))

func _play_normal_material(number: int) -> void:
	_update_texture(space[number])

func _update_monster_data(args) -> void:
	if typeof(args) == TYPE_INT:
		if(args >= monsters.size()):
			_play_normal_material(randi_range(0, 2))
			return
		
		_update_texture(monsters[args])
	
	elif typeof(args) == TYPE_STRING:
		for monster in monsters:
			if monster.name == args:
				_update_texture(monster)
	
	else:
		print("not intended")

func _update_texture(textureData: TextureData):
	if textureData.is_active:
		space_screen.texture = textureData.texture
	else:
		_play_normal_material(randi_range(0, 2))
