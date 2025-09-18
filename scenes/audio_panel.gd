extends Panel

var toggle := false
var last_toggle_time := 0
var toggle_cooldown := 500

func _input(event):
	if Input.is_action_pressed("toggle_sound"):
		_try_toggle_camera_rotation()


func _try_toggle_camera_rotation():
	var now = Time.get_ticks_msec()
	if now - last_toggle_time >= toggle_cooldown:
		_toggle_panel()
		last_toggle_time = now

func _toggle_panel():
	if(toggle):
		toggle = !toggle
		hide()
	else:
		toggle = !toggle
		show()
