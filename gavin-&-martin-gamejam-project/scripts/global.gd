extends Area3D

var Area_Cursor : Area3D
var Music_Node : AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _Change_Area(area_to_change_to : PackedScene):
	var fade_out_tween = create_tween()
	fade_out_tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	fade_out_tween.tween_property(get_tree().current_scene, "modulate", Color(0.0, 0.0, 0.0), 2.0)
	await fade_out_tween.finished
	get_tree().current_scene.get_child(0).get_child(0).queue_free()
	get_tree().current_scene.get_child(0).add_child(area_to_change_to.instantiate())
	get_tree().current_scene.get_child(0).move_child(get_tree().current_scene.get_child(0).get_child(-1), 0)
	await get_tree().process_frame
	#for i in get_tree().current_scene.get_child(0).get_children():
		#print(i.name)
	var fade_in_tween = create_tween()
	fade_in_tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	fade_in_tween.tween_property(get_tree().current_scene, "modulate", Color(1.0, 1.0, 1.0), 2.0)
