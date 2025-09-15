extends CSGBox3D
class_name SpaceScreen

@export var space_screen: CSGBox3D
@export var normal_screen_material: Material
@export var monsters: Array[MonsterData] = []

var is_active := false


func _ready() -> void:
	_update_monsters()


func _Activate() -> void:
	is_active = !is_active
	_update_monsters()


func _update_monsters() -> void:
	if not is_active:
		return

	_update_monster_data(randi_range(0, 5))
	#_update_monster_data("Golshi")
	
	# Find the first monster marked active and set its material
	for monster in monsters:
		if monster.is_active:
			space_screen.material = monster.material
			monster.is_active = !monster.is_active
			return

	# No active monsters
	space_screen.material = normal_screen_material

func _update_monster_data(args) -> void:
	if typeof(args) == TYPE_INT:
		if(args >= monsters.size()):
			print("Number " + str(args) + " too big")
			return
		
		monsters[args].is_active = !monsters[args].is_active
		print(str(args))
	
	elif typeof(args) == TYPE_STRING:
		for monster in monsters:
			if monster.name == args:
				monster.is_active = !monster.is_active
		print(str(args))
	
	else:
		print("not intended")
