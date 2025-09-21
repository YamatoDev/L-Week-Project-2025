extends Control

# Code by Kaizen
# This is a simple Menu to act as a gate for new players. They must first press the big red button to start the game.

#creates a signal so it can be used by main scene tree
signal request_code_display(game_id: int)

@onready var anim_player = $fade_to_black
@onready var audio_player = $start_sound
@onready var bg_audio = $bgm
#disables input when loaded
func _ready() -> void:
	get_tree().paused = true

#disables this node so you can play the game
func _on_start_button_pressed() -> void:
	GameIdManager._find_code()
	$"../../Environment/Chunk A/EnemySpawnContainer"._retrieve_id()
	emit_signal("request_code_display", GameIdManager.game_id)
	bg_audio.get_parent().remove_child(bg_audio)
	get_tree().get_root().add_child(bg_audio)
	audio_player.get_parent().remove_child(audio_player)
	get_tree().get_root().add_child(audio_player)
	audio_player.play()
	anim_player.play("fade_out")
	await anim_player.animation_finished
	get_tree().paused = false
	queue_free()
