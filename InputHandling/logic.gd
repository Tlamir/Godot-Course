extends Node


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
