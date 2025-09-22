extends Node3D

var id_string
@export var code_manager: Code_Manager
@export var enemy_spawns: Array[Node3D] = []
@export var monster: Area3D

func _ready() -> void:
	if GameIdManager.game_id == "" or GameIdManager.game_id == null:
		GameIdManager.id_ready.connect(_on_id_ready)
	else:
		_retrieve_id()

	print ("DEBUG: -- CHUNK C SPAWN LOCATIONS --")
	var i: int = 0
	for enemypos in enemy_spawns:
		print("[%s] %d, %d" % [_index_to_char(i), int(enemypos.global_position.x), int(enemypos.global_position.z)])
		i += 1

func _on_id_ready(gid: String) -> void:
	id_string = gid
	_set_monster_spawn()
	
func _retrieve_id() -> void:
	id_string = GameIdManager.game_id
	_set_monster_spawn()
	
#func _process(delta: float) -> void:
	#print(id_string[0])
	
func _set_monster_spawn() -> void:
	print(monster.name, " intial: " , monster.global_position)
	var symbol = id_string[2]
	var index = _char_to_index(symbol)
	monster.global_position = enemy_spawns[index].global_position
	print(monster.name, " after: " , monster.global_position)
	
func _char_to_index(ch: String) -> int:
	match ch:
		"<": return 0
		">": return 1
		"+": return 2
		"-": return 3
		"=": return 4
		"?": return 5
		_: return 0

func _index_to_char(ch: int) -> String:
	match ch:
		0: return "<"
		1: return ">"
		2: return "+"
		3: return "-"
		4: return "="
		5: return "?"
		_: return "null"
