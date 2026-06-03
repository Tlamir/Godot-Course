extends Node3D



@onready var link_player: LinkPlayer = $LinkPlayer
@onready var effects: AudioStreamPlayer3D = $Effects

@export var chase_distance: float = 5.0
@export var speed : float =2.0
@export var frozen_limit: float = 3.0
@export var teleport_radius: float =10.0

const GHOST = preload("res://Assets/Models/30_GHOST/ghost.wav")
const EXIT = preload("res://Assets/Models/30_GHOST/exit.wav")
@onready var label_debug: Label3D = $LabelDebug



var _on_screen: bool = false
var _frozen_timer: float=0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !link_player.granny:
		return
	look_at(link_player.granny_pos)
	
	var distance_to_player: float = global_position.distance_to(link_player.granny_pos)
	var direction: Vector3 = link_player.direction_to_granny(global_position)
	var close_enaugh: bool = distance_to_player < chase_distance
	var should_chase: bool =!_on_screen or (_on_screen and close_enaugh)
	look_at(link_player.granny_pos_set_y(global_position.y))
	if should_chase:
		_frozen_timer=0.0
		position.x += direction.x*speed*delta
		position.z += direction.z*speed*delta
	else:
		_frozen_timer+= delta
		if _frozen_timer>= frozen_limit:
			teleport()
			
			
	label_debug.text="timer:%.1f\ndistance:%.1f\non_screen: %s\nchase: %s"%[
		_frozen_timer,distance_to_player,str(_on_screen),str(should_chase)
	]
func teleport():
	var random_offset = Vector3(
		randf_range(-teleport_radius, teleport_radius),
		0,
		randf_range(-teleport_radius,teleport_radius)
	)
	global_position+=random_offset
	_frozen_timer=0.0
	GrannyUtils.play_clip(effects,EXIT)
	


func _on_screen_notify_screen_entered() -> void:
	_on_screen = true
	GrannyUtils.play_clip(effects,GHOST)
	print("BOOOOOOOOO")


func _on_screen_notify_screen_exited() -> void:
		_on_screen = false
