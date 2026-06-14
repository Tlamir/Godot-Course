extends Resource

class_name EnemyBehaviour

@export var speed: float = 40

var owner: TieFighter:
	set(value): owner = value
	
func setup(p_owner: TieFighter) -> void:
	owner = p_owner

func  update(delta: float) -> void:
	owner.translate(Vector3.FORWARD*speed*delta)
