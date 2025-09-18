extends Node

#Code by Kaizen
#This script manages the unique IDs of each game. It will choose a new ID and will never repeat the last one.
#GAME_ID will be displayed using CODE_MANAGER script

#IMPORTANT: To find the id_data.cfg, copy paste this directory into your file_explorer: C:\Users\[Your System Name]\AppData\Roaming\Godot\app_userdata\LWEEK\(id_data.cfg)

#unique identifier for each game
var game_id
#holds previous GAME_ID to avoid repetition per game
var prev_id

#codes here
var id_array = [123, 456, 789, 691, 420, 360] #placeholders - replace with real codes
var temp_num

func _find_code() -> void:
	#finds old id stored in USER://ID_DATA.CFG
	prev_id = _load_prev_id()
	#unique id every game
	game_id = _pick_unique_id(prev_id)
	print("Previous game_id: ", prev_id)
	#stores current GAME_ID to USER://ID_DATA.CFG
	_save_prev_id(game_id)

#loads PREV_ID. If ID_DATA.CFG doesn't exist, this won't do anything
func _load_prev_id() -> int:
	var saved_game_id = ConfigFile.new()
	if saved_game_id.load("user://id_data.cfg") == OK:
		return int (saved_game_id.get_value("game", "prev_id", -1))
	print("Couldn't find ID_DATA.CFG! Returning -1")
	return -1

#repeats until unique id is made
func _pick_unique_id(previous: int) -> int:
	temp_num = randi_range(0, id_array.size() - 1)
	var temp_id = id_array[temp_num]
	while temp_id == previous:
		print("Previous GAME_ID used. Rerandomizing...")
		temp_num = randi_range(0, id_array.size() - 1)
		temp_id = id_array[temp_num]
	return temp_id;

#saves current GAME_ID. Makes a new ID_DATA.CFG if cfg doesn't already exist
func _save_prev_id(id_to_save: int) -> void:
	var saved_game_id = ConfigFile.new()
	saved_game_id.set_value("game", "prev_id", id_to_save)
	saved_game_id.save("user://id_data.cfg")
	print("Saved to USER://ID_DATA.CFG")
