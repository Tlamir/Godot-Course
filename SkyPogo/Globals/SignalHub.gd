extends Node

signal  new_platform(platform_post: Vector3)
signal spawner_loaded(y_position: float)
signal new_height_reached(height: float)

func emit_new_platform(platform_pos: Vector3) -> void:
	new_platform.emit(platform_pos)
	
func emit_spawner_loaded(y_position: float) -> void:
	spawner_loaded.emit(y_position)

func emit_new_height_reached(height:float) ->void:
	new_height_reached.emit(height)
