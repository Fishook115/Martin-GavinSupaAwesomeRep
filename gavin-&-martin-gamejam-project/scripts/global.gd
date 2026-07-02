extends Area3D

var Area_Cursor : Area3D
var Music_Node : AudioStreamPlayer
var Spawn_Pop_Display : PackedScene = preload("res://scenes/pop_display.tscn")
var Pop_Display : Label3D
var Pop_Display_Tween : Tween
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

func _Display_Pop(spawn_point : Vector3, value_subtracted, remaining_value):
	print("functioning")
	Pop_Display = Spawn_Pop_Display.instantiate()
	get_tree().current_scene.add_child(Pop_Display)
	Pop_Display.global_position = Vector3(spawn_point.x, spawn_point.y + 4, spawn_point.x)
	Pop_Display.text = str(value_subtracted, " ", remaining_value) 
	#Pop_Display_Tween = create_tween()
	#Pop_Display_Tween.set_parallel()
	#Pop_Display_Tween.set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_SINE)
	#Pop_Display_Tween.tween_property(Pop_Display, "global_position", Vector3(Pop_Display.global_position.x, Pop_Display.global_position.y + 2, Pop_Display.global_position.z), 2.0)
