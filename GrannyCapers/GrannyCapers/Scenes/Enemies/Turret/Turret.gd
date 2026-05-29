extends Node3D

@onready var shoot_timer: Timer = $ShootTimer
@onready var link_player: LinkPlayer = $LinkPlayer
@onready var pivot_point: Node3D = $PivotPoint
@onready var effect: AudioStreamPlayer3D = $Effect
@onready var shoot_point: Marker3D = $PivotPoint/ShootPoint


const BULLET = preload("res://Scenes/Enemies/Turret/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !shoot_timer.paused:
		pivot_point.look_at(
			link_player.granny_pos_set_y(pivot_point.global_position.y)
			)
		

func shoot():
	var nb: Bullet=BULLET.instantiate()
	SignalHub.emit_add_new_scene(nb,shoot_point.global_position)
	print("Turret is Shooting")
	effect.play()
	
func _on_player_detection_body_entered(body: Node3D) -> void:
	shoot_timer.start()


func _on_player_detection_body_exited(body: Node3D) -> void:
	shoot_timer.stop()


func _on_shoot_timer_timeout() -> void:
	shoot()
