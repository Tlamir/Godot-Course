extends Node

signal on_pickup_collected(pick_up: PickUp)
signal on_pickup_scores_updated(scores: PickUpScores)
signal on_jewels_collected()
signal on_key_collected()
signal on_level_completed()
signal on_player_died()

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
