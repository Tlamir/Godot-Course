extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var player_detector: Area3D = $PlayerDetector

func _on_timer_timeout() -> void:
	animation_player.play("Vanish")
	


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
		queue_free()


func _on_player_detector_body_entered(body: Node3D) -> void:
	if body is Player:
		timer.start()
		# Disconnect From signal
		player_detector.body_entered.disconnect(_on_player_detector_body_entered)
