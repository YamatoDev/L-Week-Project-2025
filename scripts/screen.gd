extends CSGBox3D
class_name SpaceScreen

@export var space_screen: CSGBox3D
@export var base_screen_material: Material
@export var normal_screen_material: Material
@export var monsters: Array[MonsterData] = []

var is_active := false


func _ready() -> void:
	space_screen.material = base_screen_material
	_update_monsters()


func _Activate() -> void:
	is_active = !is_active
	_update_monster_data(randi_range(0, 5))
	_update_monsters()


func _update_monsters() -> void:
	if not is_active:
		space_screen.material = base_screen_material
		return

	# Find the first monster marked active and set its material
	for monster in monsters:
		if monster.is_active:
			space_screen.material = monster.material
			return

	# No active monsters
	space_screen.material = normal_screen_material
	
func _update_monster_data(index: int) -> void:
	if(index > monsters.size()-1):
		print("Number " + str(index)  + " too big")
		return

	monsters[index].is_active = !monsters[index].is_active
