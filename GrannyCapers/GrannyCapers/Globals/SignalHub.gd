extends Node

signal on_pickup_collected(pick_up: PickUp)

func emit_pickup_collected(pick_up: PickUp) -> void:
	on_pickup_collected.emit(pick_up)
