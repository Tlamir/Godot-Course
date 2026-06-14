extends EnemyBehaviour


class_name TurnShoot

@export var engage_distance: float = 100.0

var _engaged: bool = false

func update(_delta: float) -> void:
	if !_engaged and engage_distance>owner.player_ref.player_z-owner.position.z:
		owner.look_at(owner.player_ref.player.position)
		_engaged=true
		owner.gun.shoot()
	super(_delta)
	
		
