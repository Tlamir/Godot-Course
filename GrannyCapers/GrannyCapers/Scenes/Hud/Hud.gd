extends Control
@onready var label_coins: Label = $PanelContainer/HBoxContainer/HBCoin/LabelCoins
@onready var label_jewel: Label = $PanelContainer/HBoxContainer/HBJewel/LabelJewel
@onready var texture_rect_key: TextureRect = $PanelContainer/HBKey/TextureRectKey
@onready var label_exit: Label = $PanelContainer/HBKey/LabelExit
@onready var level_complete_rect: ColorRect = $LevelCompleteRect
@onready var continue_label: Label = $LevelCompleteRect/VBoxContainer/ContinueLabel
const PARADISE_FOUND = preload("res://Assets/Audio/Music/Paradise_Found.mp3")
const DARKLING = preload("res://Assets/Audio/Music/Darkling.mp3")
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


var tween: Tween

func show_game_over(is_dead: bool):
	get_tree().paused=true
	level_complete_rect.show()
	await get_tree().create_timer(1.0).timeout
	continue_label.show()
	GrannyUtils.play_clip_plain(audio_stream_player,PARADISE_FOUND)
	
func _ready() -> void:
	level_complete_rect.hide()

func  _enter_tree() -> void:
	SignalHub.on_pickup_scores_updated.connect(_update_pickup_scores)
	SignalHub.on_jewels_collected.connect(func():
		texture_rect_key.visible=true
		tween = create_tween()
		tween.set_loops(0)
		tween.tween_property(texture_rect_key,"modulate",Color(1,1,1,0),0.5)
		tween.tween_property(texture_rect_key,"modulate",Color(1,1,1,1),0.5)
		)
	SignalHub.on_key_collected.connect(on_key_collected)
	SignalHub.on_level_completed.connect(func():
		show_game_over(true)
		)
	


func on_key_collected():
		if tween:
			tween.kill()
			texture_rect_key.modulate = Color.WHITE
			label_exit.visible=true
	

func _update_pickup_scores(scores: PickUpScores) -> void:
	label_jewel.text= "%d/%d" % [
		scores.jewels_count,scores.jewels_total
	]
	label_coins.text= "%d/%d" % [
		scores.coins_count,scores.coins_total
	]
