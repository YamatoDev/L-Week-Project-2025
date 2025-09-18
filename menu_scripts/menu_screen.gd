extends Control

# Code by Kaizen
# This is a simple Menu to act as a gate for new players. They must first press the big red button to start the game.

#creates a signal so it can be used by main scene tree
signal request_code_display(game_id: int)

@onready var anim_player = $fade_to_black

#disables input when loaded
func _ready() -> void:
	get_tree().paused = true

#disables this node so you can play the game
func _on_start_button_pressed() -> void:
	GameIdManager._find_code()
	emit_signal("request_code_display", GameIdManager.game_id)
	anim_player.play("fade_out")
	await anim_player.animation_finished
	get_tree().paused = false
	queue_free()
