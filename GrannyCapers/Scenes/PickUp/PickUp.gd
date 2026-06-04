extends Area3D

class_name PickUp

const GROUP_NAME="Pickup"

enum PickUpType {Jewel, Key , Coin}

const PICKUP_POINTS: Dictionary[PickUpType,int]={
	PickUpType.Jewel: 10,
	PickUpType.Key:30,
	PickUpType.Coin:5,
}

@export var pickup_type: PickUpType=PickUpType.Jewel
@onready var effects: AudioStreamPlayer3D = $Effects
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D


func _enter_tree() -> void:
	add_to_group(GROUP_NAME)

func get_score()-> int:
	return PICKUP_POINTS[pickup_type]


func _on_body_entered(body: Node3D) -> void:
	if body is Granny:
		SignalHub.emit_pickup_collected(self)
		_disable()
		ScoreManager.current_score+= get_score()
		_kill()
	
	
func _disable():
	hide()
	set_deferred("monitoring",false)
	
func _kill():
	effects.play()
	await effects.finished
	queue_free()
