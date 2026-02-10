extends Node3D

class_name Orc

var _hobbit:Hobbit

func _ready() -> void:
	_hobbit=get_tree().get_first_node_in_group("Hobbit")
	if !_hobbit:
		queue_free()
		print("Couln't find the hobbit by orc")
	else:
		_hobbit.visibility_changed.connect(on_hobbit_vis_changed)
	
	await get_tree().create_timer(7.0).timeout
	ready_for_battle.emit()

func  on_hobbit_vis_changed() -> void:
	print("Hobbit Vis changed")

signal ready_for_battle
