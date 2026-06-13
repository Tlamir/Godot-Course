extends Node3D


class_name ShadedWall


@onready var wall_mesh: MeshInstance3D = $WallMesh
@onready var player_ref: LinkPlayer = $PlayerRef

@export var is_y: bool =false

var _max_distance: float = 15.0
var _distance_to_player: float = 0.0
var _wall_material: ShaderMaterial


func _ready() -> void:

	_wall_material = wall_mesh.material_override as ShaderMaterial

	# Why is this not working???? i tried to reset my pc and it stuck at yellow dram error i had to manually
	# turn off and on again. Even with empty script just proces print not working. I tried recrating the node3d mesh no luck

func _physics_process(_delta: float) -> void:
	if is_y:
		_distance_to_player = abs(player_ref.player_y - global_position.y)
	else:
		_distance_to_player = abs(player_ref.player_x - global_position.x)
	var strength: float = 0
	strength = clampf(
		(_max_distance - _distance_to_player) / _max_distance,
		0.0, 
		1.0
	)
	print("Test2 str: " , strength)
	_wall_material.set_shader_parameter("Strength", strength)
	print("Test3 updated str: " , _wall_material.get_shader_parameter("Strength"))
