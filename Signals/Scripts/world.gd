extends Node3D

class_name World

@onready var hobbit: Hobbit = $Hobbit
@onready var camera_3d: Camera3D = $Camera3D

var cam_rotated:bool =false


func _process(delta: float) -> void:
	pass
		
	


func _on_hobbit_visibility_changed() -> void:
	camera_3d.rotate(camera_3d.transform.basis.z,deg_to_rad(10))
	cam_rotated=true


func _on_orc_ready_for_battle() -> void:
	camera_3d.fov=160
