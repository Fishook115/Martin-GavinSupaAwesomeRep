extends CharacterBody3D

@export var speed : float = 10.0
@export var acceleration : float = 2.0
@export var jump_velocity : float = 4.5
@export var gun_damage : float = 3.0
var rot_x = 0
var rot_y = 0
var sensitivity : float = 0.005
var pivot_point
var direction
var can_shoot : bool = true
@onready var camera_pivoting_point = $camera_pivoting_point
@onready var camera : Camera3D = $camera_pivoting_point/Camera3D
@onready var camera_ray : SpringArm3D = $camera_pivoting_point/Camera3D/SpringArm3D
@onready var gun_area : Area3D = $camera_pivoting_point/Camera3D/gun_area
@onready var three_d_player : AnimationPlayer = $"3dplayer"
@onready var gun_shot : AudioStreamPlayer3D = $camera_pivoting_point/gun_aiming_pivoting_point/gun_animation_pivoting_point/gun_end/gun_shot
@onready var gun_aiming_pivoting_point : Node3D = $camera_pivoting_point/gun_aiming_pivoting_point
@onready var spring_hit_object : MeshInstance3D = $camera_pivoting_point/Camera3D/SpringArm3D/MeshInstance3D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass

func _physics_process(delta: float) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_movement_logic(delta)
	_gun_logic(delta)
	_chain_logic(delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#print("working")
		#print("rot_x: ", rot_x)
		rot_x += -event.relative.x * sensitivity
		rot_y += event.relative.y * sensitivity
		if rot_y > deg_to_rad(50):
			rot_y = deg_to_rad(50)
		if rot_y < deg_to_rad(-50):
			rot_y = deg_to_rad(-50)
		camera_pivoting_point.transform.basis = Basis() # reset rotation
		camera_pivoting_point.rotate_object_local(Vector3(0, 1, 0), rot_x) # first rotate in Y
		camera_pivoting_point.rotate_object_local(Vector3(-1, 0, 0), rot_y) # then rotate in X

func _movement_logic(delta):
	camera_pivoting_point.rotation.x = clamp(camera_pivoting_point.rotation.x, deg_to_rad(-50), deg_to_rad(50))
	rotation.z = 0
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

func _gun_logic(delta):
	gun_aiming_pivoting_point.look_at(spring_hit_object.global_position)
	if Input.is_action_pressed("primary_mouse"):
		camera.fov = lerp(camera.fov, 45.0, delta * 3)
	else:
		camera.fov = lerp(camera.fov, 75.0, delta * 3)

	if Input.is_action_just_released("primary_mouse") and can_shoot:
		gun_shot.play()
		three_d_player.play("shoot")
		if gun_area.has_overlapping_bodies():
			for body in gun_area.get_overlapping_bodies():
				print("hit: ", body.name)
				body.new_health -= gun_damage
		can_shoot = false

	if Input.is_action_pressed("secondary_mouse"):
		#WORK ON THIS
		pass
func _chain_logic(delta):
	pass

func _on_dplayer_animation_finished(anim_name: StringName) -> void:
	if anim_name == "shoot":
		can_shoot = true
	pass # Replace with function body.
