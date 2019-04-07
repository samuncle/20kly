extends Spatial

func _ready():
	set_process(true)
	
func _process(delta):

	if Input.is_action_pressed("on_click"):
		var selected = get_object_under_mouse()
		if len(selected) != 0:
			print(selected["collider"].get_description())

# cast a ray from camera at mouse position, and get the object colliding with the ray
func get_object_under_mouse():
	
	var cam = get_node("Camera")
	
	var RAY_LENGTH = 100
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_from = cam.project_ray_origin(mouse_pos)
	var ray_to = ray_from + cam.project_ray_normal(mouse_pos) * RAY_LENGTH
	var space_state = get_world().direct_space_state
	var selection = space_state.intersect_ray(ray_from, ray_to)
	return selection