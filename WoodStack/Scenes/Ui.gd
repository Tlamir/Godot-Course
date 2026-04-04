extends Control

@onready var game_over_color_rect: ColorRect = $GameOverColorRect
@onready var bricks_landed_label: Label = $ColorRect/MarginContainer/BricksLanded
@onready var spawn_time_label: Label = $ColorRect/MarginContainer/HBoxContainer/SpawnTime
@onready var level_label: Label = $ColorRect/MarginContainer/HBoxContainer/Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_game_over.connect(GameOver)
	SignalHub.on_brick_landed.connect(IncreaseScore)
	SignalHub.on_new_level.connect(IncreaseLevel)

func GameOver() ->void:
	game_over_color_rect.show()
	
func _unhandled_input(event: InputEvent) -> void:
	if game_over_color_rect.visible and event.is_action_pressed("ui_cancel"):
		get_tree().reload_current_scene()
		
func IncreaseScore(y_position: float)->void:
	var BricksLandedText:String= "Bricks: %d High Score: %d" %[GameState.bricks_landed,GameState.high_score] 
	bricks_landed_label.text=BricksLandedText
	
func IncreaseLevel(Level: int,spawn_time: float)->void:
	spawn_time_label.text="%.1f" % spawn_time
	level_label.text="Level: %02d" % Level
	
