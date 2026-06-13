extends Area3D

class_name Laser


@export var damage: int = 10
@export var speed: float = 80.0


@onready var impact_point: Marker3D = $ImpactPoint
@onready var life_timer: LifeTimer = $LifeTimer

func get_damage() -> int:
	return damage
	
func _ready() -> void:
	life_timer.start_timer()
	
func _physics_process(delta: float) -> void:
	translate(Vector3.FORWARD * speed * delta)
	

func blow_up() -> void:
	SignalHub.emit_create_one_off(impact_point.global_position, Spawner.SceneNames.ImpactFlash)
	queue_free()

func _on_area_entered(_area: Area3D) -> void:
	blow_up()


func _on_body_entered(_body: Node3D) -> void:
	blow_up()


func _on_life_timer_time_out() -> void:
	print("Laser: _on_life_timer_time_out")
	queue_free()
