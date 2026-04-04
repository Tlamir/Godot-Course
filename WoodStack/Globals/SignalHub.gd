extends Node

signal on_game_over
signal on_brick_landed(y_position: float)
signal on_brick_dropped(brick_transform: Transform3D)
signal on_new_level(level: int, spawn_time: float)

func emit_on_game_over()-> void:
	on_game_over.emit()
	
func emit_on_brick_landed(y_position: float) -> void:
	on_brick_landed.emit(y_position)
	
func emit_on_brick_dropped(brick_transform: Transform3D) -> void:
	on_brick_dropped.emit(brick_transform)

func emit_on_new_level(level: int, spawn_time: float) ->void:
	on_new_level.emit(level,spawn_time)
