extends Control

var show_shape: bool = false
var click_pos: Vector2 = Vector2.ZERO

func _gui_input(event: InputEvent) -> void:
	print("GUI Input: ", event)  # Debug
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		click_pos = event.position
		show_shape = true
		print("Click at: ", click_pos)  # Debug
		queue_redraw()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		show_shape = false
		queue_redraw()

func _draw() -> void:
	print("Draw called!")  # Debug
	if show_shape:
		draw_circle(click_pos, 20.0, Color.RED)  # Circle at click
