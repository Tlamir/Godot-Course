extends Node3D


class_name ShadedWall


@onready var wall_mesh: MeshInstance3D = $WallMesh
@onready var player_ref: LinkPlayer = $PlayerRef



var _max_distance: float = 15.0
var _distance_to_player: float = 0.0
var _wall_material: ShaderMaterial


func _ready() -> void:
	# Safely fetch the shader material from active surfaces or override
	#if wall_mesh.mesh and wall_mesh.mesh.get_surface_count() > 0:
	#	_wall_material = wall_mesh.get_active_material(0) as ShaderMaterial
	#elif wall_mesh.material_override:
	_wall_material = wall_mesh.material_override as ShaderMaterial

func _process(_delta: float) -> void:
	print("Test")
	# Why is this not working???? i tried to reset my pc and it stuck at yellow dram error i had to manually
	# turn off and on again. Even with empty script just proces print not working. I tried recrating the node3d mesh no luck

func _physics_process(_delta: float) -> void:
	print("Test1 base shader str: " , _wall_material.get_shader_parameter("Strength"))
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
