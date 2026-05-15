extends Control
@onready var label_coins: Label = $PanelContainer/HBoxContainer/HBCoin/LabelCoins
@onready var label_jewel: Label = $PanelContainer/HBoxContainer/HBJewel/LabelJewel


func  _enter_tree() -> void:
	SignalHub.on_pickup_scores_updated.connect(_update_pickup_scores)	


func _update_pickup_scores(scores: PickUpScores) -> void:
	label_jewel.text= "%d/%d" % [
		scores.jewels_count,scores.jewels_total
	]
	label_coins.text= "%d/%d" % [
		scores.coins_count,scores.coins_total
	]
