extends Node3D

@export var spaceScreen: SpaceScreen

func on_interact():
	spaceScreen._Activate()
