extends Object

class_name Character 

var _name: String = "No name"
var _health: int =100

var health:int:
	set=set_health,get_health


func _init(name: String) -> void:
	_name=name
	
func say_name() -> void:
	print(_name)
func get_health() -> int:
	return self._health
