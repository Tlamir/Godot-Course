extends CharacterBody3D

class_name Player

const GRAVITY: float = 15.0
const JUMP_FORCE: float = 12.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _process(_delta: float) -> void:
	pass


#Invoked every frame 
func _physics_process(delta: float) -> void:
	handle_gravity(delta)
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
