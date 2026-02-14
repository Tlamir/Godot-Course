extends CharacterBody3D

class_name Player

const GRAVITY: float = 15.0
const JUMP_FORCE: float = 12.0


func _process(delta: float) -> void:
	pass


#Invoked every frame 
func _physics_process(delta: float) -> void:
	# Falling physics then jumping
	if(is_on_floor()):
		velocity.y+=JUMP_FORCE
	elif(!is_on_floor()):
		velocity.y -= GRAVITY*delta
	move_and_slide()
	
	
