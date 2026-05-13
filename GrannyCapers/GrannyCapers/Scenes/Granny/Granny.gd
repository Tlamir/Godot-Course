extends CharacterBody3D


class_name Granny



@export var gravity: float = -70.0
@export var run_speed: float = 4.0
@export var roatation_speed: float = 2.7
@export var jump_velocity: float=20 
@export var air_control_factor: float = 0.7

const GROUP_NAME = "Granny"

var _can_double_jump: bool = false

@onready var debug_label: Label3D = $DebugLabel

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	move_and_slide()
	_update_debug()
	_handle_input(delta)

func _handle_input(delta: float) -> void:
		velocity.y += delta * gravity
		_handle_rotation(delta)
		_handle_movement()
		_handle_jump()

func _handle_movement()->void:
	var input: float = Input.get_axis("move_forward","move_backward")
	var direction: Vector3 = transform.basis.z*input
	var speed: float =run_speed if is_on_floor() else run_speed*air_control_factor
	velocity.x=direction.x*speed
	velocity.z=direction.z*speed
	return
	
	

func _handle_rotation(delta: float)->void:
	var input: float= Input.get_axis("move_right","move_left")
	rotate_y(roatation_speed*input*delta)
	return  

func _handle_jump() -> void:
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y=jump_velocity
			_can_double_jump=true
		elif _can_double_jump and velocity.y>0.0:
			velocity.y=jump_velocity
			_can_double_jump=false
			
			

func _update_debug() -> void:
	var s: String = "floor:%s\n" % [is_on_floor()]
	s += "vel: %s\n" % GrannyUtils.formatted_vec3(velocity)
	s += "pos: %s\n" % GrannyUtils.formatted_vec3(global_position)
	debug_label.text = s
