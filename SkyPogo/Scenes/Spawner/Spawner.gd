extends Node

@export var platform_scene: PackedScene
@export var speed: int =50

func _enter_tree() -> void:
	SignalHub.new_platform.connect(_on_new_platform)

func spawn_platform(old_platform_pos:Vector3)->void:
	var new_platform: Platform = platform_scene.instantiate()
	new_platform.position = old_platform_pos + Vector3(2,6,0)
	add_child(new_platform)
	
func _on_new_platform(platform_pos: Vector3) -> void:
	spawn_platform(platform_pos)

	
