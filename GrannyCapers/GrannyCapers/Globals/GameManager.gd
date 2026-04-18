extends Node


const MAIN_SCENE = preload("res://Scenes/Main/Main.tscn")


const LEVELS: Dictionary[int, PackedScene] = {
	1: preload("res://Scenes/Level/LevelBase.tscn")
}


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func _exit_tree():
	pass


func change_to_main():
	pass


func load_next_level():
	pass
