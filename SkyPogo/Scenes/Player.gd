extends CharacterBody3D

class_name Player

const GRAVITY: float = 15.0


#Invoked every frame 
func _physics_process(delta: float) -> void:
	# Fall
	velocity.y -= GRAVITY*delta
	move_and_slide()
	
