class_name Enemy extends CharacterBody3D
var new_health : float
var true_health : float = 5
var subtracted_health : float
var speed : float = 6
var damage : float = 10
var wave_value : float = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_health = true_health
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#THIS IS BROKEN, FIX THIS
	if not new_health == true_health:
		print("functioning")
		subtracted_health = true_health - new_health 
		Global._Display_Pop(self.global_position, subtracted_health, new_health)
		true_health = new_health
	if true_health <= 0:
		queue_free()
	if is_node_ready():
		_movement_logic()
	pass

func _movement_logic():
	move_and_slide()
	pass
