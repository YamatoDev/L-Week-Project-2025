extends Node3D
class_name PhotographyScreen

@export var sound: AudioStreamPlayer3D
@export var space: Array[TextureData] = []
@export var monsters: Array[TextureData] = []
@export var score_display: Label3D
@export var congrats: Control
@onready var space_screen:= $SubViewport/textureholder

var score: int = 0;

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
		if (!textureData.picture_taken):
			print("new pic")
			textureData.picture_taken = true
			_update_text()
	else:
		_play_normal_material(randi_range(0, 2))

func _update_text() -> void:
	score+=1
	score_display.text = str(score) + "/3"
	
	if score >= 3:
		congrats.visible = true
