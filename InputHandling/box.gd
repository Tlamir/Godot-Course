extends Area3D


func _input(event: InputEvent) -> void:
	if event.is_pressed() and !event.is_echo():
		print("%d %s %s %s" % [
			Time.get_ticks_msec(), name, "_input", event.as_text()
		])
	
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_pressed() and !event.is_echo():
		print("%d %s %s %s" % [
			Time.get_ticks_msec(), name, "_unhandled_key_input", event.as_text()
		])
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed() and !event.is_echo():
		print("%d %s %s %s" % [
			Time.get_ticks_msec(), name, "_unhandled_input", event.as_text()
		])

func _input_event(camera: Camera3D, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_pressed() and !event.is_echo():
		print("%d %s %s %s" % [
			Time.get_ticks_msec(), name, "_input_event", event.as_text()
		])
