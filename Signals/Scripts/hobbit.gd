extends Node3D

class_name Hobbit

func _ready() -> void:
	await get_tree().create_timer(4.0).timeout
	visible=false
