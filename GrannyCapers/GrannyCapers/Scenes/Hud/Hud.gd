extends Control
@onready var label_coins: Label = $PanelContainer/HBoxContainer/HBCoin/LabelCoins
@onready var label_jewel: Label = $PanelContainer/HBoxContainer/HBJewel/LabelJewel
@onready var texture_rect_key: TextureRect = $PanelContainer/HBKey/TextureRectKey

var tween: Tween

func  _enter_tree() -> void:
	SignalHub.on_pickup_scores_updated.connect(_update_pickup_scores)
	SignalHub.on_jewels_collected.connect(func():
		texture_rect_key.visible=true
		tween = create_tween()
		tween.set_loops(0)
		tween.tween_property(texture_rect_key,"modulate",Color(1,1,1,0),0.5)
		tween.tween_property(texture_rect_key,"modulate",Color(1,1,1,1),0.5)
		)
	SignalHub.on_key_collected.connect(func():
		if tween:
			tween.kill()
			texture_rect_key.modulate = Color.WHITE
		)


func _update_pickup_scores(scores: PickUpScores) -> void:
	label_jewel.text= "%d/%d" % [
		scores.jewels_count,scores.jewels_total
	]
	label_coins.text= "%d/%d" % [
		scores.coins_count,scores.coins_total
	]
