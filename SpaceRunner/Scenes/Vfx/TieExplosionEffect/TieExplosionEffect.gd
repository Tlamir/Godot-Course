extends Node3D

@onready var spark: GPUParticles3D = $Spark
@onready var sound: AudioStreamPlayer3D = $Sound

func _ready() -> void:
	spark.emitting=true
	await sound.finished
	queue_free()
