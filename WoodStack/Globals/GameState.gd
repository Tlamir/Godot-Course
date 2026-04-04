extends Node

const PATH: String ="user://jenga.dat"

var game_over: bool = false
var high_score: int= 0


var bricks_landed: int =0:
	get: return bricks_landed
	set(value):
			bricks_landed=value
			if value>high_score:
				high_score=value
				save_high_score()


func reset_game()-> void:
	game_over=false
	bricks_landed=0

func save_high_score() -> void:
	var file: FileAccess = FileAccess.open(PATH,FileAccess.WRITE)
	if file:
		file.store_32(high_score)
		file.close()
		
func load_high_score() -> void:
	var file: FileAccess = FileAccess.open(PATH,FileAccess.READ)
	if file:
		high_score = file.get_32()
		print(high_score)
		file.close()
