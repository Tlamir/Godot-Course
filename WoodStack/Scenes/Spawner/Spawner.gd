extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_brick_landed.connect(on_brick_landed)
	SignalHub.on_game_over.connect(on_game_over)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_brick_landed(y_position: float) ->void:
	print("Spawner Brick Landed")
	
func on_game_over() -> void:
	print("Spawner Game Over")
