extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_timer_timeout() -> void:
	animation_player.play("Vanish")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
		queue_free()
