extends Node3D

@onready var pivot: Node3D = $Pivot

const  ROTATION_SPEED: float = 4.0
const  MOVE_SPEED: float = 2.0
const MOVE_LIMIT: float =2.5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_brick_landed.connect(on_brick_landed)
	SignalHub.on_game_over.connect(on_game_over)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_rotation(delta)
	handle_translation(delta)

func on_brick_landed(y_position: float) ->void:
	print("Spawner Brick Landed")
	
func on_game_over() -> void:
	print("Spawner Game Over")

func handle_rotation(delta: float)->void:
	var rot_input: float = Input.get_axis(
		"rotate_counter_cw","rotate_cw"
	)
	print(rot_input)
	pivot.rotate_y(rot_input*delta*ROTATION_SPEED)
	
func handle_translation(delta: float) ->void:
	var tr_z: float= Input.get_axis("ui_left","ui_right")
	var tr_x: float= Input.get_axis("ui_down","ui_up")
	
	
	var move_delta:Vector3 =Vector3(tr_x,0,tr_z)*delta*MOVE_SPEED
	
	var new_position: Vector3=pivot.global_position+ move_delta
	new_position.x=clamp(new_position.x,-MOVE_LIMIT,MOVE_LIMIT)
	new_position.z=clamp(new_position.z,-MOVE_LIMIT,MOVE_LIMIT)
	
	pivot.global_position=new_position
	
	
