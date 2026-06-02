extends CharacterBody3D

class_name VampireCharacter


@onready var running_effect: AudioStreamPlayer3D = $RunningEffect
@onready var link_player: LinkPlayer = $LinkPlayer
@onready var vampire_model: VampireModel = $VampireModel
@onready var blood_suck_effect: AudioStreamPlayer3D = $BloodSuckEffect

var _gravity: float = 20.0
var _speed: float = 1.5
func _physics_process(delta: float) -> void:
	velocity.y-= _gravity*delta
	if link_player.granny:
		look_at(link_player.granny_pos_set_y(global_position.y))
		var direction = link_player.direction_to_granny(global_position)
		
		if !link_player.granny_too_close(global_position):
			velocity.x = direction.x * _speed
			velocity.z = direction.z* _speed
			vampire_model.play_walk()
		
	move_and_slide()

func _on_running_timer_timeout() -> void:
	running_effect.stop()
	running_effect.play()


func _on_damage_collider_damage_given(amount: int) -> void:
	if !blood_suck_effect.playing:
		blood_suck_effect.play()
