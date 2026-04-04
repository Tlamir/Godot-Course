extends Node3D

@onready var pivot: Node3D = $Pivot
@onready var brick_mesh: MeshInstance3D = $Pivot/BrickMesh
@onready var timer: Timer = $Timer

const  ROTATION_SPEED: float = 4.0
const  MOVE_SPEED: float = 2.0
const LIFT_SPEED: float= 5.0

const MOVE_LIMIT: float =2.5
const PIVOT_LIMIT:float=1.0

const NUMBER_PER_LEVEL: int =3
const SPAWN_RED_MULT: float = 0.1

var _spawn_time:float=8.0
var _start_y:float=0.0
var _highest_y:float=0.0
var _level: int =0

func _unhandled_input(event: InputEvent) -> void:
	if !timer.is_stopped() and event.is_action_pressed("drop_brick"):
		timer.stop()
		drop_brick()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start_y=position.y
	SignalHub.on_brick_landed.connect(on_brick_landed)
	SignalHub.on_game_over.connect(on_game_over)
	call_deferred("late_init")
	
func late_init()->void:
	SignalHub.emit_on_brick_landed(0)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if brick_mesh.visible:
		handle_rotation(delta)
		handle_translation(delta)
	position.y = lerp(position.y,_start_y+_highest_y,delta*LIFT_SPEED)

func on_brick_landed(y_position: float) ->void:
	print("Spawner Brick Landed")
	raise_pivot(y_position)
	random_place_pivot()
	show_brick()
	start_timer()
	
	
func on_game_over() -> void:
	print("Spawner Game Over")

func handle_rotation(delta: float)->void:
	var rot_input: float = Input.get_axis(
		"rotate_counter_cw","rotate_cw"
	)
	pivot.rotate_y(rot_input*delta*ROTATION_SPEED)
	
func handle_translation(delta: float) ->void:
	var tr_z: float= Input.get_axis("ui_left","ui_right")
	var tr_x: float= Input.get_axis("ui_down","ui_up")
	
	
	var move_delta:Vector3 =Vector3(tr_x,0,tr_z)*delta*MOVE_SPEED
	
	var new_position: Vector3=pivot.global_position+ move_delta
	new_position.x=clamp(new_position.x,-MOVE_LIMIT,MOVE_LIMIT)
	new_position.z=clamp(new_position.z,-MOVE_LIMIT,MOVE_LIMIT)
	
	pivot.global_position=new_position
	
func random_place_pivot()->void:
	pivot.rotation_degrees=Vector3(0,randf_range(0,360),0)
	pivot.position.x=randf_range(-PIVOT_LIMIT,PIVOT_LIMIT)
	pivot.position.z=randf_range(-PIVOT_LIMIT,PIVOT_LIMIT)
	
func raise_pivot(y_position: float) -> void:
	if y_position>_highest_y: _highest_y = y_position
	
func start_timer()->void:
	if GameState.bricks_landed % NUMBER_PER_LEVEL == 0 :
		_spawn_time-=SPAWN_RED_MULT*_spawn_time
		_level+=1
		SignalHub.emit_on_new_level(_level,_spawn_time)
	print("hee",_spawn_time)
	timer.wait_time=_spawn_time
	timer.start()
func show_brick()->void:
	brick_mesh.show()
func drop_brick()->void:
	SignalHub.emit_on_brick_dropped(brick_mesh.global_transform)
	brick_mesh.hide()

func _on_timer_timeout() -> void:
	drop_brick()
