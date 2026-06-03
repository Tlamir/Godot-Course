extends Node3D

@onready var effect: AudioStreamPlayer3D = $Effect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Granny:
		effect.play()
		animation_player.play("toggle")
		SignalHub.emit_player_bounce()
