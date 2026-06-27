class_name three_d_button extends MeshInstance3D
@export var scene_to_select : PackedScene
@export var area_to_select : PackedScene
@export var path_follower_to_move : PathFollow3D
@export var progress_for_follower_to_tween_to : float
@export var progress_tween_time : float
@export var exit_to_desktop : bool
var static_body
var area : Area3D
var follower_tween : Tween
var idle_tween : Tween
var rotation_anchor : Vector3
var collision_shape : CollisionShape3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation_anchor = rotation
	if mesh:
		create_convex_collision()
		await get_tree().process_frame
		area = Area3D.new()
		add_child(area)
		if get_child_count() == 2:
			collision_shape = get_child(0).get_child(0)
			#print("no children")
		if get_child_count() == 3:
			collision_shape = get_child(1).get_child(0)
			#print("one child")
		area.add_child(collision_shape.duplicate())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if area and Global.Area_Cursor:
		if area.overlaps_area(Global.Area_Cursor):
			if Input.is_action_just_released("primary_mouse"):
				#print("working")
				if scene_to_select:
					Global._Change_Scene(scene_to_select)
				if area_to_select:
					Global._Change_Area(area_to_select)
				if path_follower_to_move:
					follower_tween = create_tween()
					follower_tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
					follower_tween.tween_property(path_follower_to_move, "progress", progress_for_follower_to_tween_to, progress_tween_time)
				if exit_to_desktop:
					get_tree().quit()
			if Input.is_action_pressed("primary_mouse"):
				scale = lerp(scale, Vector3(1.3, 1.3, 1.3), delta * 3)
			else:
				scale = lerp(scale, Vector3(1.1, 1.1, 1.1), delta * 3)
		else:
			scale = lerp(scale, Vector3(1.0, 1.0, 1.0), delta * 3)
	if not idle_tween or not idle_tween.is_running():
		idle_tween = create_tween()
		idle_tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
		idle_tween.tween_property(self, "rotation_degrees", Vector3(rotation_anchor.x + randf_range(-15, 15), rotation_anchor.y + randf_range(-15, 15), rotation_anchor.z + randf_range(-15, 15)), randf_range(2, 4))
