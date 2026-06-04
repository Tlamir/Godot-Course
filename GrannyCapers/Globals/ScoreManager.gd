# res://Globals/ScoreManager.gd

extends Node


var _current_score: int = 0


var current_score: int:
	get: return _current_score
	set(value):
		_current_score = value
		if _current_score < 0: _current_score = 0
		SignalHub.on_score_changed.emit(_current_score)


func reset_score():
	current_score=0
