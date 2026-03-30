extends Control

@onready var score_label: Label = $MarginContainer/ScoreLabel

func _enter_tree() -> void:
	SignalHub.new_height_reached.connect(new_height_reached)

func new_height_reached(height:float) ->void:
	score_label.text="Best Height: %d" % int(height)
