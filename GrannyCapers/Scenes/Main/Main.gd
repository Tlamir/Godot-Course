extends Control

var _can_press: bool =false

@onready var gc_high_scores: GridContainer = $MarginContainer/GCHighScores
const HIGH_SCORE_DISPLAY = preload("res://Scenes/HighScoreDisplay/HighScoreDisplay.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if _can_press and event.is_action_pressed("shoot"):
		GameManager.load_next_level()

func _ready() -> void:
	get_tree().paused = false
	
func set_press_on():
	_can_press=true
	
func add_scores():
	for hs: HighScore in ScoreManager.high_scores.get_scores_list():
		var ns: HighScoreDisplay=HIGH_SCORE_DISPLAY.instantiate()
		ns.setup(hs)
		gc_high_scores.add_child(ns)
	gc_high_scores.show()

	
