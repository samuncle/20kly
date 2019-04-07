# Original basically done by Brackeys for Unity : https://www.youtube.com/watch?v=cfjLQrMGEb4
# Converted by Uxilo : https://github.com/Uxilo

# Requires the following actions to be set to work without changes :
# cam_forward (default : W)
# cam_right (default : D)
# cam_back (default : S)
# cam_left (default : A)


extends Node


export var panSpeed = 20.0
export var scrollSpeed = 150
var panBorderThickness = 20.0

# Used to indicate the bounds of the map (for restricted cam movement)
var panLimit = Vector2(35,35)

var m_position

# Minimum/Maximum Cam Height
var minY = 10.0
var maxY = 50.0

# Handles scrolling:
# -1 = down
# 0 = neutral
# 1 = up
var m_scrolling = 0

func _ready():
	set_process(true)
	
func _process(delta):
	camMove(delta)

func _input(e):
	if e is InputEventMouseMotion:
		m_position = e.position
		
	if e is InputEventMouseButton:
		if e.button_index == BUTTON_WHEEL_UP:
			m_scrolling = 1
		elif e.button_index == BUTTON_WHEEL_DOWN:
			m_scrolling = -1
	

	
#Responsible for the camera movement
func camMove(delta):
	if m_position != null:
		if Input.is_action_pressed("cam_forward") || m_position.y <= panBorderThickness:
			self.translation.z -= panSpeed * delta
		if Input.is_action_pressed("cam_right") || m_position.x >= get_viewport().size.x - panBorderThickness:
			self.translation.x += panSpeed * delta
		if Input.is_action_pressed("cam_backward")  || m_position.y >= get_viewport().size.y - panBorderThickness:
			self.translation.z += panSpeed * delta
		if Input.is_action_pressed("cam_left") || m_position.x <= panBorderThickness:
			self.translation.x -= panSpeed * delta
		
		if m_scrolling != 0:
			print(self.get_translation())
			self.translation.y -= scrollSpeed * delta * m_scrolling
			if self.translation.y < 25:
				self.rotation.x += (m_scrolling * 0.08)
			print("p ", self.rotation.x)
			m_scrolling = 0
		
		self.rotation.x = clamp(self.rotation.x, -14, -13.7)
			
		self.translation.x = clamp(self.translation.x, -panLimit.x, panLimit.x)
		self.translation.y = clamp(self.translation.y, minY, maxY)
		self.translation.z = clamp(self.translation.z, -panLimit.y, panLimit.y)
