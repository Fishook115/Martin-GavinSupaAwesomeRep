extends CharacterBody3D

@export var speed : float = 10.0
@export var acceleration : float = 2.0
@export var jump_velocity : float = 4.5
var rot_x = 0
var rot_y = 0
var sensitivity : float = 0.02
var pivot_point
var direction
@onready var camera_pivoting_point = $camera_pivoting_point
@onready var camera : Camera3D = $camera_pivoting_point/Camera3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	direction = (camera_pivoting_point.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		print("working")
		print("rot_x: ", rot_x)
		rot_x += -event.relative.x * sensitivity
		rot_y += event.relative.y * sensitivity
		camera_pivoting_point.transform.basis = Basis() # reset rotation
		camera_pivoting_point.rotate_object_local(Vector3(0, 1, 0), rot_x) # first rotate in Y
		camera_pivoting_point.rotate_object_local(Vector3(-1, 0, 0), rot_y) # then rotate in X
		camera_pivoting_point.rotation.x = clamp(camera_pivoting_point.rotation.x, deg_to_rad(-50), deg_to_rad(50))
