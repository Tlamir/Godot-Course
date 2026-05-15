
class_name PickUpScores

var coins_total: int=0
var jewels_total: int=0

var coins_count: int=0
var jewels_count: int=0

func all_jevels_collected() -> bool:
	return jewels_count == jewels_total
	
func _to_string() -> String:
	return "PickUpScores: Coins: %d/%d, Jewels: %d/%d" % [
		coins_count,coins_total,jewels_count,jewels_total
	]
	
	
