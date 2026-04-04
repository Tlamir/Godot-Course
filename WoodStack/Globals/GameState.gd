extends Node

const PATH: String ="user://jenga.dat"
const PASSWORD: String = "oihoifuahpiesuhfipu02934+0"



var game_over: bool = false
var high_score: int= 0


var bricks_landed: int =0:
	get: return bricks_landed
	set(value):
			bricks_landed=value
			if value>high_score:
				high_score=value
				save_high_score()


func get_hash()-> String:
	var ctx = HashingContext.new()
	ctx.start(HashingContext.HASH_SHA256)
	ctx.update(PASSWORD.to_utf8_buffer())
	var result = ctx.finish()
	var hash_str = result.hex_encode()
	return hash_str

func reset_game()-> void:
	game_over=false
	bricks_landed=0

func save_high_score() -> void:
	var file: FileAccess = FileAccess.open_encrypted_with_pass(PATH,FileAccess.WRITE,get_hash())
	if file:
		file.store_32(high_score)
		file.close()
		
func load_high_score() -> void:
	var file: FileAccess = FileAccess.open_encrypted_with_pass(PATH,FileAccess.READ,get_hash())
	if file:
		high_score = file.get_32()
		print(high_score)
		file.close()
