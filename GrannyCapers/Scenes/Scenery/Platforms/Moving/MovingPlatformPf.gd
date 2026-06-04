#@tool
extends PathFollow3D

@onready var collision_shape: CollisionShape3D = $Platform/CollisionShape
@onready var mesh: MeshInstance3D = $Mesh

@export var speed: float = 2.0
@export var platform_mesh: Mesh
@export var shape_position: Vector3 = Vector3.ZERO
@export var platform_mesh_position: Vector3 = Vector3.ZERO 
@export var shape: Shape3D

var _time: float = 0.0
@onready var _path_length: float = get_parent().get_curve().get_baked_length() if get_parent() is Path3D else 1.0

func _notification(what):
	if what == NOTIFICATION_EDITOR_POST_SAVE:
		_update_components()

func _ready():	
	_update_components()

func _update_components() -> void:
	# SAFETY CHECK: If the editor triggers this before nodes are ready, 
	# or if the node paths are wrong, stop here to avoid crashing.
	if not is_inside_tree() or collision_shape == null or mesh == null:
		return
		
	collision_shape.shape = shape
	mesh.mesh = platform_mesh
	collision_shape.position = shape_position
	mesh.position = platform_mesh_position

func _physics_process(delta: float) -> void:
	if not is_inside_tree() or not get_parent() is Path3D:
		return
		
	if _path_length == 1.0:
		_path_length = get_parent().get_curve().get_baked_length()

	_time += (speed / _path_length) * delta
	progress_ratio = pingpong(_time, 1.0)
