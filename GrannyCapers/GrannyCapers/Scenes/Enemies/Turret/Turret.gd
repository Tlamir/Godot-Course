extends Node3D

@onready var shoot_timer: Timer = $ShootTimer
@onready var link_player: LinkPlayer = $LinkPlayer
@onready var pivot_point: Node3D = $PivotPoint
@onready var effect: AudioStreamPlayer3D = $Effect

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
	print("Shooting")
	effect.play()
	
func _on_player_detection_body_entered(body: Node3D) -> void:
	shoot_timer.start()


func _on_player_detection_body_exited(body: Node3D) -> void:
	shoot_timer.stop()


func _on_shoot_timer_timeout() -> void:
	shoot()
