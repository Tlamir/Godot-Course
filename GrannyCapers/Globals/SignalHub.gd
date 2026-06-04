extends Node

signal on_pickup_collected(pick_up: PickUp)
signal on_pickup_scores_updated(scores: PickUpScores)
signal on_jewels_collected()
signal on_key_collected()
signal on_level_completed()
signal on_player_died()
signal on_add_new_scene(ob: Node3D, new_position: Vector3)
signal on_add_new_explosion(new_position: Vector3)
signal on_player_health_changed(health: int)
signal on_player_bounce()
signal on_score_changed(score: int)

func emit_score_changed(score:int) -> void:
	on_score_changed.emit(score)

func emit_player_bounce():
	on_player_bounce.emit()

func emit_player_health_changed(health: int):
	on_player_health_changed.emit(health)

func emit_add_new_explosion(new_position: Vector3):
	on_add_new_explosion.emit(new_position)

func emit_add_new_scene(ob: Node3D, new_position: Vector3) -> void:
	SignalHub.on_add_new_scene.emit(ob,new_position)

func emit_player_died() ->void:
	on_player_died.emit()

func emit_level_completed() -> void :
	on_level_completed.emit()

func emit_pickup_collected(pick_up: PickUp) -> void:
	on_pickup_collected.emit(pick_up)

func emit_pickup_scores_updated(scores: PickUpScores) -> void:
	on_pickup_scores_updated.emit(scores)
	
func emit_jewels_collected() -> void:
	SignalHub.on_jewels_collected.emit()

func emit_key_collected() -> void:
	on_key_collected.emit()
