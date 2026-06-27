extends Node2D
@onready var pausable_nodes = $pausable
@onready var pause_menu = $pause_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") and not get_child(0).get_child(0) is Menu:
		get_tree().paused = !get_tree().paused
		print("paused")
	if get_tree().paused:
		pause_menu.global_position = Vector2(715, 250)
		pause_menu.visible = true
		pause_menu.scale = lerp(pause_menu.scale, Vector2(1.0, 1.0), delta * 3.0)
		pausable_nodes.modulate = Color(0.5, 0.5, 0.5)
	else:
		pause_menu.global_position = Vector2(-825.0, 275.0)
		pause_menu.visible = false
		pause_menu.scale = Vector2(0.1, 0.1)
		pausable_nodes.modulate = Color(1.0, 1.0, 1.0)
	pass
