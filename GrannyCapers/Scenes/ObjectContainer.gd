extends Node

const EXPLOSION = preload("res://Scenes/Effects/Explosion/Explosion.tscn")
const SCORE_EFFECT = preload("res://Scenes/Effects/ScoreEffect/ScoreEffect.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_add_new_scene.connect(on_add_new_scene)
	SignalHub.on_add_new_explosion.connect(on_add_new_explostion)
	SignalHub.on_pickup_collected.connect(on_pickup_collected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func add_with_position(ob: Node3D, new_position:Vector3):
	add_child(ob)
	ob.global_position = new_position
	
func on_add_new_scene(ob: Node3D, new_position: Vector3):
	call_deferred("add_with_position",ob,new_position)
	
func on_add_new_explostion(new_position: Vector3):
	var ns = EXPLOSION.instantiate()
	on_add_new_scene(ns,new_position)
	
func on_pickup_collected(pickup: PickUp ):
	var ns: ScoredEffect = SCORE_EFFECT.instantiate()
	ns.setup(pickup.get_score())
	add_child(ns)
	ns.global_position = pickup.global_position
	print(ns._points)
	
	
	
	
