@tool
extends PathFollow3D

@export var speed: float = 2.0

var _time: float = 0.0
@onready var _path_length: float = get_parent().get_curve().get_baked_length()

func _physics_process(delta: float) -> void:
	# Convert speed (meters per second) into a ratio format relative to total length
	_time += (speed / _path_length) * delta
	
	progress_ratio = pingpong(_time, 1.0)
