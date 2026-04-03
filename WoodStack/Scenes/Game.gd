extends Node

@export var brick_scene: PackedScene
@onready var brick_container: Node = $BrickContainer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_brick_dropped.connect(_on_brick_dropped)
	
func _on_brick_dropped(brick_transform: Transform3D) -> void:
	var new_brick: Brick = brick_scene.instantiate()
	new_brick.global_transform=brick_transform
	brick_container.add_child(new_brick)
