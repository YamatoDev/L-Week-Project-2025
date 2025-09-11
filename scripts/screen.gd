extends CSGBox3D
class_name SpaceScreen

@export var spaceScreen: CSGBox3D
@export var baseScreenMaterial: Material   # drag a material with your image here
@export var baseSpaceMaterial: Material   # drag a material with your image here
@export var monsters: Array[Sprite3D] = []
@export var monsterStatus: Array[bool] = []

var isActive := false

func _ready() -> void:
	spaceScreen.material  = baseScreenMaterial   # start with no material
	_update_monsters()

func _Activate() -> void:
	isActive = !isActive

	if isActive:
		spaceScreen.material  = baseSpaceMaterial
	else:
		spaceScreen.material  = baseScreenMaterial  # remove the material
	_update_monsters()

func _update_monsters() -> void:
	var count = min(monsters.size(), monsterStatus.size())
	for i in count:
		monsters[i].visible = monsterStatus[i] and isActive
