extends Grounded_Enemy
func _ready() -> void:
	true_health = 10
	super()

func _physics_process(delta: float) -> void:
	super(delta)
