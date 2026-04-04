extends RigidBody3D

class_name  Brick

const TABLE_GROUP: String ="Table"

func _on_sleeping_state_changed() -> void:
	if sleeping:
		if !GameState.game_over:
			GameState.bricks_landed+=1
			SignalHub.emit_on_brick_landed(position.y)
		if sleeping_state_changed.is_connected(_on_sleeping_state_changed):
			sleeping_state_changed.disconnect(_on_sleeping_state_changed)


func _on_body_entered(body: Node) -> void:
	if body.is_in_group(TABLE_GROUP) and !GameState.game_over:
		GameState.game_over=true
		SignalHub.emit_on_game_over()
		
