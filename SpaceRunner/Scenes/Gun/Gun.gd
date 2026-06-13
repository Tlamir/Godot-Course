extends Node3D

class_name Gun

const GUN_FLASH = preload("res://Scenes/Vfx/GunFlash/GunFlash.tscn")

@export var debounce: float = 0.1
@export var muzzles: Array[Node3D]
@export var sound_effect: AudioStream
@export var laser_type: Spawner.LaserTypes = Spawner.LaserTypes.PlayerLaser


@onready var effects: AudioStreamPlayer3D = $Effects


var _timer: float = 0.0
var _gun_flashes: Array[GPUParticles3D]


func _ready() -> void:
	effects.stream = sound_effect
	for m in muzzles:
		var gf: GPUParticles3D = GUN_FLASH.instantiate()
		m.add_child(gf)
		_gun_flashes.append(gf)


func _process(delta: float) -> void:
	_timer += delta

func shoot() -> void:
	if _timer > debounce:
		SignalHub.emit_create_laser(muzzles[0].global_transform,laser_type)
		SignalHub.emit_create_laser(muzzles[1].global_transform,laser_type)
		play_shoot_effect()
		_timer = 0.0
		
func play_shoot_effect():
	effects.play()
	for gf in _gun_flashes:
		gf.emitting = true
		
