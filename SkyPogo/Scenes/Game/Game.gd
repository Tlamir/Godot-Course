extends Node3D


func _on_floor_body_entered(body: Node3D) -> void:
	print("Body has entered")
	#get_tree().reload_current_scene()
	get_tree().call_deferred("reload_current_scene")
