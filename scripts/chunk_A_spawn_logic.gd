extends Node3D

var id_string
@export var code_manager: Code_Manager
@export var enemy_spawns: Array[Node3D] = []
@export var monster: CollisionShape3D

func _retrieve_id() -> void:
	id_string = GameIdManager.game_id
	_set_monster_spawn()
	
#func _process(delta: float) -> void:
	#print(id_string[0])
	
func _set_monster_spawn() -> void:
	print(monster.global_position)
	monster.global_position = enemy_spawns[int(id_string[0])].global_position
	print(monster.global_position)
