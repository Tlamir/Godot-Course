extends Resource

class_name EnemyBehaviour

@export var speed: float = 40
@export var engine_sound_distance: float = 120.0

var _near_player: bool= false
var _player_ref: LinkPlayer

var owner: TieFighter:
	set(value): owner = value
	
func setup(p_owner: TieFighter) -> void:
	owner = p_owner
	_player_ref = owner.player_ref

func  update(delta: float) -> void:
	owner.translate(Vector3.FORWARD*speed*delta)
	_play_engine_sound()

func _play_engine_sound():
	if !_near_player and engine_sound_distance>(owner.player_ref.player_z-owner.position.z)  :
		_near_player=true
		owner.engine_sound.play()
		
