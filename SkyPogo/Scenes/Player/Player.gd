extends CharacterBody3D

class_name Player

const GRAVITY: float = 15.0
const JUMP_FORCE: float = 21.0
const ROTATION_SPEED: float = 4.0
const MOVE_SPEED: float = 3.5


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _process(_delta: float) -> void:
	pass


#Invoked every frame 
func _physics_process(delta: float) -> void:
	handle_rotation(delta)
	handle_gravity(delta)
	handle_movement(delta)
	move_and_slide()
	handle_animation()
	

func handle_gravity(delta: float) -> void:
	 #Falling physics then jumping
	if(is_on_floor()):
		velocity.y+=JUMP_FORCE
	elif(!is_on_floor()):
		velocity.y -= GRAVITY*delta
	
func handle_animation() -> void:
	if velocity.y>0:
		animation_player.play("jump")
	else:
		animation_player.play("fall")

func handle_rotation(delta: float)-> void:
	if(Input.is_action_pressed("ui_left")):
		rotate_y(ROTATION_SPEED*delta)
	if(Input.is_action_pressed("ui_right")):
		rotate_y(ROTATION_SPEED*delta*-1)
	pass
func handle_movement(delta: float)-> void:
	var dir: Vector3 =Vector3.ZERO 
	if(Input.is_action_pressed("ui_up")):
		dir=transform.basis.z
	velocity.x=dir.x*MOVE_SPEED
	velocity.z=dir.z*MOVE_SPEED
	

	pass
