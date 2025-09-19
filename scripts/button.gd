extends Node3D

@export var spaceScreen: PhotographyScreen

func on_interact():
	spaceScreen._Activate()
