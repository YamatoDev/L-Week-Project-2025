extends Node

#unique identifier for each game
var game_id

#codes here
var code_array = [123, 456, 789, 691, 420, 360] #placeholders - replace with real codes
var num

@onready var code_label = $code

#finds a random code for each start of the game and assigns it to GAME_ID
func _init() -> void:
	num = randi_range(0, (code_array.size() - 1))
	game_id = code_array[num]

func _ready() -> void:
	display_code()

func display_code():
	code_label.text = str(game_id)
