extends Area3D

class_name PickUp

const GROUP_NAME="Pickup"

enum PickUpType {Jewel, Key , Coin}

@export var pickup_type: PickUpType=PickUpType.Jewel
@onready var effects: AudioStreamPlayer3D = $Effects
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D


func _enter_tree() -> void:
	add_to_group(GROUP_NAME)


func _on_body_entered(body: Node3D) -> void:
	if body is Granny:
		_disable()
		_kill()
	
	
func _disable():
	hide()
	set_deferred("monitoring",false)
	
func _kill():
	effects.play()
	await effects.finished
	queue_free()
