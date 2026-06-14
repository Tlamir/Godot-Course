extends Node3D

class_name TieFighter

@export var stay_still : bool = false
@export var enemy_behaviour: EnemyBehaviour
@export var burst_delay : float = 0.25
@export var burst_amount : int = 3

@onready var engine_sound: AudioStreamPlayer3D = $EngineSound
@onready var player_ref: LinkPlayer = $PlayerRef
@onready var gun: Gun = $Pivot/Gun
@onready var mesh_tie_fighter: MeshInstance3D = $Pivot/TieFighter


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
		
func shoot_burst():
	for i in range(burst_amount):
		gun.shoot()
		await get_tree().create_timer(burst_delay).timeout
		
