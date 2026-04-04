extends Control

@onready var game_over_color_rect: ColorRect = $GameOverColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_game_over.connect(GameOver)

func GameOver() ->void:
	game_over_color_rect.show()
func _unhandled_input(event: InputEvent) -> void:
	if game_over_color_rect.visible and event.is_action_pressed("ui_cancel"):
		get_tree().reload_current_scene()
