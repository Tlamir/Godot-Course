extends Node

class_name PickUpTracker

var pickup_scores: PickUpScores = PickUpScores.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_tree().get_nodes_in_group(PickUp.GROUP_NAME):
		match child.pickup_type:
				PickUp.PickUpType.Jewel:
					pickup_scores.jewels_total+=1
				PickUp.PickUpType.Coin:
					pickup_scores.coins_total +=1
	print(pickup_scores)
	
func _enter_tree() -> void:
	SignalHub.on_pickup_collected.connect(on_pickup_collected)
	
	
func on_pickup_collected(pick_up: PickUp):
	match pick_up.pickup_type:
		PickUp.PickUpType.Jewel:
			pickup_scores.jewels_count+=1
		PickUp.PickUpType.Coin:
			pickup_scores.coins_count+=1
	print(pickup_scores)
	
