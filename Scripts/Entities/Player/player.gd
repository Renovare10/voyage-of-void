extends CharacterBody2D


const speed = 300.0
var target_position = position


func _physics_process(delta: float) -> void:
	# Calculate the direction vector from the current position to the target position
	var direction: Vector2 = target_position - global_position

	if direction.length() > 5:
		velocity = direction.normalized() * speed
	else:
		velocity = Vector2.ZERO
		
	# Move character
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		target_position = get_global_mouse_position()
