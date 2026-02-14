extends Node

@export var platform_scene: PackedScene
@export var speed: int =50



func spawn_platform(old_platform_pos:Vector3)->void:
	var new_platfrom: Platform = platform_scene.instantiate()
	new_platfrom.position = old_platform_pos + Vector3(0.1,6,0)
	add_child(new_platfrom)
	
	
func _on_platform_new_platform(platform_pos: Vector3) -> void:
	spawn_platform(platform_pos)
	
