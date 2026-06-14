extends Node3D

class_name TieFighter

#@export var engine_sound_distance: float = 120.0
@export var stay_still : bool = false
@export var enemy_behaviour: EnemyBehaviour

@onready var engine_sound: AudioStreamPlayer3D = $EngineSound
@onready var player_ref: LinkPlayer = $PlayerRef
@onready var gun: Gun = $Pivot/Gun


func _ready() -> void:
	if enemy_behaviour : 
		enemy_behaviour.setup(self)
	_face_player()

func _physics_process(_delta: float) -> void:
	if !stay_still and enemy_behaviour: 
		enemy_behaviour.update(_delta)
		
func _face_player() -> void:
	if player_ref.player_z > position.z :
		rotation.y=PI
	else:
		rotation=Vector3.ZERO
		
