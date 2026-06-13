extends Node

signal on_create_one_off(p_pos: Vector3, scene_name: Spawner.SceneNames)


func emit_create_one_off(p_pos: Vector3, scene_name: Spawner.SceneNames) -> void:
	on_create_one_off.emit(p_pos, scene_name)
