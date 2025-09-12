extends Node

@onready var code_display = $code_display

func _ready() -> void:
	var game_id = GameIdManager.game_id
	code_display.text = str(game_id)
	print("Current game_id: ", game_id)
