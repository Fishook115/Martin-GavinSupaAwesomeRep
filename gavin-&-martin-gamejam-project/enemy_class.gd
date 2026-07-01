class_name Enemy extends CharacterBody3D
var health : float = 5
var speed : float = 6
var damage : float = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_node_ready():
		_movement_logic()
	pass

func _movement_logic():
	pass
