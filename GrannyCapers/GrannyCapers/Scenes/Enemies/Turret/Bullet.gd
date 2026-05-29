extends Node3D

class_name Bullet

@onready var link_player: LinkPlayer = $LinkPlayer

var _speed: float =5.0
var _direction: Vector3 = Vector3.ZERO
var _y_offset: float =1.0

func _ready() -> void:
	var granny_pos: Vector3 = link_player.granny_pos
	look_at(Vector3(granny_pos.x,granny_pos.y+_y_offset,granny_pos.z))
	_direction=-transform.basis.z.normalized()
	
func _physics_process(delta: float) -> void:
	position+= _direction*_speed*delta
