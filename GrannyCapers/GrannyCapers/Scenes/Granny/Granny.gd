extends CharacterBody3D


class_name Granny


@export var gravity: float = -70.0


@onready var debug_label: Label3D = $DebugLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	velocity.y += delta * gravity
	
	move_and_slide()
	_update_debug()


func _update_debug() -> void:
	var s: String = "floor:%s\n" % [is_on_floor()]
	s += "vel: %s\n" % GrannyUtils.formatted_vec3(velocity)
	s += "pos: %s\n" % GrannyUtils.formatted_vec3(global_position)
	debug_label.text = s
