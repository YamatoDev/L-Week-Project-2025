extends Node3D

var id_string
@export var code_manager: Code_Manager
@export var enemy_spawns: Array[Node3D] = []
<<<<<<< Updated upstream
@export var monster: CollisionShape3D
=======
@export var monster: Area3D
>>>>>>> Stashed changes

func _ready() -> void:
	if GameIdManager.game_id == "" or GameIdManager.game_id == null:
		GameIdManager.id_ready.connect(_on_id_ready)
	else:
		_retrieve_id()

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
	monster.global_position = enemy_spawns[int(id_string[0])].global_position
	print(monster.name, " after: " , monster.global_position)
