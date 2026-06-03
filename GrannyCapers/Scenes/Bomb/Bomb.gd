extends Node3D

class_name Bomb



@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var trigger: Area3D = $Trigger
@onready var explode_sound: AudioStreamPlayer3D = $ExplodeSound
@onready var damage_collider: DamageCollider = $DamageCollider


func _ready() -> void:
	damage_collider.disable()


func explode() -> void:
	explode_sound.play()
	SignalHub.on_add_new_explosion.emit(global_position)



func _on_trigger_body_entered(body: Node3D) -> void:
	trigger.body_entered.disconnect(_on_trigger_body_entered)
	animation_player.play("bang")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	damage_collider.enable()
	await get_tree().physics_frame
	await get_tree().physics_frame	
	damage_collider.disable()


func _on_explode_sound_finished() -> void:
	queue_free()
