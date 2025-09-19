class_name Code_Manager extends Node

#Code by Kaizen

@onready var code_display = $code_display
var id: String 

func _ready():
	print(code_display)
	pass

#uses the signal created in MENU_SCREEN.GD to apply it in CODEMANAGER node
func _on_menu_screen_request_code_display(game_id: int) -> void:
	code_display.text = str(game_id)
	id = str(game_id)
	print("Current game_id: ", game_id)
