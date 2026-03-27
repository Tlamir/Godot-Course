extends Camera3D

var base_position: Vector3
@export var buffer: Vector3=Vector3(0,8,8)

func _enter_tree() -> void:
	SignalHub.new_platform.connect(_on_new_platform)
	
func _ready() -> void:
	base_position=position
	
func _on_new_platform(platform_pos: Vector3) -> void:
	move_to(platform_pos + buffer)
func move_to(pos: Vector3):
	var tween = create_tween()
	tween.tween_property(self, "position", pos, 0.5)
