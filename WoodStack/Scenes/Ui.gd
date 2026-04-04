extends Control

@onready var game_over_color_rect: ColorRect = $GameOverColorRect
@onready var bricks_landed: Label = $ColorRect/MarginContainer/BricksLanded

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_game_over.connect(GameOver)
	SignalHub.on_brick_landed.connect(IncreaseScore)

func GameOver() ->void:
	game_over_color_rect.show()
func _unhandled_input(event: InputEvent) -> void:
	if game_over_color_rect.visible and event.is_action_pressed("ui_cancel"):
		get_tree().reload_current_scene()
func IncreaseScore(y_position: float)->void:
	score+=1
	var BricksLandedText:String= "Bricks: %d" % score
	bricks_landed.text=BricksLandedText
	
