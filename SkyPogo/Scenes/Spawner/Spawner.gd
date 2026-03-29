extends Node

@export var platform_scenes: Array[PackedScene]
@export var speed: int =50
@onready var island_platform: Platform = $IslandPlatform

const OFFSET_UP: Vector2 = Vector2(2.5,4.0)
const OFFSET_SIDE: Vector2=Vector2(2.5,4.5)

func _ready() -> void:
	SignalHub.emit_spawner_loaded(island_platform.position.y)
	

func _enter_tree() -> void:
	SignalHub.new_platform.connect(_on_new_platform)

func get_random_offset(offset_range: Vector2) -> float:
	if randf() <0.5:
		return randf_range(-offset_range.y,-offset_range.x)
	else:
		return randf_range(offset_range.x,offset_range.y)
		

func spawn_platform(old_platform_pos:Vector3)->void:
	var platform_scene=platform_scenes.pick_random()
	var new_platform: Platform = platform_scene.instantiate()
	var new_y: float = randf_range(OFFSET_UP.x,OFFSET_UP.y)
	
	var new_x: float = get_random_offset(OFFSET_SIDE)
	var new_z: float = get_random_offset(OFFSET_SIDE)
	
	
	new_platform.position = old_platform_pos + Vector3(new_x,new_y,new_z)
	add_child(new_platform)
	
func _on_new_platform(platform_pos: Vector3) -> void:
	spawn_platform(platform_pos)

	
