extends Node

var game_over: bool = false
var bricks_landed: int =0

func reset_game()-> void:
	game_over=false
	bricks_landed=0
