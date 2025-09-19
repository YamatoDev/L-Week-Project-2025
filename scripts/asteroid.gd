extends Node3D

@export var speed: float
@export var expiry: float
var ship: Ship

var hit_ship: bool

func _physics_process(delta: float) -> void:
	var forward = -get_global_transform().basis.z
	var change = forward * speed * delta
	
	set_global_position(global_position + change)

	expiry -= delta
	if (expiry <= 0): queue_free()


func _on_area_entered(area: Area3D) -> void:
	if area == ship.area and !hit_ship:
		hit_ship = true
		ship.ship_hit()
