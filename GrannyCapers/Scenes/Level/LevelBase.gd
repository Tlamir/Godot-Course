extends Node

const FIREBALL = preload("res://Scenes/Enemies/Fireball/Fireball.tscn")


func _on_timer_timeout() -> void:
	var fireball : FireBall = FIREBALL.instantiate()
	fireball.setup(10.0,Vector3(1,0,1),3.0)
	add_child(fireball)
	fireball.position = Vector3(0,1,0)
