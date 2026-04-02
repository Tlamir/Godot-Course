extends RigidBody3D

class_name  Brick

const TABLE_GROUP: String ="Table"

func _on_sleeping_state_changed() -> void:
	print("SleepStateChanged: ",sleeping)
	SignalHub.emit_on_brick_landed(position.y)


func _on_body_entered(body: Node) -> void:
	print(name," OnBodyEntered: ",body.name)
	if body.is_in_group(TABLE_GROUP):
		print("we hit a table")
		SignalHub.emit_on_game_over()
		
