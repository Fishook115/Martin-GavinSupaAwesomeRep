class_name Grounded_Enemy extends Enemy
var emerge_tween : Tween 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = Vector3(1.0, 0.001, 1.0)
	emerge_tween = create_tween()
	emerge_tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	emerge_tween.tween_property(self, "scale", Vector3(1.0, 1.0, 1.0), 2.0)
	
	await emerge_tween.finished
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_node_ready():
		pass
