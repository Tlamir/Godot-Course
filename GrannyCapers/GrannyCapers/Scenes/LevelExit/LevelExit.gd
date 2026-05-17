extends Node3D

@onready var label_holder: Node3D = $LabelHolder
@onready var label_key: Label3D = $LabelHolder/LabelKey

var key_collected: bool=false


func _enter_tree() -> void:
	SignalHub.on_key_collected.connect(func():
		key_collected=true
	)

func _ready() -> void:
		label_holder.hide()
		anitmate_label()

func _on_exit_area_body_entered(body: Node3D) -> void:
	if key_collected:
		print("Level Completed")
		SignalHub.on_level_completed.emit()
	else:
		label_holder.show()


func _on_exit_area_body_exited(body: Node3D) -> void:
		if body is Granny:
			label_holder.hide()

func anitmate_label() -> void:
	var tw: Tween =create_tween()
	tw.set_loops()
	tw.tween_property(label_key, "visible",true,0.6)
	tw.tween_property(label_key, "visible",false,0.1)
	
