extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.Area_Cursor = self
	var mouse_position := get_viewport().get_mouse_position()
	if mouse_position:
		var ray_start : Vector3 = get_viewport().get_camera_3d().project_ray_origin(mouse_position)
		var ray_direction : Vector3 = get_viewport().get_camera_3d().project_ray_normal(mouse_position)
		var space_state := get_world_3d().direct_space_state
		var p := PhysicsRayQueryParameters3D.create(ray_start, ray_start + ray_direction * 100.0)
		var surface_detected := space_state.intersect_ray(p)
		if surface_detected:
			show()
			monitorable = true
			monitoring = true
			global_position = surface_detected.position
			var normal = surface_detected.normal
			var fwd = ray_direction.slide(normal)
			var bas = Basis.looking_at(Vector3(1.0, fwd.y, 1.0), Vector3(normal.x, normal.y, normal.z))
			global_basis = bas 
		else:
			hide()
			monitorable = false
			monitoring = false
			global_position = Vector3(0, 0, 0)
