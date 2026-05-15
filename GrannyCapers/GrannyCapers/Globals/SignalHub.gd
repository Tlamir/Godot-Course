extends Node

signal on_pickup_collected(pick_up: PickUp)
signal on_pickup_scores_updated(scores: PickUpScores)
signal on_jewels_collected()
signal on_key_collected()

func emit_pickup_collected(pick_up: PickUp) -> void:
	on_pickup_collected.emit(pick_up)

func emit_pickup_scores_updated(scores: PickUpScores) -> void:
	on_pickup_scores_updated.emit(scores)
	
func emit_jewels_collected() -> void:
	SignalHub.on_jewels_collected.emit()

func emit_key_collected() -> void:
	on_key_collected.emit()
