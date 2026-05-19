extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_add_new_scene.connect(on_add_new_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func add_with_position(ob: Node3D, new_position:Vector3):
	add_child(ob)
	ob.global_position = new_position
	
func on_add_new_scene(ob: Node3D, new_position: Vector3):
	call_deferred("add_with_position",ob,new_position)
	
