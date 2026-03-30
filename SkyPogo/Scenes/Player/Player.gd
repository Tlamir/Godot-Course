extends CharacterBody3D

class_name Player

const GRAVITY: float = 15.0
const JUMP_FORCE: float = 14.0
const ROTATION_SPEED: float = 4.0
const MOVE_SPEED: float = 3.5
const LAND_BUFFER: float =1.0
const FALLEN_OFF_TH: float= -18.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var land_effect: AudioStreamPlayer3D = $LandEffect
@onready var fall_effect: AudioStreamPlayer3D = $FallEffect

var min_y_fall: float=10.0
var last_landed: float = -5.0
var _start_height: float = 0.0
var _best_height: float =0.0


func _ready() -> void:
	_start_height=position.y

func _enter_tree() -> void:
	SignalHub.spawner_loaded.connect(_on_spawner_loaded)

func _process(_delta: float) -> void:
	pass

#Invoked every frame 
func _physics_process(delta: float) -> void:
	handle_rotation(delta)
	handle_gravity(delta)
	handle_movement(delta)
	move_and_slide()
	handle_animation()
	handle_sound()
	update_best_height()
	
	


func handle_gravity(delta: float) -> void:
	 #Falling physics then jumping
	if(is_on_floor()):
		velocity.y+=JUMP_FORCE
	elif(!is_on_floor()):
		velocity.y -= GRAVITY*delta
		
func handle_sound()->void:
	if(is_on_floor()):
		if position.y > last_landed:
			land_effect.play()
			last_landed= position.y+LAND_BUFFER
	if velocity.y < min_y_fall:
		min_y_fall=velocity.y
		print(min_y_fall)
	if velocity.y<FALLEN_OFF_TH and !fall_effect.playing:
		fall_effect.play()
			
		
	
func handle_animation() -> void:
	if velocity.y>0:
		animation_player.play("jump")
	else:
		animation_player.play("fall")

func handle_rotation(delta: float)-> void:
	if(Input.is_action_pressed("ui_left")):
		rotate_y(ROTATION_SPEED*delta)
	if(Input.is_action_pressed("ui_right")):
		rotate_y(ROTATION_SPEED*delta*-1)
	pass
func handle_movement(delta: float)-> void:
	var dir: Vector3 =Vector3.ZERO 
	if(Input.is_action_pressed("ui_up")):
		dir=transform.basis.z
	velocity.x=dir.x*MOVE_SPEED
	velocity.z=dir.z*MOVE_SPEED
	pass

func _on_spawner_loaded(y_pos: float)->void:
	last_landed=y_pos-LAND_BUFFER*2
	
func update_best_height() -> void:
	if position.y-_start_height>_best_height:
		_best_height=position.y-_start_height
	
