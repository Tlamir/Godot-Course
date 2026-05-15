extends Node

signal on_pickup_collected(pick_up: PickUp)
signal on_pickup_scores_updated(scores: PickUpScores)

func emit_pickup_collected(pick_up: PickUp) -> void:
	on_pickup_collected.emit(pick_up)

func emit_pickup_scores_updated(scores: PickUpScores) -> void:
	on_pickup_scores_updated.emit(scores)
