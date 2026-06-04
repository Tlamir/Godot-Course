extends Control
@onready var label_coins: Label = $PanelContainer/HBoxContainer/HBCoin/LabelCoins
@onready var label_jewel: Label = $PanelContainer/HBoxContainer/HBJewel/LabelJewel
@onready var texture_rect_key: TextureRect = $PanelContainer/HBKey/TextureRectKey
@onready var label_exit: Label = $PanelContainer/HBKey/LabelExit
@onready var level_complete_rect: ColorRect = $LevelCompleteRect
@onready var continue_label: Label = $LevelCompleteRect/VBoxContainer/ContinueLabel
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var label_health: Label = $PanelContainer/HBoxContainer/HBHealth/LabelHealth
@onready var complete_label: Label = $LevelCompleteRect/VBoxContainer/CompleteLabel
@onready var in_game_music: AudioStreamPlayer = $InGameMusic
@onready var label_score: Label = $PanelContainer/HBoxContainer/LabelScore



const PARADISE_FOUND = preload("res://Assets/Audio/Music/Paradise_Found.mp3")
const DARKLING = preload("res://Assets/Audio/Music/Darkling.mp3")

var tween: Tween
var _can_continue: bool =false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		GameManager.change_to_main()
	elif event.is_action_pressed("shoot") and _can_continue:
		GameManager.load_next_level()

	
func _ready() -> void:
	get_tree().paused=false
	level_complete_rect.hide()
	update_score(ScoreManager.current_score)
	
	

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
		show_game_over(false)
		)
	SignalHub.on_player_died.connect(on_player_died)
	SignalHub.on_player_health_changed.connect(_update_health)
	SignalHub.on_score_changed.connect(update_score)
	

func update_score(score: int ):
	label_score.text="Score: %d" % score

func on_player_died():
	show_game_over(true)
	pass

func show_game_over(is_dead: bool):
	in_game_music.stop()
	get_tree().paused=true
	if is_dead:
		complete_label.text="Game Over!"
	level_complete_rect.show()
	await get_tree().create_timer(1.0).timeout
	if is_dead:
		GrannyUtils.play_clip_plain(audio_stream_player,DARKLING)
	else:
		_can_continue=true
		continue_label.show()
		GrannyUtils.play_clip_plain(audio_stream_player,PARADISE_FOUND)

func _update_health(health: int):
	label_health.text="%d" % health
	if health<=30:
		label_health.label_settings.font_color= Color(0.722, 0.0, 0.0, 1.0)
	else: 
		label_health.label_settings.font_color= Color(1.0, 1.0, 1.0, 1.0)
		

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
