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
	var symbol = id_string[2]
	var index = _char_to_index(symbol)
	monster.global_position = enemy_spawns[index].global_position
	print(monster.global_position)
	
func _char_to_index(ch: String) -> int:
	match ch:
		"<": return 0
		">": return 1
		"+": return 2
		"-": return 3
		"=": return 4
		"?": return 5
		_: return 0
