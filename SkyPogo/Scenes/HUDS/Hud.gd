extends Control

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var best_label: Label = $MarginContainer/BestLabel
@onready var color_rect: ColorRect = $ColorRect
@onready var game_over_label: Label = $ColorRect/GameOverLabel

var _hsr: HighScoreResource = HighScoreResource.load_or_create()
var _current_score: int=0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reload"):
		get_tree().reload_current_scene()

func _ready() -> void:
	best_label.text="BEST: %d" %_hsr.high_score
func _enter_tree() -> void:
	SignalHub.new_height_reached.connect(new_height_reached)
	SignalHub.game_over.connect(game_over)

func new_height_reached(height:float) ->void:
	_current_score=int(height)
	score_label.text="Best Height: %d" %_current_score


func game_over()-> void:
	if _hsr.check_and_update(_current_score):
			game_over_label.text="GAME OVER  \n New Best Height Reached \n 😍👌🥸"
	color_rect.show()
	
