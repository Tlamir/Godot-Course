extends Node3D


func _on_floor_body_entered(body: Node3D) -> void:
	print("Body has entered")
	SignalHub.emit_game_over()
	#get_tree().reload_current_scene()
	await get_tree().create_timer(1).timeout
	get_tree().call_deferred("reload_current_scene")
