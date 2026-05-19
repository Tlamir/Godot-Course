extends CharacterBody3D

@onready var running_effect: AudioStreamPlayer3D = $RunningEffect

func _physics_process(delta: float) -> void:
	pass

func _on_running_timer_timeout() -> void:
	running_effect.stop()
	running_effect.play()
