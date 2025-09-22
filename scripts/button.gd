extends Node3D

@export var spaceScreen: PhotographyScreen
@export var spaceship_model: ShipModel

var can_press: bool = true

func _ready() -> void:
	add_to_group("Player")

#func _process(delta: float) -> void:
	#print(global_position)

func on_interact():
	if (can_press):
		spaceship_model.animation_player.play("button_press")
		spaceScreen._Activate()

		can_press = false
		await get_tree().create_timer(0.4).timeout
		can_press = true

