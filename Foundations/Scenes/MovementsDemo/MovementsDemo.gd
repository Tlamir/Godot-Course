extends Node


var speed: float = 6.0
var rotation_speed: float=90.0

@onready var capsule_1: = $Box2/Capsule1

@onready var box: MeshInstance3D = $Box
@onready var capsule_2: MeshInstance3D = $Capsule2


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_SPACE:
			capsule_2.look_at(box.global_position)
	
func _process(delta: float) -> void:
	#Rotate around parrent axis
	if Input.is_action_pressed("ui_page_up"):
		capsule_1.rotate_x(deg_to_rad(rotation_speed*delta))
	if Input.is_action_pressed("ui_page_down"):
		capsule_1.rotate_x(deg_to_rad(-rotation_speed*delta))
	if Input.is_action_pressed("ui_left"):
		#capsule_1.rotate_y(deg_to_rad(rotation_speed*delta))
		#capsule_1.rotate(Vector3.UP,deg_to_rad(rotation_speed*delta))
		#capsule_1.rotate_object_local(Vector3.UP,deg_to_rad(rotation_speed*delta))
		capsule_1.global_rotate(Vector3.UP,deg_to_rad(rotation_speed*delta))
	if Input.is_action_pressed("ui_right"):
		capsule_1.rotate_y(deg_to_rad(-rotation_speed*delta))
	
	if Input.is_action_pressed("forward"):
		#capsule_1.global_translate(
			#capsule_1.transform.basis.z*-speed*delta
		#)
		capsule_1.position+=capsule_1.transform.basis.z*-speed*delta
	elif Input.is_action_pressed("back"):
		capsule_1.global_translate(
			capsule_1.transform.basis.z*speed*delta
		)
		
	
