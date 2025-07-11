# Zoom_Pan_Camera.gd
extends Camera2D

const ZOOM_SPEED = 0.1
const MIN_ZOOM = 0.6
const MAX_ZOOM = 4.0

var PAN_SPEED = 1.0
var PAN_LIMIT_X = 1000 # Max distance from center on X-axis
var PAN_LIMIT_Y = 500 # Max distance from center on Y-axis

var panning = false
var pan_start_position = Vector2.ZERO
var camera_start_position = Vector2.ZERO

func _ready():
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom.x = min(zoom.x + ZOOM_SPEED, MAX_ZOOM)
			zoom.y = min(zoom.y + ZOOM_SPEED, MAX_ZOOM)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom.x = max(zoom.x - ZOOM_SPEED, MIN_ZOOM)
			zoom.y = max(zoom.y - ZOOM_SPEED, MIN_ZOOM)
		elif event.button_index == MOUSE_BUTTON_MIDDLE:
			if event.pressed:
				panning = true
				pan_start_position = event.position
				camera_start_position = position
			else:
				panning = false

	elif event is InputEventMouseMotion and panning:
		var mouse_delta = event.position - pan_start_position
		var new_camera_pos = camera_start_position - (mouse_delta * PAN_SPEED / zoom)

		# Clamp new camera position to square limits
		new_camera_pos.x = clamp(new_camera_pos.x, -PAN_LIMIT_X, PAN_LIMIT_X)
		new_camera_pos.y = clamp(new_camera_pos.y, -PAN_LIMIT_Y, PAN_LIMIT_Y)

		position = new_camera_pos
