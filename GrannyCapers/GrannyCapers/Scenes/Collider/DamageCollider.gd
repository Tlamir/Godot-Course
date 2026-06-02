@tool
extends Collider

class_name DamageCollider

signal damage_given (amount: int)

@export_category("Damage")
## Amount of damage dealt
@export var damage_amount: int =10
## Explosion 
@export var explodes_on_hit: bool = true
## Die on hit
@export var dies_on_hit: bool =true


func get_damage() -> int:
	return damage_amount
	
func apply_impact_effects():
	damage_given.emit(damage_amount)
	if dies_on_hit:
		GrannyUtils.print_with_parent(self,"DamageCollider dies_on_hit()")
		die()
	if explodes_on_hit:
		GrannyUtils.print_with_parent(self,"DamageCollider explodes_on_hit()")
		SignalHub.emit_add_new_explosion(global_position)
		
	
func _on_area_entered(_area: Area3D) -> void:
	GrannyUtils.print_with_parent(self,"DamageCollider _on_area_entered()")
	apply_impact_effects()

func _on_body_entered(body: Node3D) -> void:
	apply_impact_effects()
