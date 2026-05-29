extends CharacterBody3D


class_name Granny



@export var gravity: float = -70.0
@export var run_speed: float = 4.0
@export var roatation_speed: float = 4.3
@export var jump_velocity: float=20 
@export var air_control_factor: float = 0.7
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var tree_sm_grounded: AnimationNodeStateMachinePlayback = animation_tree["parameters/Grounded/playback"]
@onready var bone_attachment_3d: BoneAttachment3D = $Model/Armature/Skeleton3D/BoneAttachment3D

@export var shoot_speed: float=10.0
@export var shoot_vertical_speed: float = 3.0


const FIREBALL = preload("res://Scenes/Enemies/Fireball.tscn")

const GROUP_NAME = "Granny"

var _can_double_jump: bool = false
var _is_moving: bool = false	
var _throwing:bool = false

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
		
		if _throwing:
			_is_moving=false
			return
		
		var rotated:bool = _handle_rotation(delta)
		var moved: bool =_handle_movement()
		_is_moving =moved or rotated
		
		_handle_shoot()
		_handle_jump()

func _handle_movement()->bool:
	var input: float = Input.get_axis("move_forward","move_backward")
	if is_equal_approx(input,0.0):
		velocity.x=0.0
		velocity.z=0.0
		return false
		
	var direction: Vector3 = transform.basis.z*input
	var speed: float =run_speed if is_on_floor() else run_speed*air_control_factor
	velocity.x=direction.x*speed
	velocity.z=direction.z*speed
	return true
	
	
func _handle_shoot() -> void:
	if Input.is_action_just_pressed("shoot") and !_throwing and is_on_floor():
		_throwing=true
		tree_sm_grounded.travel("Throw")
	
func _handle_rotation(delta: float)->bool:
	var input: float= Input.get_axis("move_right","move_left")
	rotate_y(roatation_speed*input*delta)
	return  !is_equal_approx(input,0.0)

func _handle_jump() -> void:
	if _throwing:
		return
		
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


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Throw":
		_throwing=false
		
func _create_fireball() -> void:
	var fb: FireBall = FIREBALL.instantiate()
	fb.setup(shoot_speed,-global_transform.basis.z,shoot_vertical_speed)
	SignalHub.emit_add_new_scene(fb,bone_attachment_3d.global_position)
	
